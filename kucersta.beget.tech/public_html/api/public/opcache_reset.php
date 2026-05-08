<?php
// Сбрасывает OPCache — запусти один раз, потом удали этот файл с сервера!
header('Content-Type: application/json; charset=utf-8');

$results = [];

// Инвалидируем конкретно index.php
$indexFile = __DIR__ . '/index.php';
if (function_exists('opcache_invalidate')) {
    $results['index_invalidated'] = opcache_invalidate($indexFile, true);
}

// Сбрасываем весь кэш
if (function_exists('opcache_reset')) {
    $results['full_reset'] = opcache_reset();
}

$results['ok'] = true;
$results['message'] = 'OPCache сброшен! Теперь проверь /api/public/specialties и удали этот файл.';

echo json_encode($results, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);