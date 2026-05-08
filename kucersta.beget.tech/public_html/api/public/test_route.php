<?php
// Диагностический файл — после проверки удали его с сервера
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
 
$uriPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
$basePath = '/api/public';
$path = rtrim(str_replace($basePath, '', $uriPath), '/');
if ($path === '') $path = '/';
 
echo json_encode([
    'ok' => true,
    'index_version' => 'FIXED_v2',
    'raw_uri'  => $_SERVER['REQUEST_URI'] ?? '(none)',
    'uri_path' => $uriPath,
    'stripped_path' => $path,
    'php_file' => __FILE__,
    'opcache_enabled' => function_exists('opcache_get_status') ? (bool)(opcache_get_status()['opcache_enabled'] ?? false) : false,
], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
 