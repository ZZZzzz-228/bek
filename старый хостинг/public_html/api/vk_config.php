<?php
/**
 * Настройки парсера ВК.
 *
 * Куда положить: /home/u/.../public_html/api/vk_config.php (рядом с config.php)
 * Доступ извне закрыт через Apache (.htaccess уже запрещает прямые .php в /api/).
 *
 * ────────────────────────────────────────────────────────────────────────────
 * ОТКУДА ВЗЯТЬ access_token (сервисный ключ доступа):
 * 1. Зайти на https://vk.com/apps?act=manage
 * 2. Создать «Standalone-приложение» (тип Standalone-приложение).
 * 3. В «Настройки» приложения → скопировать «Сервисный ключ доступа».
 *    Этого ключа достаточно для чтения публичных постов открытой группы
 *    через метод wall.get с параметром v=5.199.
 *
 * group_id для https://vk.com/media_ak:
 *   - короткое имя группы: media_ak
 *   - чтобы получить численный id, открой https://api.vk.com/method/groups.getById
 *       ?group_id=media_ak&access_token=<service>&v=5.199
 *     В ответе будет числовой id (например, 12345678). В wall.get owner_id
 *     передаётся со знаком минус: owner_id = -12345678.
 *   - Можно также оставить группу строкой 'media_ak' — парсер сам подставит owner_id.
 * ────────────────────────────────────────────────────────────────────────────
 */

return [
    // Сервисный ключ доступа из настроек Standalone-приложения VK
    'access_token' => 'vk1.a.oAs-t5R4bKJdTtkmdYJGMYaebMwqF-0aaXcorFZIXC1ccW5ArspOnggac3FUOwnFb1e_z8DcUF3-L8GqM5UGtkiGZUjQN5b4ouMX254NOpOiux0AmsP-poKWZf7JAc0iROgARDpdUWt1o-epniONVNyJtU-qG-KQvuKmFwZnDsULuDD2dj-L9nzkHBOl0bYJ',

    // Версия VK API
    'api_version'  => '5.199',

    // Короткое имя группы (БЕЗ vk.com/) или числовой owner_id со знаком минус
    'group'        => 'media_ak',

    // Сколько последних постов запрашивать за один прогон cron
    'fetch_count'  => 20,

    // Максимальное число фото, сохраняемых из одного поста
    'max_photos_per_post' => 10,

    // Минимальная длина текста, чтобы считать пост «новостью»
    // (фильтр от пустых репостов, рекламы и т.п.). Поставь 0, чтобы отключить.
    'min_text_length' => 30,

    // Простой shared-secret для запуска парсера через HTTP
    // (если у тебя на хостинге cron не умеет CLI). Дёргать парсер через:
    //   https://kucersta.beget.tech/api/public/admin/vk_parser_run.php?key=<этот_ключ>
    'cron_http_key' => 'СГЕНЕРИРУЙ_ДЛИННУЮ_СЛУЧАЙНУЮ_СТРОКУ',
];
