<?php

final class Response
{
    /**
     * Поля JSON-ответа, в которых могут лежать ссылки на загруженные на бэке файлы.
     * Для них применяется автоматическая нормализация префикса:
     * "/uploads/xxx.png" -> "/api/public/uploads/xxx.png"
     * Это страховка для старых записей в БД, где префикс был сохранён без /api/public.
     */
    private const IMAGE_URL_FIELDS = [
        'image_url',
        'logo_url',
        'photo_url',
        'cover_image_url',
        'url',          // для media_assets
        'project_url',  // на всякий случай — но обычно тут внешний URL, normalize его не тронет
    ];

    public static function json(array $payload, int $statusCode = 200): void
    {
        self::setCorsHeaders();
        http_response_code($statusCode);
        header('Content-Type: application/json; charset=utf-8');

        $normalized = self::normalizeImageUrls($payload);

        echo json_encode($normalized, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
        exit;
    }

    public static function setCorsHeaders(): void
    {
        $origin = $_SERVER['HTTP_ORIGIN'] ?? '';
        $allowed = [
            'https://aksibgu.gamer.gd',
            'http://localhost',
            'http://127.0.0.1',
        ];
        if (in_array($origin, $allowed, true)) {
            header("Access-Control-Allow-Origin: {$origin}");
        } else {
            header('Access-Control-Allow-Origin: *');
        }
        header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
        header('Access-Control-Allow-Headers: Content-Type, Authorization');
        header('Access-Control-Allow-Credentials: true');
    }

    public static function sendPreflight(): void
    {
        self::setCorsHeaders();
        http_response_code(204);
        exit;
    }

    /**
     * Рекурсивно проходит по структуре и для известных image-полей
     * нормализует пути вида "/uploads/..." -> "/api/public/uploads/...".
     * Только относительные локальные пути; http(s):// и assets/* не трогаются.
     */
    private static function normalizeImageUrls(mixed $node): mixed
    {
        if (is_array($node)) {
            $out = [];
            foreach ($node as $k => $v) {
                if (is_string($k) && in_array($k, self::IMAGE_URL_FIELDS, true) && is_string($v)) {
                    $out[$k] = self::fixImagePath($v);
                } else {
                    $out[$k] = self::normalizeImageUrls($v);
                }
            }
            return $out;
        }
        return $node;
    }

    private static function fixImagePath(string $url): string
    {
        $u = trim($url);
        if ($u === '') {
            return $url;
        }
        // Внешние URL и data-uri оставляем как есть
        if (preg_match('#^(https?:)?//#i', $u) || str_starts_with($u, 'data:')) {
            return $url;
        }
        // Уже корректный
        if (str_starts_with($u, '/api/public/uploads/')) {
            return $url;
        }
        // Битый префикс — чиним
        if (str_starts_with($u, '/uploads/')) {
            return '/api/public' . $u;
        }
        if (str_starts_with($u, 'uploads/')) {
            return '/api/public/' . $u;
        }
        // assets/* (Flutter-ассеты) — не трогаем
        return $url;
    }
}
