<?php
/**
 * Диагностика: проверяет все image_url / logo_url / photo_url / cover_image_url
 * в БД и сверяет с реальным существованием файлов на диске.
 *
 * Доступ: только авторизованным админам.
 *   /api/public/admin/check_image_paths.php
 */

declare(strict_types=1);

require_once __DIR__ . '/_bootstrap.php';
requireLogin();
requireRole('admin');

// Корень public_html (где лежит /api/...). __DIR__ = .../api/public/admin
$webRoot = realpath(__DIR__ . '/../../../');
if ($webRoot === false) {
    die('Не удалось определить web-root');
}

$checks = [
    ['table' => 'staff_members',           'id' => 'id', 'field' => 'photo_url',       'where' => "photo_url IS NOT NULL AND photo_url <> ''"],
    ['table' => 'news_items',              'id' => 'id', 'field' => 'image_url',       'where' => "image_url IS NOT NULL AND image_url <> ''"],
    ['table' => 'stories',                 'id' => 'id', 'field' => 'image_url',       'where' => "image_url IS NOT NULL AND image_url <> ''"],
    ['table' => 'pages',                   'id' => 'id', 'field' => 'cover_image_url', 'where' => "cover_image_url IS NOT NULL AND cover_image_url <> ''"],
    ['table' => 'partners',                'id' => 'id', 'field' => 'logo_url',        'where' => "logo_url IS NOT NULL AND logo_url <> ''"],
    ['table' => 'contacts',                'id' => 'id', 'field' => 'image_url',       'where' => "image_url IS NOT NULL AND image_url <> ''"],
    ['table' => 'specialties',             'id' => 'id', 'field' => 'image_url',       'where' => "image_url IS NOT NULL AND image_url <> ''"],
    ['table' => 'education_programs',      'id' => 'id', 'field' => 'image_url',       'where' => "image_url IS NOT NULL AND image_url <> ''"],
    ['table' => 'student_portfolio_items', 'id' => 'id', 'field' => 'image_url',       'where' => "image_url IS NOT NULL AND image_url <> ''"],
    ['table' => 'media_assets',            'id' => 'id', 'field' => 'url',             'where' => "url IS NOT NULL AND url <> ''"],
];

header('Content-Type: text/html; charset=utf-8');
?><!doctype html>
<html lang="ru">
<head>
<meta charset="utf-8">
<title>Проверка путей к изображениям</title>
<link rel="stylesheet" href="/api/public/admin/assets/admin.css">
<style>
  body{font-family:system-ui,Arial;padding:16px;}
  table{border-collapse:collapse;width:100%;margin-bottom:24px;}
  th,td{border:1px solid #ddd;padding:6px 8px;text-align:left;font-size:13px;vertical-align:top;}
  th{background:#f3f4f6;}
  .ok{color:#16a34a;font-weight:600;}
  .bad{color:#dc2626;font-weight:600;}
  .warn{color:#d97706;font-weight:600;}
  h2{margin-top:24px;}
  .summary{padding:12px 16px;border-radius:8px;background:#f9fafb;margin:12px 0;}
  .summary.ok{background:#dcfce7;}
  .summary.bad{background:#fee2e2;}
  code{background:#f3f4f6;padding:2px 4px;border-radius:3px;font-size:12px;}
</style>
</head>
<body>
<h1>🩺 Проверка путей к изображениям</h1>
<p>Web-root: <code><?= htmlspecialchars($webRoot) ?></code></p>
<p><a href="/api/public/admin/index.php">← Назад в админку</a></p>

<?php
$totalOk = 0;
$totalBad = 0;
$totalSkipped = 0;
$brokenList = [];

foreach ($checks as $c) {
    try {
        $rows = $pdo->query("SELECT {$c['id']} AS pk, {$c['field']} AS val FROM {$c['table']} WHERE {$c['where']}")->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable $e) {
        echo "<p class='warn'>[SKIP] Таблица <code>{$c['table']}</code>: " . htmlspecialchars($e->getMessage()) . "</p>";
        continue;
    }

    echo "<h2>{$c['table']}.{$c['field']} <small style='font-weight:400;color:#6b7280;'>(" . count($rows) . " записей)</small></h2>";
    if (empty($rows)) {
        echo "<p style='color:#6b7280;'>— нет записей с заполненным полем —</p>";
        continue;
    }
    echo "<table><tr><th>id</th><th>значение</th><th>тип</th><th>статус</th></tr>";

    foreach ($rows as $r) {
        $val = (string)$r['val'];
        [$type, $exists, $hint] = classifyAndCheck($val, $webRoot);

        if ($type === 'remote' || $type === 'asset' || $type === 'data') {
            $totalSkipped++;
            $cls = 'warn';
            $status = '— (внешний/ассет)';
        } elseif ($exists) {
            $totalOk++;
            $cls = 'ok';
            $status = '✓ OK';
        } else {
            $totalBad++;
            $cls = 'bad';
            $status = '✗ НЕТ ФАЙЛА';
            $brokenList[] = "{$c['table']}.{$c['field']} #{$r['pk']}: {$val}";
        }

        echo "<tr>";
        echo "<td>{$r['pk']}</td>";
        echo "<td><code>" . htmlspecialchars($val) . "</code></td>";
        echo "<td>{$type}</td>";
        echo "<td class='{$cls}'>" . htmlspecialchars($status);
        if ($hint) {
            echo " <small style='font-weight:400;color:#6b7280;'>(" . htmlspecialchars($hint) . ")</small>";
        }
        echo "</td>";
        echo "</tr>";
    }
    echo "</table>";
}

$cls = $totalBad === 0 ? 'ok' : 'bad';
echo "<div class='summary {$cls}'><h2 style='margin:0;'>ИТОГО: ✓ OK = {$totalOk}, ✗ BROKEN = {$totalBad}, — внешние/ассеты = {$totalSkipped}</h2>";
if ($totalBad > 0) {
    echo "<details style='margin-top:12px;'><summary>Список битых ссылок</summary><pre>" . htmlspecialchars(implode("\n", $brokenList)) . "</pre></details>";
}
echo "</div>";
?>
</body>
</html>
<?php

/**
 * @return array{0:string,1:bool,2:string} type, exists, hint
 */
function classifyAndCheck(string $url, string $webRoot): array
{
    $u = trim($url);
    if ($u === '') {
        return ['empty', false, ''];
    }
    if (preg_match('#^https?://#i', $u)) {
        return ['remote', false, 'внешний URL — проверка не выполняется'];
    }
    if (str_starts_with($u, 'data:')) {
        return ['data', false, 'data URI'];
    }
    // Относительные ассеты Flutter-клиента (не на бэке)
    if (str_starts_with($u, 'assets/') || str_starts_with($u, '/assets/')) {
        return ['asset', false, 'ассет Flutter-приложения, на бэке не лежит'];
    }
    $rel = ltrim($u, '/');
    $abs = $webRoot . DIRECTORY_SEPARATOR . str_replace('/', DIRECTORY_SEPARATOR, $rel);
    if (is_file($abs)) {
        return ['local', true, ''];
    }
    if (str_starts_with($u, '/uploads/')) {
        $alt = $webRoot . '/api/public' . $u;
        if (is_file($alt)) {
            return ['local', false, 'отсутствует префикс /api/public/ — но файл есть'];
        }
    }
    return ['local', false, 'файл не найден на диске'];
}
