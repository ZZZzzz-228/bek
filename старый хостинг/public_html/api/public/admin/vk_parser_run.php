<?php
/**
 * HTTP-обёртка для ручного запуска Scrapy-парсера VK прямо из админки.
 *
 * Куда положить: /api/public/admin/vk_parser_run.php
 *
 * Доступ:
 *   - admin / staff / content_manager (через requireLogin + canManageContent)
 *
 * Что делает:
 *   - Запускает bash-скрипт ~/vk_scrapy_parser/bin/run_parser.sh
 *   - Возвращает JSON с результатом ({"ok":true|false, "stdout":"...", "stderr":"..."})
 *
 * ВАЖНО: путь до run_parser.sh должен совпадать с тем, куда ты установил парсер.
 * Поправь PARSER_RUN_SCRIPT под свой хостинг (или задай env-переменную в .htaccess /
 * .user.ini / на уровне shell).
 */
declare(strict_types=1);

require __DIR__ . '/_bootstrap.php';
requireLogin();
if (!canManageContent()) {
    http_response_code(403);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['ok' => false, 'message' => 'forbidden']);
    exit;
}

// ─── Где лежит run_parser.sh ────────────────────────────────────────────────
// На Beget путь обычно вида /home/u/USERNAME/vk_scrapy_parser/bin/run_parser.sh
$candidates = [
    '/home/k/kucersta/kucersta.beget.tech/vk_scrapy_parser/bin/run_parser.sh',
    getenv('VK_PARSER_RUN_SCRIPT') ?: '',
    rtrim((string)($_SERVER['HOME'] ?? ''), '/') . '/vk_scrapy_parser/bin/run_parser.sh',
    '/home/' . get_current_user() . '/vk_scrapy_parser/bin/run_parser.sh',
];
$scriptPath = '';
foreach ($candidates as $c) {
    if ($c !== '' && is_file($c)) {
        $scriptPath = $c;
        break;
    }
}

header('Content-Type: application/json; charset=utf-8');

if ($scriptPath === '') {
    echo json_encode([
        'ok' => false,
        'message' => 'run_parser.sh не найден. Задай переменную окружения VK_PARSER_RUN_SCRIPT или поправь путь в vk_parser_run.php.',
        'tried' => $candidates,
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

if (!function_exists('proc_open')) {
    echo json_encode([
        'ok' => false,
        'message' => 'PHP-функция proc_open() отключена на этом хостинге. Запускай парсер по cron или через SSH.',
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

// Запускаем bash run_parser.sh, ловим вывод, ставим жёсткий лимит времени
$cmd = 'bash ' . escapeshellarg($scriptPath) . ' 2>&1';

$descriptors = [
    0 => ['pipe', 'r'],
    1 => ['pipe', 'w'],
    2 => ['pipe', 'w'],
];
$pipes = [];
$proc = proc_open($cmd, $descriptors, $pipes);
if (!is_resource($proc)) {
    echo json_encode(['ok' => false, 'message' => 'Не удалось запустить процесс.'], JSON_UNESCAPED_UNICODE);
    exit;
}

fclose($pipes[0]);
stream_set_blocking($pipes[1], false);
stream_set_blocking($pipes[2], false);

$stdout = '';
$stderr = '';
$start  = microtime(true);
$timeoutSec = 110; // даём парсеру до ~2 минут (Beget убьёт PHP по max_execution_time)

while (true) {
    $status = proc_get_status($proc);
    $stdout .= (string)stream_get_contents($pipes[1]);
    $stderr .= (string)stream_get_contents($pipes[2]);
    if (!$status['running']) {
        break;
    }
    if ((microtime(true) - $start) > $timeoutSec) {
        proc_terminate($proc, 9);
        break;
    }
    usleep(200_000);
}
$stdout .= (string)stream_get_contents($pipes[1]);
$stderr .= (string)stream_get_contents($pipes[2]);

fclose($pipes[1]);
fclose($pipes[2]);
$exitCode = proc_close($proc);

$elapsed = round(microtime(true) - $start, 1);

// Подтянем последний run из vk_parser_runs
$lastRun = null;
try {
    $row = $pdo->query(
        'SELECT id, fetched_total, added_new, skipped_dup, status, message, started_at, finished_at
         FROM vk_parser_runs
         ORDER BY id DESC
         LIMIT 1'
    )->fetch(PDO::FETCH_ASSOC);
    if ($row) {
        $lastRun = $row;
    }
} catch (Throwable $e) {
    // ignore
}

echo json_encode([
    'ok'        => $exitCode === 0,
    'exit_code' => $exitCode,
    'elapsed_s' => $elapsed,
    'stdout'    => mb_substr($stdout, -8000),
    'stderr'    => mb_substr($stderr, -2000),
    'last_run'  => $lastRun,
], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
