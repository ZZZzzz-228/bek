<?php
/**
 * Парсер постов из открытой группы ВКонтакте.
 *
 * Куда положить: /home/u/.../public_html/api/tools/vk_parser.php
 * (создай папку tools, если её ещё нет)
 *
 * ────────────────────────────────────────────────────────────────────────────
 * ЗАПУСК ИЗ CRON (Beget → Cron → раз в 40 минут):
 *
 *   /usr/bin/php /home/u/USERNAME/public_html/api/tools/vk_parser.php
 *
 * Маска расписания на Beget:
 *   Минуты: 0,40                  (или *\/40)
 *   Часы:   *
 *   День:   *
 *   Месяц:  *
 *   День недели: *
 *
 * ЗАПУСК ИЗ БРАУЗЕРА (если CLI cron на Beget недоступен):
 *   https://kucersta.beget.tech/api/public/admin/vk_parser_run.php?key=<cron_http_key>
 *   Этот URL можно дёргать раз в 40 минут через любой внешний cron (например,
 *   https://cron-job.org/) или через wget из задания Beget «Запросить URL».
 * ────────────────────────────────────────────────────────────────────────────
 */
declare(strict_types=1);

// CLI-режим: чтобы видеть ошибки в логах cron
ini_set('display_errors', '1');
error_reporting(E_ALL);

require_once __DIR__ . '/../src/Database.php';

/**
 * Если файл вызван напрямую (php vk_parser.php) или вызывается константой VK_PARSER_RUN_NOW —
 * запускаем парсер немедленно. Если файл просто include'ится в другом
 * скрипте для использования класса VkParser — ничего не делаем.
 */
$shouldRunNow = (PHP_SAPI === 'cli')
    || (defined('VK_PARSER_RUN_NOW') && VK_PARSER_RUN_NOW === true);

if ($shouldRunNow) {
    $dbConfig    = require __DIR__ . '/../config.php';
    $vkConfigPath = __DIR__ . '/../vk_config.php';
    if (!is_file($vkConfigPath)) {
        if (PHP_SAPI === 'cli') {
            fwrite(STDERR, "[vk_parser] vk_config.php not found at {$vkConfigPath}\n");
        } else {
            echo "[vk_parser] vk_config.php not found\n";
        }
        exit(1);
    }
    $vkConfig = require $vkConfigPath;

    try {
        VkParser::run($dbConfig, $vkConfig);
    } catch (Throwable $e) {
        if (PHP_SAPI === 'cli') {
            fwrite(STDERR, "[vk_parser] FATAL: " . $e->getMessage() . "\n");
        } else {
            echo "[vk_parser] FATAL: " . $e->getMessage() . "\n";
        }
        exit(1);
    }
}

// ───────────────────────────────────────────────────────────────────────────

class VkParser
{
    public static function run(array $dbConfig, array $vkConfig): void
    {
        $pdo = Database::connect($dbConfig);

        // Логируем запуск
        $stmt = $pdo->prepare(
            'INSERT INTO vk_parser_runs(started_at) VALUES (NOW())'
        );
        $stmt->execute();
        $runId = (int)$pdo->lastInsertId();

        $fetched = 0;
        $added   = 0;
        $skipped = 0;

        try {
            $accessToken = trim((string)($vkConfig['access_token'] ?? ''));
            $apiVersion  = (string)($vkConfig['api_version'] ?? '5.199');
            $group       = (string)($vkConfig['group'] ?? 'media_ak');
            $fetchCount  = (int)($vkConfig['fetch_count'] ?? 20);
            $maxPhotos   = (int)($vkConfig['max_photos_per_post'] ?? 10);
            $minTextLen  = (int)($vkConfig['min_text_length'] ?? 30);

            if ($accessToken === '' || str_starts_with($accessToken, 'ВСТАВЬ')) {
                throw new RuntimeException('VK access_token не задан в vk_config.php');
            }

            // 1) Узнаём числовой owner_id группы
            $ownerId = self::resolveGroupOwnerId($accessToken, $apiVersion, $group);

            // 2) Получаем последние посты
            $posts = self::wallGet($accessToken, $apiVersion, $ownerId, $fetchCount);
            $fetched = count($posts);

            // 3) Готовим список post_id, которые уже есть в БД (защита от дубликатов)
            $existingIds = [];
            if ($posts) {
                $ids = array_map(static fn($p) => (int)($p['id'] ?? 0), $posts);
                $ids = array_filter($ids, static fn($v) => $v > 0);
                if ($ids) {
                    $in = implode(',', array_fill(0, count($ids), '?'));
                    $check = $pdo->prepare(
                        "SELECT vk_post_id FROM vk_pending_stories
                         WHERE vk_owner_id = ? AND vk_post_id IN ({$in})"
                    );
                    $check->execute(array_merge([$ownerId], $ids));
                    foreach ($check->fetchAll(PDO::FETCH_COLUMN) as $id) {
                        $existingIds[(int)$id] = true;
                    }
                }
            }

            // 4) Каждую новую запись — парсим, скачиваем фото, кладём в БД
            $uploadsDir = realpath(__DIR__ . '/../public/uploads');
            if ($uploadsDir === false) {
                $uploadsDir = __DIR__ . '/../public/uploads';
                if (!is_dir($uploadsDir)) {
                    mkdir($uploadsDir, 0775, true);
                }
            }

            $insert = $pdo->prepare(
                'INSERT INTO vk_pending_stories
                 (vk_owner_id, vk_post_id, vk_post_url, title, content, images_json,
                  selected_image, vk_published_at, status)
                 VALUES
                 (:owner, :post, :url, :title, :content, :images,
                  :sel, :published, "pending")'
            );

            foreach ($posts as $post) {
                $postId = (int)($post['id'] ?? 0);
                if ($postId <= 0) {
                    continue;
                }
                if (isset($existingIds[$postId])) {
                    $skipped++;
                    continue;
                }

                // Игнорируем закреплённые рекламные / служебные посты с пустым текстом
                $text = trim((string)($post['text'] ?? ''));
                if ($minTextLen > 0 && mb_strlen($text) < $minTextLen) {
                    $skipped++;
                    continue;
                }

                // Скачиваем фото из attachments + из copy_history (репосты со своим контентом)
                $photoUrls = self::collectPhotoUrls($post, $maxPhotos);
                $savedImages = [];
                foreach ($photoUrls as $url) {
                    $savedPath = self::downloadPhoto($url, $uploadsDir);
                    if ($savedPath !== null) {
                        $savedImages[] = $savedPath;
                    }
                }

                // Заголовок = первая строка / первое предложение
                $title = self::extractTitle($text);
                // Содержимое — оригинальный текст без избыточных пустых строк
                $content = self::cleanContent($text);

                $publishedAt = gmdate('Y-m-d H:i:s', (int)($post['date'] ?? time()));
                $postUrl = sprintf('https://vk.com/wall%d_%d', $ownerId, $postId);

                $insert->execute([
                    'owner'     => $ownerId,
                    'post'      => $postId,
                    'url'       => $postUrl,
                    'title'     => mb_substr($title, 0, 250),
                    'content'   => $content,
                    'images'    => json_encode($savedImages, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
                    'sel'       => $savedImages ? 0 : -1,
                    'published' => $publishedAt,
                ]);
                $added++;
            }

            // Лог окончания
            $pdo->prepare(
                'UPDATE vk_parser_runs
                 SET finished_at = NOW(), fetched_total = :f, added_new = :a,
                     skipped_dup = :s, status = "ok"
                 WHERE id = :id'
            )->execute([
                'f' => $fetched, 'a' => $added, 's' => $skipped, 'id' => $runId,
            ]);

            echo "[vk_parser] OK fetched={$fetched} added={$added} skipped={$skipped}\n";
        } catch (Throwable $e) {
            $pdo->prepare(
                'UPDATE vk_parser_runs
                 SET finished_at = NOW(), fetched_total = :f, added_new = :a,
                     skipped_dup = :s, status = "error", message = :m
                 WHERE id = :id'
            )->execute([
                'f' => $fetched, 'a' => $added, 's' => $skipped,
                'm' => mb_substr($e->getMessage(), 0, 1000), 'id' => $runId,
            ]);
            throw $e;
        }
    }

    /**
     * Если в конфиге короткое имя группы — превращаем его в численный owner_id (со знаком минус).
     * Если уже число (с минусом) — возвращаем как есть.
     */
    private static function resolveGroupOwnerId(string $token, string $v, string $group): int
    {
        $group = trim($group);
        if ($group === '') {
            throw new RuntimeException('VK group is empty');
        }
        if (preg_match('/^-?\d+$/', $group)) {
            $n = (int)$group;
            return $n > 0 ? -$n : $n;
        }
        $resp = self::vkApiCall('groups.getById', [
            'group_id'     => $group,
            'access_token' => $token,
            'v'            => $v,
        ]);
        // VK 5.199 отдаёт ['groups' => [...], 'profiles' => [...]]
        $g = $resp['groups'][0] ?? $resp[0] ?? null;
        if (!is_array($g) || empty($g['id'])) {
            throw new RuntimeException('groups.getById не вернул id для ' . $group);
        }
        return -(int)$g['id'];
    }

    /**
     * @return array<int, array<string,mixed>>
     */
    private static function wallGet(string $token, string $v, int $ownerId, int $count): array
    {
        $resp = self::vkApiCall('wall.get', [
            'owner_id'     => $ownerId,
            'count'        => max(1, min(100, $count)),
            'filter'       => 'owner', // только записи самой группы (без чужих)
            'extended'     => 0,
            'access_token' => $token,
            'v'            => $v,
        ]);
        $items = $resp['items'] ?? [];
        return is_array($items) ? $items : [];
    }

    private static function vkApiCall(string $method, array $params): array
    {
        $url = 'https://api.vk.com/method/' . $method;
        $ch = curl_init();
        curl_setopt_array($ch, [
            CURLOPT_URL            => $url,
            CURLOPT_POST           => true,
            CURLOPT_POSTFIELDS     => http_build_query($params),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CONNECTTIMEOUT => 10,
            CURLOPT_TIMEOUT        => 25,
            CURLOPT_SSL_VERIFYPEER => true,
            CURLOPT_USERAGENT      => 'kucersta-vk-parser/1.0',
        ]);
        $body = curl_exec($ch);
        $err  = curl_error($ch);
        $code = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($body === false) {
            throw new RuntimeException("VK API curl error: {$err}");
        }
        if ($code !== 200) {
            throw new RuntimeException("VK API HTTP {$code}: " . substr((string)$body, 0, 300));
        }
        $json = json_decode((string)$body, true);
        if (!is_array($json)) {
            throw new RuntimeException("VK API: невалидный JSON: " . substr((string)$body, 0, 300));
        }
        if (isset($json['error'])) {
            $msg = $json['error']['error_msg'] ?? 'unknown';
            $codeApi = $json['error']['error_code'] ?? '?';
            throw new RuntimeException("VK API error {$codeApi}: {$msg}");
        }
        return $json['response'] ?? [];
    }

    /**
     * Собирает все фото поста (включая repost'ы внутри copy_history) — берём самое
     * большое разрешение. Возвращает массив URL'ов.
     *
     * @return string[]
     */
    private static function collectPhotoUrls(array $post, int $maxPhotos): array
    {
        $urls = [];
        $visit = static function (array $p) use (&$urls, &$visit) {
            $atts = $p['attachments'] ?? [];
            if (is_array($atts)) {
                foreach ($atts as $att) {
                    if (($att['type'] ?? '') !== 'photo') {
                        continue;
                    }
                    $photo = $att['photo'] ?? [];
                    $url = self::pickBestPhotoUrl($photo);
                    if ($url !== '') {
                        $urls[] = $url;
                    }
                }
            }
            // Репосты с собственным текстом
            if (!empty($p['copy_history']) && is_array($p['copy_history'])) {
                foreach ($p['copy_history'] as $c) {
                    if (is_array($c)) {
                        $visit($c);
                    }
                }
            }
        };
        $visit($post);

        // Уникализируем и обрезаем
        $urls = array_values(array_unique($urls));
        return array_slice($urls, 0, $maxPhotos);
    }

    private static function pickBestPhotoUrl(array $photo): string
    {
        $sizes = $photo['sizes'] ?? [];
        if (!is_array($sizes) || !$sizes) {
            return '';
        }
        $bestUrl = '';
        $bestArea = 0;
        foreach ($sizes as $s) {
            $w = (int)($s['width'] ?? 0);
            $h = (int)($s['height'] ?? 0);
            $u = (string)($s['url'] ?? '');
            if ($u === '') {
                continue;
            }
            $area = max(1, $w * $h);
            if ($area > $bestArea) {
                $bestArea = $area;
                $bestUrl = $u;
            }
        }
        return $bestUrl;
    }

    /**
     * Скачивает один файл-фото и кладёт в /api/public/uploads/.
     * Возвращает абсолютный путь вида /api/public/uploads/vk_XXXX.jpg
     * либо null при ошибке.
     */
    private static function downloadPhoto(string $url, string $uploadsDir): ?string
    {
        if ($url === '') {
            return null;
        }
        $ch = curl_init();
        curl_setopt_array($ch, [
            CURLOPT_URL            => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_CONNECTTIMEOUT => 10,
            CURLOPT_TIMEOUT        => 25,
            CURLOPT_SSL_VERIFYPEER => true,
            CURLOPT_USERAGENT      => 'kucersta-vk-parser/1.0',
        ]);
        $body = curl_exec($ch);
        $code = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $ctype = (string)curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
        curl_close($ch);

        if ($body === false || $code !== 200 || $body === '') {
            return null;
        }

        // Определяем расширение
        $ext = 'jpg';
        $ctypeLow = strtolower($ctype);
        if (str_contains($ctypeLow, 'png')) {
            $ext = 'png';
        } elseif (str_contains($ctypeLow, 'webp')) {
            $ext = 'webp';
        } elseif (str_contains($ctypeLow, 'jpeg') || str_contains($ctypeLow, 'jpg')) {
            $ext = 'jpg';
        }

        $name = 'vk_' . date('Ymd_His') . '_' . bin2hex(random_bytes(5)) . '.' . $ext;
        $target = rtrim($uploadsDir, '/\\') . DIRECTORY_SEPARATOR . $name;
        if (file_put_contents($target, (string)$body) === false) {
            return null;
        }
        @chmod($target, 0664);
        return '/api/public/uploads/' . $name;
    }

    /**
     * Берём заголовок: первая непустая строка, обрезанная до ~80 символов.
     */
    private static function extractTitle(string $text): string
    {
        $text = trim($text);
        if ($text === '') {
            return 'Новость из VK';
        }
        // Убираем хэштеги в скобках вида [club123|...]
        $text = preg_replace('/\[([^\]]+)\|([^\]]+)\]/u', '$2', $text) ?? $text;

        $lines = preg_split('/\r?\n/u', $text);
        $first = '';
        foreach ($lines as $line) {
            $line = trim($line);
            if ($line === '') {
                continue;
            }
            $first = $line;
            break;
        }
        if ($first === '') {
            $first = mb_substr($text, 0, 80);
        }

        // Если строка длинная — режем по первому "." или "!" или "?" в первых 100 символах
        if (mb_strlen($first) > 80) {
            $cut = mb_substr($first, 0, 100);
            if (preg_match('/^(.+?[.!?])\s/u', $cut, $m)) {
                $first = $m[1];
            } else {
                $first = mb_substr($first, 0, 77) . '…';
            }
        }
        return $first;
    }

    private static function cleanContent(string $text): string
    {
        // [id123|Имя] → Имя, [club123|Имя] → Имя
        $text = preg_replace('/\[([^\]]+)\|([^\]]+)\]/u', '$2', $text) ?? $text;
        // Стягиваем 3+ пустые строки до одной
        $text = preg_replace("/(\r?\n){3,}/u", "\n\n", $text) ?? $text;
        return trim($text);
    }
}
