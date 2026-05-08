-- ============================================================================
-- Миграция: исправление путей к изображениям на гостевых страницах
-- Применять ОДИН раз после всех остальных миграций и сидов.
-- ============================================================================
-- Что делает:
--   1) Заполняет logo_url у партнёров реальными файлами из uploads/partners/
--   2) Удаляет ссылки на несуществующие /uploads/demo/* (ставит NULL)
--   3) Нормализует префикс URL: /uploads/... -> /api/public/uploads/...
--      (чтобы пути соответствовали реальной раздаче статикой через Apache)
-- ============================================================================

-- 1) ЛОГОТИПЫ ПАРТНЁРОВ ------------------------------------------------------
--    Файлы лежат в api/public/uploads/partners/<slug>.png
--    Привязываем по точному совпадению name. Если запись отсутствует, добавим.

-- Существующие партнёры из seed.sql
UPDATE partners SET logo_url = '/api/public/uploads/partners/reshetnev.png'
  WHERE name = 'АО РЕШЕТНЁВ' AND (logo_url IS NULL OR logo_url = '');
UPDATE partners SET logo_url = '/api/public/uploads/partners/krasmash.png'
  WHERE name = 'Красмаш' AND (logo_url IS NULL OR logo_url = '');
UPDATE partners SET logo_url = '/api/public/uploads/partners/rosseti.png'
  WHERE name = 'Россети Сибирь' AND (logo_url IS NULL OR logo_url = '');

-- Дополнительные партнёры — добавляем только если их ещё нет.
-- Используем INSERT … SELECT с проверкой через NOT EXISTS, чтобы не зависеть
-- от UNIQUE индексов.
INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'РУСАЛ' AS name, 'Партнёр по программам стажировок металлургии и энергетики.' AS description,
       'https://rusal.ru/' AS website_url, '/api/public/uploads/partners/rusal.png' AS logo_url, 4 AS sort_order, 1 AS is_published) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'РУСАЛ');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'РусГидро', 'Партнёр по энергетическим специальностям.',
       'https://www.rushydro.ru/', '/api/public/uploads/partners/rushydro.png', 5, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'РусГидро');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'Полюс', 'Партнёр по инженерно-технологическим направлениям.',
       'https://polyus.com/', '/api/public/uploads/partners/polyus.png', 6, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'Полюс');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'Ванкорнефть', 'Партнёр направления «Нефтегазовая отрасль».',
       'https://www.rosneft.ru/', '/api/public/uploads/partners/vankor.png', 7, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'Ванкорнефть');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'КРАМЗ', 'Красноярский металлургический завод. Практика и трудоустройство.',
       'https://kramz.ru/', '/api/public/uploads/partners/kramz.png', 8, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'КРАМЗ');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'НПП «Радиосвязь»', 'Партнёр по специальностям радиоэлектроники.',
       'https://www.npp-radio.ru/', '/api/public/uploads/partners/radiosvyaz.png', 9, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'НПП «Радиосвязь»');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'НПП «Геофизика»', 'Партнёр по приборостроительным направлениям.',
       'https://www.geofizika.ru/', '/api/public/uploads/partners/geofizika.png', 10, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'НПП «Геофизика»');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'АэроГео', 'Партнёр по авиационным направлениям.',
       'https://www.aerogeo.ru/', '/api/public/uploads/partners/aerogeo.png', 11, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'АэроГео');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'Апогей', 'Партнёр по IT-практикам.',
       NULL, '/api/public/uploads/partners/apogey.png', 12, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'Апогей');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'Емельянов и Ко', 'Партнёр по экономическим специальностям.',
       NULL, '/api/public/uploads/partners/emelyanov.png', 13, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'Емельянов и Ко');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'ERP-системы', 'Партнёр по программированию.',
       NULL, '/api/public/uploads/partners/erp.png', 14, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'ERP-системы');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'Форсайт', 'Партнёр по информационным технологиям.',
       NULL, '/api/public/uploads/partners/forsight.png', 15, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'Форсайт');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'ГХК', 'Горно-химический комбинат. Партнёр по химико-технологическим направлениям.',
       'https://www.sibghk.ru/', '/api/public/uploads/partners/ghk.png', 16, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'ГХК');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'МегаВатт', 'Партнёр по электроэнергетическим специальностям.',
       NULL, '/api/public/uploads/partners/megavatt.png', 17, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'МегаВатт');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'Микрон', 'Партнёр по микроэлектронике.',
       'https://mikron.ru/', '/api/public/uploads/partners/mikron.png', 18, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'Микрон');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'Проток', 'Партнёр по приборостроению.',
       NULL, '/api/public/uploads/partners/protok.png', 19, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'Проток');

INSERT INTO partners (name, description, website_url, logo_url, sort_order, is_published)
SELECT * FROM (SELECT 'Зенит', 'Партнёр по машиностроению.',
       NULL, '/api/public/uploads/partners/zenith.png', 20, 1) AS t
WHERE NOT EXISTS (SELECT 1 FROM partners WHERE name = 'Зенит');

-- 2) НОРМАЛИЗАЦИЯ ПРЕФИКСА URL: /uploads/... -> /api/public/uploads/...   ----
--    Применяется ко ВСЕМ полям, где админка хранит ссылки на загруженные файлы.

UPDATE staff_members
   SET photo_url = CONCAT('/api/public', photo_url)
 WHERE photo_url LIKE '/uploads/%'
   AND photo_url NOT LIKE '/api/public/uploads/%';

UPDATE news_items
   SET image_url = CONCAT('/api/public', image_url)
 WHERE image_url LIKE '/uploads/%'
   AND image_url NOT LIKE '/api/public/uploads/%';

UPDATE stories
   SET image_url = CONCAT('/api/public', image_url)
 WHERE image_url LIKE '/uploads/%'
   AND image_url NOT LIKE '/api/public/uploads/%'
   AND image_url NOT LIKE '/assets/%';

UPDATE pages
   SET cover_image_url = CONCAT('/api/public', cover_image_url)
 WHERE cover_image_url LIKE '/uploads/%'
   AND cover_image_url NOT LIKE '/api/public/uploads/%';

UPDATE partners
   SET logo_url = CONCAT('/api/public', logo_url)
 WHERE logo_url LIKE '/uploads/%'
   AND logo_url NOT LIKE '/api/public/uploads/%';

UPDATE contacts
   SET image_url = CONCAT('/api/public', image_url)
 WHERE image_url LIKE '/uploads/%'
   AND image_url NOT LIKE '/api/public/uploads/%';

UPDATE specialties
   SET image_url = CONCAT('/api/public', image_url)
 WHERE image_url LIKE '/uploads/%'
   AND image_url NOT LIKE '/api/public/uploads/%';

UPDATE education_programs
   SET image_url = CONCAT('/api/public', image_url)
 WHERE image_url LIKE '/uploads/%'
   AND image_url NOT LIKE '/api/public/uploads/%';

UPDATE student_portfolio_items
   SET image_url = CONCAT('/api/public', image_url)
 WHERE image_url LIKE '/uploads/%'
   AND image_url NOT LIKE '/api/public/uploads/%';

UPDATE media_assets
   SET url = CONCAT('/api/public', url)
 WHERE url LIKE '/uploads/%'
   AND url NOT LIKE '/api/public/uploads/%';

-- 3) ОЧИСТКА БИТЫХ ССЫЛОК НА ОТСУТСТВУЮЩИЕ ФАЙЛЫ ----------------------------
--    /uploads/demo/*.jpg в seed.sql ссылаются на файлы, которых нет.
--    Ставим NULL, чтобы клиент использовал заглушки/ассеты приложения.

UPDATE pages
   SET cover_image_url = NULL
 WHERE cover_image_url LIKE '%/uploads/demo/%';

UPDATE media_assets
   SET url = NULL
 WHERE url LIKE '%/uploads/demo/%';

UPDATE student_portfolio_items
   SET image_url = NULL
 WHERE image_url LIKE '%/uploads/demo/%';

-- ============================================================================
-- Готово. Проверка после выполнения:
--   SELECT name, logo_url FROM partners ORDER BY sort_order;
--   SELECT slug, cover_image_url FROM pages;
--   SELECT full_name, photo_url FROM staff_members WHERE photo_url IS NOT NULL;
-- ============================================================================
