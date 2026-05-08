<?php
/**
 * Одноразовый запуск миграции таблицы vk_pending_stories.
 *
 * Куда положить: /api/database/apply_vk_migration.php (рядом с migration_vk_pending_stories.sql).
 * Открыть в браузере один раз: https://kucersta.beget.tech/api/database/apply_vk_migration.php
 * После успешного применения — УДАЛИТЬ файл.
 */
declare(strict_types=1);

require_once __DIR__ . '/../src/Database.php';
$config = require __DIR__ . '/../config.php';
$pdo = Database::connect($config);

$sqlPath = __DIR__ . '/migration_vk_pending_stories.sql';
if (!is_file($sqlPath)) {
    http_response_code(500);
    echo 'migration_vk_pending_stories.sql not found';
    exit;
}

$sql = (string)file_get_contents($sqlPath);
$statements = array_filter(array_map('trim', preg_split('/;\s*\n/', $sql)));

$ok = 0;
$errors = [];
foreach ($statements as $stmt) {
    if ($stmt === '') {
        continue;
    }
    $stmt = rtrim($stmt, ';');
    try {
        $pdo->exec($stmt);
        $ok++;
    } catch (Throwable $e) {
        $errors[] = $e->getMessage() . "\n--- statement ---\n" . $stmt;
    }
}

header('Content-Type: text/plain; charset=utf-8');
echo "Applied statements: {$ok}\n";
if ($errors) {
    echo "Errors:\n";
    foreach ($errors as $e) {
        echo "----\n{$e}\n";
    }
} else {
    echo "OK. Удалите этот файл после применения миграции.\n";
}
