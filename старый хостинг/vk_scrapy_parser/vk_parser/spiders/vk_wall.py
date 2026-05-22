"""
Scrapy-спайдер для парсинга стены публичной группы ВКонтакте.

Принцип работы:
  1) Заходим на https://vk.com/<screen_name> и достаём числовой group_id из HTML
     (VK сам выдаёт его в bootstrap-JSON, например "group_id":186869747).
  2) Заходим на https://vk.com/wall-<group_id> — десктопная стена возвращает
     ПОЛНОЦЕННЫЙ HTML без авторизации (нужен только реалистичный User-Agent).
  3) В каждом блоке поста (<div id="post-OWNER_POSTID">) лежат несколько
     <... data-exec="..."> атрибутов. Один из них — JSON вида
     {"PostContentContainer/init":{"item":{...}}} — это полный объект поста
     с `text`, `attachments[]`, `date`, `id`, `owner_id`, `copy_history[]`.
  4) Для каждого фото берём максимальный размер из item.attachments[].photo.sizes
     или photo.orig_photo.url. Передаём в PhotoDownloadPipeline.

Важно:
  * VK десктопная страница отдаётся в windows-1251. Указываем encoding явно,
    иначе Scrapy получит мусор.
  * SPA для нас здесь не нужен, поскольку bootstrap-JSON всё равно встраивается
    в HTML — это нужно React'у при гидратации.
"""
from __future__ import annotations

import html as html_lib
import json
import re
from typing import Iterable, Optional

import scrapy

from ..items import VkPostItem


class VkWallSpider(scrapy.Spider):
    name = "vk_wall"

    # Регексы для извлечения id группы из bootstrap-JSON на странице vk.com/<screen_name>
    _RE_GROUP_ID = re.compile(r'"group_id":\s*(\d+)')
    _RE_PUBLIC_ID = re.compile(r'public(\d+)|club(\d+)')
    # Один пост на стене
    _RE_POST_BLOCK = re.compile(
        r'(<div[^>]+id="post-(\d+_\d+)"[^>]*>.+?)(?=<div[^>]+id="post-|<div[^>]+class="page_block_h_clear)',
        re.DOTALL,
    )
    # data-exec в HTML — атрибут с экранированным JSON
    _RE_DATA_EXEC = re.compile(r'data-exec="([^"]+)"')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._group_arg: Optional[str] = None  # переопределяется в from_crawler

    @classmethod
    def from_crawler(cls, crawler, *args, **kwargs):
        spider = super().from_crawler(crawler, *args, **kwargs)
        spider._group_arg = crawler.settings.get("VK_GROUP", "media_ak")
        spider._fetch_count = int(crawler.settings.get("VK_FETCH_COUNT", 20))
        spider._min_text_len = int(crawler.settings.get("VK_MIN_TEXT_LENGTH", 30))
        spider._max_photos = int(crawler.settings.get("VK_MAX_PHOTOS_PER_POST", 10))
        return spider

    # ──────────────────────────────────────────────────────────────────────
    # Запросы
    # ──────────────────────────────────────────────────────────────────────
    def start_requests(self) -> Iterable[scrapy.Request]:
        group = (self._group_arg or "media_ak").strip()
        # Если уже задан числовой owner_id (со знаком -) — пропускаем шаг резолвинга
        if re.fullmatch(r"-?\d+", group):
            owner_id = int(group)
            if owner_id > 0:
                owner_id = -owner_id
            yield self._build_wall_request(owner_id)
            return

        # Иначе сначала идём на vk.com/<screen_name>, чтобы узнать group_id
        url = f"https://vk.com/{group}"
        yield scrapy.Request(
            url=url,
            callback=self._parse_group_landing,
            cb_kwargs={"screen_name": group},
            dont_filter=True,
            encoding="windows-1251",
        )

    def _build_wall_request(self, owner_id: int) -> scrapy.Request:
        # owner_id отрицательный для группы → URL вида /wall-186869747
        # offset мы не используем — берём всегда первую страницу (последние ~30 постов)
        url = f"https://vk.com/wall{owner_id}"
        return scrapy.Request(
            url=url,
            callback=self._parse_wall,
            cb_kwargs={"owner_id": owner_id},
            dont_filter=True,
            encoding="windows-1251",
        )

    # ──────────────────────────────────────────────────────────────────────
    # Резолвим короткое имя группы → числовой owner_id
    # ──────────────────────────────────────────────────────────────────────
    def _parse_group_landing(self, response: scrapy.http.Response, screen_name: str):
        text = response.text  # уже в правильной кодировке
        m = self._RE_GROUP_ID.search(text)
        gid = int(m.group(1)) if m else None
        if not gid:
            m2 = self._RE_PUBLIC_ID.search(text)
            if m2:
                gid = int(m2.group(1) or m2.group(2))
        if not gid:
            self.logger.error(
                "Не удалось определить group_id для '%s' (страница %s)",
                screen_name, response.url,
            )
            return
        self.logger.info("Резолвлен group_id для '%s' → %d", screen_name, gid)
        yield self._build_wall_request(-gid)

    # ──────────────────────────────────────────────────────────────────────
    # Парсинг стены
    # ──────────────────────────────────────────────────────────────────────
    def _parse_wall(self, response: scrapy.http.Response, owner_id: int):
        html_text = response.text
        # Каждый пост — отдельный <div id="post-OWNER_POSTID">…</div>
        blocks = self._RE_POST_BLOCK.findall(html_text)
        if not blocks:
            self.logger.warning("На стене %s не найдено ни одного поста (anti-bot?)", response.url)
            return
        self.logger.info("Найдено постов на стене: %d", len(blocks))

        seen_ids: set[int] = set()
        emitted = 0
        for block_html, post_full_id in blocks:
            if emitted >= self._fetch_count:
                break

            # Берём ТОЛЬКО посты, владельцем которых является целевая группа,
            # игнорируя репосты от других сообществ (посты вида data-post-id="-OTHER_OWNER_postid")
            try:
                post_owner_str, post_id_str = post_full_id.split("_", 1)
                post_owner = int(post_owner_str)
                post_id = int(post_id_str)
            except ValueError:
                continue
            # post-186869747_2589 — owner здесь без знака минуса. Сравниваем с abs(owner_id).
            if post_owner != abs(owner_id):
                continue
            if post_id in seen_ids:
                continue
            seen_ids.add(post_id)

            item_data = self._extract_post_data(block_html)
            if item_data is None:
                continue

            text = (item_data.get("text") or "").strip()
            # Если у поста пустой текст — пробуем взять текст из первого репоста (copy_history)
            copy_history = item_data.get("copy_history") or []
            if not text and copy_history:
                first = copy_history[0]
                if isinstance(first, dict):
                    text = (first.get("text") or "").strip()

            text_clean = self._clean_text(text)
            if len(text_clean) < self._min_text_len:
                self.logger.debug("post %d: пропуск (короткий текст: %d симв)", post_id, len(text_clean))
                continue

            # Собираем фото из основного поста + из copy_history
            photo_urls = self._collect_photos(item_data, self._max_photos)

            published_ts = int(item_data.get("date") or 0)
            title = self._extract_title(text_clean)

            yield VkPostItem(
                vk_owner_id=owner_id,
                vk_post_id=post_id,
                vk_post_url=f"https://vk.com/wall{owner_id}_{post_id}",
                title=title,
                content=text_clean,
                photo_urls=photo_urls,
                vk_published_at=published_ts,
            )
            emitted += 1

    # ──────────────────────────────────────────────────────────────────────
    # Извлечение JSON-объекта поста из data-exec атрибутов
    # ──────────────────────────────────────────────────────────────────────
    def _extract_post_data(self, block_html: str) -> Optional[dict]:
        """Возвращает dict 'item' (тело поста) из PostContentContainer/init JSON,
        либо None если ничего не нашли."""
        for raw in self._RE_DATA_EXEC.findall(block_html):
            decoded = html_lib.unescape(raw)
            if "PostContentContainer" not in decoded:
                continue
            try:
                payload = json.loads(decoded)
            except json.JSONDecodeError:
                continue
            init = payload.get("PostContentContainer/init")
            if not isinstance(init, dict):
                continue
            item = init.get("item")
            if isinstance(item, dict) and ("text" in item or "attachments" in item):
                return item
        return None

    # ──────────────────────────────────────────────────────────────────────
    # Очистка текста / заголовок
    # ──────────────────────────────────────────────────────────────────────
    @staticmethod
    def _clean_text(text: str) -> str:
        if not text:
            return ""
        # <br>, <br/>, <br /> → \n
        text = re.sub(r"<br\s*/?>", "\n", text, flags=re.IGNORECASE)
        # Убираем оставшиеся HTML-теги
        text = re.sub(r"<[^>]+>", "", text)
        # [id123|Имя] и [club123|Имя] → Имя
        text = re.sub(r"\[(?:id|club|public)\d+\|([^\]]+)\]", r"\1", text)
        # HTML-entity
        text = html_lib.unescape(text)
        # Стянуть 3+ переноса до двух
        text = re.sub(r"(\r?\n){3,}", "\n\n", text)
        return text.strip()

    @staticmethod
    def _extract_title(text: str) -> str:
        if not text:
            return "Новость из VK"
        # Берём первую непустую строку
        for line in text.splitlines():
            line = line.strip()
            if line:
                first = line
                break
        else:
            first = text.strip()

        # Если строка длиннее 80 символов — пытаемся обрезать по знаку препинания
        if len(first) > 80:
            cut = first[:120]
            m = re.match(r"^(.+?[.!?])\s", cut)
            if m:
                first = m.group(1)
            else:
                first = first[:77].rstrip() + "…"
        return first[:250]

    # ──────────────────────────────────────────────────────────────────────
    # Фото: достаём максимально качественные из всех вложений (включая репосты)
    # ──────────────────────────────────────────────────────────────────────
    def _collect_photos(self, item: dict, limit: int) -> list[str]:
        urls: list[str] = []

        def visit(node: dict):
            atts = node.get("attachments") or []
            if isinstance(atts, list):
                for att in atts:
                    if not isinstance(att, dict):
                        continue
                    if att.get("type") != "photo":
                        continue
                    photo = att.get("photo") or {}
                    best = self._pick_best_photo_url(photo)
                    if best:
                        urls.append(best)
            ch = node.get("copy_history") or []
            if isinstance(ch, list):
                for c in ch:
                    if isinstance(c, dict):
                        visit(c)

        visit(item)

        # Уникализируем, сохраняя порядок
        seen = set()
        unique = []
        for u in urls:
            if u not in seen:
                seen.add(u)
                unique.append(u)
        return unique[:limit]

    @staticmethod
    def _pick_best_photo_url(photo: dict) -> str:
        # Сначала пытаемся взять orig_photo (чаще всего самое большое)
        orig = photo.get("orig_photo")
        if isinstance(orig, dict) and orig.get("url"):
            return str(orig["url"])
        sizes = photo.get("sizes") or []
        if not isinstance(sizes, list) or not sizes:
            return ""
        best_url = ""
        best_area = 0
        for s in sizes:
            if not isinstance(s, dict):
                continue
            url = s.get("url") or s.get("src") or ""
            w = int(s.get("width") or 0)
            h = int(s.get("height") or 0)
            area = max(1, w * h)
            if url and area > best_area:
                best_area = area
                best_url = str(url)
        return best_url
