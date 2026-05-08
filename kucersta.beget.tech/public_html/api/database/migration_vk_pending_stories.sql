-- ============================================================================
-- Миграция: таблица «предложка» для постов из ВК
-- Применять через phpMyAdmin (Beget → Базы данных → SQL) ИЛИ через apply_vk_migration.php
-- ============================================================================

CREATE TABLE IF NOT EXISTS vk_pending_stories (
  id              BIGINT AUTO_INCREMENT PRIMARY KEY,
  vk_owner_id     BIGINT       NOT NULL,
  vk_post_id      BIGINT       NOT NULL,
  vk_post_url     VARCHAR(255) NULL,
  -- Контент, который админ может отредактировать перед публикацией
  title           VARCHAR(255) NOT NULL DEFAULT '',
  content         MEDIUMTEXT   NOT NULL,
  -- Все фото поста (JSON-массив абсолютных путей вида /api/public/uploads/vk_xxx.jpg)
  images_json     MEDIUMTEXT   NOT NULL,
  -- Какое фото выбрал админ (по индексу в images_json), -1 = ни одного
  selected_image  INT          NOT NULL DEFAULT 0,
  -- Дата публикации в ВК (UTC)
  vk_published_at DATETIME     NOT NULL,
  -- Статус: pending — ждёт админа, approved — опубликовано, rejected — отклонено
  status          ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  -- ID связанной записи в `stories` (если уже опубликовано)
  published_story_id BIGINT NULL,
  -- Кем и когда обработано
  reviewed_by_user_id BIGINT NULL,
  reviewed_at         TIMESTAMP NULL,
  reject_reason       VARCHAR(500) NULL,
  -- Аудит
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  UNIQUE KEY uniq_vk_post (vk_owner_id, vk_post_id),
  KEY idx_vk_pending_status (status, vk_published_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Лог запусков парсера
CREATE TABLE IF NOT EXISTS vk_parser_runs (
  id          BIGINT AUTO_INCREMENT PRIMARY KEY,
  started_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  finished_at TIMESTAMP NULL,
  fetched_total INT NOT NULL DEFAULT 0,
  added_new     INT NOT NULL DEFAULT 0,
  skipped_dup   INT NOT NULL DEFAULT 0,
  status        ENUM('ok','error') NOT NULL DEFAULT 'ok',
  message       TEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
