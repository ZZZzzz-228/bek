"""
Scrapy pipelines:
  1. PhotoDownloadPipeline   — скачивает все фото из item.photo_urls и сохраняет
                                в /api/public/uploads/. Заполняет item.saved_image_paths
                                (массив URL-ов вида "/api/public/uploads/vk_xxx.jpg").
  2. MysqlInsertPipeline     — пишет item в таблицу vk_pending_stories (INSERT IGNORE),
                                ведёт лог запусков в vk_parser_runs.
"""
from __future__ import annotations

import json
import logging
import os
import secrets
import time
from datetime import datetime, timezone
from typing import Optional

import pymysql
import scrapy
from scrapy.exceptions import DropItem
from twisted.internet.defer import inlineCallbacks, returnValue

from .items import VkPostItem


# ============================================================================
# Pipeline #1 — скачивание фото
# ============================================================================
class PhotoDownloadPipeline:
    """Не скачивает фото локально — просто прокидывает VK CDN-ссылки в БД.
    Это решает проблему накопления файлов на диске хостинга.
    """

    @classmethod
    def from_crawler(cls, crawler):
        return cls()

    def process_item(self, item, spider):
        if isinstance(item, VkPostItem):
            # Просто копируем внешние URL — без скачивания на диск
            item.saved_image_paths = list(item.photo_urls)
        return item


# ============================================================================
# Pipeline #2 — запись в MySQL
# ============================================================================
class MysqlInsertPipeline:
    """Пишет item в таблицу vk_pending_stories. Дубли игнорируются благодаря
    UNIQUE-индексу (vk_owner_id, vk_post_id) + INSERT IGNORE.
    """

    def __init__(self, mysql_cfg: dict):
        self.cfg = mysql_cfg
        self.conn: Optional[pymysql.connections.Connection] = None
        self.logger = logging.getLogger(self.__class__.__name__)
        self.added = 0
        self.skipped = 0
        self.fetched = 0
        self.run_id: Optional[int] = None
        self.error_message: Optional[str] = None

    @classmethod
    def from_crawler(cls, crawler):
        return cls(mysql_cfg=crawler.settings.getdict("MYSQL"))

    def open_spider(self, spider):
        try:
            self.conn = pymysql.connect(
                host=self.cfg["host"],
                port=int(self.cfg.get("port", 3306)),
                user=self.cfg["user"],
                password=self.cfg["password"],
                database=self.cfg["database"],
                charset=self.cfg.get("charset", "utf8mb4"),
                autocommit=True,
                connect_timeout=10,
            )
        except Exception as exc:
            self.logger.error("Не удалось подключиться к MySQL: %s", exc)
            raise

        # Создаём запись в журнале запусков
        with self.conn.cursor() as cur:
            cur.execute(
                "INSERT INTO vk_parser_runs (started_at) VALUES (UTC_TIMESTAMP())"
            )
            self.run_id = cur.lastrowid
        self.logger.info("vk_parser_runs.id=%s — старт", self.run_id)

    def close_spider(self, spider):
        if not self.conn:
            return
        status = "error" if self.error_message else "ok"
        try:
            with self.conn.cursor() as cur:
                cur.execute(
                    """
                    UPDATE vk_parser_runs
                       SET finished_at  = UTC_TIMESTAMP(),
                           fetched_total = %s,
                           added_new     = %s,
                           skipped_dup   = %s,
                           status        = %s,
                           message       = %s
                     WHERE id = %s
                    """,
                    (self.fetched, self.added, self.skipped, status,
                     (self.error_message or "")[:1000], self.run_id),
                )
        except Exception as exc:
            self.logger.warning("Не удалось обновить vk_parser_runs: %s", exc)
        finally:
            self.conn.close()
        self.logger.info(
            "vk_parser_runs.id=%s — финиш: fetched=%d added=%d skipped=%d status=%s",
            self.run_id, self.fetched, self.added, self.skipped, status,
        )

    def process_item(self, item: VkPostItem, spider):
        if not isinstance(item, VkPostItem):
            return item
        self.fetched += 1
        try:
            published_dt = datetime.fromtimestamp(item.vk_published_at, tz=timezone.utc)
            published_str = published_dt.strftime("%Y-%m-%d %H:%M:%S")
        except (OverflowError, ValueError, OSError):
            published_str = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")

        images_json = json.dumps(item.saved_image_paths or [], ensure_ascii=False)
        selected_image = 0 if item.saved_image_paths else -1

        try:
            with self.conn.cursor() as cur:
                cur.execute(
                    """
                    INSERT IGNORE INTO vk_pending_stories
                        (vk_owner_id, vk_post_id, vk_post_url, title, content,
                         images_json, selected_image, vk_published_at, status)
                    VALUES
                        (%s, %s, %s, %s, %s, %s, %s, %s, 'pending')
                    """,
                    (
                        item.vk_owner_id,
                        item.vk_post_id,
                        item.vk_post_url,
                        (item.title or "")[:250],
                        item.content,
                        images_json,
                        selected_image,
                        published_str,
                    ),
                )
                if cur.rowcount == 1:
                    self.added += 1
                    self.logger.info(
                        "ДОБАВЛЕНО: post=%d title=%r photos=%d",
                        item.vk_post_id, (item.title or "")[:60], len(item.saved_image_paths or []),
                    )
                else:
                    self.skipped += 1
                    self.logger.debug("дубликат: post=%d", item.vk_post_id)
        except Exception as exc:
            self.error_message = f"INSERT failed for post {item.vk_post_id}: {exc}"
            self.logger.exception("Ошибка INSERT для post=%d", item.vk_post_id)
            raise DropItem(self.error_message)
        return item
