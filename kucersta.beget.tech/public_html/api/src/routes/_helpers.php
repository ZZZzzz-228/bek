<?php

declare(strict_types=1);

// =====================================================================
// Общие helper-функции для всех маршрутов API
// =====================================================================

/**
 * Получить JSON из тела запроса
 */
function getJsonInput(): array
{
    $raw = file_get_contents('php://input');
    if ($raw === false || $raw === '') {
        return [];
    }
    $data = json_decode($raw, true);
    return is_array($data) ? $data : [];
}

/**
 * Получить ID роли по коду
 */
function getRoleIdByCode(PDO $pdo, string $code): int
{
    $stmt = $pdo->prepare('SELECT id FROM roles WHERE code = :code LIMIT 1');
    $stmt->execute(['code' => $code]);
    $id = $stmt->fetchColumn();
    if ($id === false) {
        Response::json(['ok' => false, 'message' => "Role '$code' not found"], 500);
    }
    return (int)$id;
}

/**
 * Получить роли пользователя
 */
function getUserRoles(PDO $pdo, int $userId): array
{
    $stmt = $pdo->prepare(
        'SELECT r.code FROM user_roles ur
         JOIN roles r ON r.id = ur.role_id
         WHERE ur.user_id = :uid'
    );
    $stmt->execute(['uid' => $userId]);
    return $stmt->fetchAll(PDO::FETCH_COLUMN);
}

/**
 * Проверить, что у пользователя есть хотя бы одна из ролей
 */
function userHasAnyRole(PDO $pdo, int $userId, array $codes): bool
{
    $roles = getUserRoles($pdo, $userId);
    return count(array_intersect($roles, $codes)) > 0;
}

/**
 * Извлечь Bearer token из заголовков и проверить
 * Возвращает payload JWT или null
 */
function getAuthPayload(): ?array
{
    $headers = function_exists('getallheaders') ? getallheaders() : [];
    $auth = $headers['Authorization'] ?? $headers['authorization'] ?? '';

    if (!is_string($auth) || stripos($auth, 'Bearer ') !== 0) {
        return null;
    }

    $token = trim(substr($auth, 7));
    if ($token === '') {
        return null;
    }

    try {
        return Jwt::verify($token);
    } catch (Throwable $e) {
        return null;
    }
}

/**
 * Требовать авторизацию. Если не авторизован — отдать 401 и завершить
 */
function requireAuth(): array
{
    $payload = getAuthPayload();
    if ($payload === null) {
        Response::json(['ok' => false, 'message' => 'Unauthorized'], 401);
    }
    return $payload;
}

/**
 * Требовать конкретную роль. 403 если не подходит
 */
function requireRole(PDO $pdo, array $allowedRoles): array
{
    $payload = requireAuth();
    $userId = (int)($payload['sub'] ?? 0);
    if ($userId <= 0) {
        Response::json(['ok' => false, 'message' => 'Invalid token'], 401);
    }
    if (!userHasAnyRole($pdo, $userId, $allowedRoles)) {
        Response::json(['ok' => false, 'message' => 'Forbidden: insufficient role'], 403);
    }
    return ['user_id' => $userId, 'payload' => $payload];
}

/**
 * Простой rate limit на основе файлов
 */
function isRateLimited(string $key, int $maxAttempts, int $windowSec): bool
{
    $dir = __DIR__ . '/../../tmp_rate';
    if (!is_dir($dir)) {
        @mkdir($dir, 0755, true);
    }
    $file = $dir . '/' . md5($key) . '.json';
    $now = time();
    $data = ['count' => 0, 'first' => $now];

    if (file_exists($file)) {
        $raw = @file_get_contents($file);
        $tmp = json_decode((string)$raw, true);
        if (is_array($tmp) && isset($tmp['first'], $tmp['count'])) {
            if ($now - (int)$tmp['first'] < $windowSec) {
                $data = $tmp;
            }
        }
    }

    $data['count'] = (int)$data['count'] + 1;
    @file_put_contents($file, json_encode($data));

    return $data['count'] > $maxAttempts;
}

/**
 * Извлечь параметр из path (например /career/vacancies/{id})
 * Возвращает (int) последний сегмент пути или 0
 */
function pathLastIntSegment(string $path): int
{
    $parts = array_values(array_filter(explode('/', $path), fn($p) => $p !== ''));
    if (empty($parts)) {
        return 0;
    }
    $last = end($parts);
    return is_numeric($last) ? (int)$last : 0;
}

/**
 * Сопоставить путь с шаблоном вида /career/vacancies/{id}
 * Возвращает массив параметров или null
 */
function matchPath(string $pattern, string $path): ?array
{
    $regex = preg_replace('#\\\\\{([a-z_]+)\\\\\}#i', '(?P<$1>[^/]+)', preg_quote($pattern, '#'));
    $regex = '#^' . $regex . '$#';
    if (preg_match($regex, $path, $m)) {
        $params = [];
        foreach ($m as $k => $v) {
            if (!is_int($k)) {
                $params[$k] = $v;
            }
        }
        return $params;
    }
    return null;
}
