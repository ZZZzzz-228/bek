<?php
/**
 * Запускает миграцию исправления путей к изображениям.
 * Идемпотентен: можно прогонять много раз без вреда.
 *
 * Доступ: только админам.
 *   GET  /api/public/admin/run_image_paths_migration.php       — превью (что сделает)
 *   POST /api/public/admin/run_image_paths_migration.php?go=1  — реально применить
 */

declare(strict_types=1);

require_once __DIR__ . '/_bootstrap.php';
requireLogin();
requireRole('admin');

$migrationFile = __DIR__ . '/../../database/migration_fix_image_paths.sql';

if (!is_file($migrationFile)) {
    http_response_code(500);
    die('Миграционный файл не найден: ' . htmlspecialchars($migrationFile));
}

$sql = file_get_contents($migrationFile);
if ($sql === false || trim($sql) === '') {
    die('Не удалось прочитать миграционный файл.');
}

$apply = ($_SERVER['REQUEST_METHOD'] === 'POST') && isset($_GET['go']) && $_GET['go'] === '1';

header('Content-Type: text/html; charset=utf-8');
?><!doctype html>
<html lang="ru"><head><meta charset="utf-8">
<title>Миграция: исправление путей к изображениям</title>
<link rel="stylesheet" href="/api/public/admin/assets/admin.css">
<style>
  body{font-family:system-ui,Arial;padding:16px;max-width:1100px;}
  pre{background:#0f172a;color:#e2e8f0;padding:12px;border-radius:8px;overflow:auto;font-size:12px;line-height:1.5;}
  .ok{color:#16a34a;font-weight:600;}
  .bad{color:#dc2626;font-weight:600;}
  .warn{color:#d97706;}
  .box{padding:12px 16px;border-radius:8px;margin:12px 0;}
  .box.info{background:#eff6ff;border:1px solid #bfdbfe;}
  .box.ok{background:#dcfce7;border:1px solid #86efac;}
  .box.bad{background:#fee2e2;border:1px solid #fca5a5;}
  .btn{display:inline-block;padding:10px 18px;border-radius:8px;text-decoration:none;font-weight:600;}
  .btn-primary{background:#2563eb;color:#fff;border:0;cursor:pointer;}
  .btn-secondary{background:#e5e7eb;color:#111827;}
</style>
</head><body>
<h1>🛠 Миграция: исправление путей к изображениям</h1>
<p><a href="/api/public/admin/index.php">← Назад в админку</a> · <a href="/api/public/admin/check_image_paths.php">🩺 Проверка</a></p>

<?php if (!$apply): ?>
  <div class="box info">
    <p><strong>Режим: предпросмотр.</strong> Ничего ещё не применено.</p>
    <p>Скрипт сделает следующее (идемпотентно — повторные запуски безвредны):</p>
    <ol>
      <li>Привяжет логотипы партнёров к файлам в <code>uploads/partners/*.png</code> (по точному <code>name</code>);</li>
      <li>Добавит дополнительных партнёров (РУСАЛ, Полюс, Ванкорнефть и др.), если их ещё нет;</li>
      <li>Нормализует префикс URL: <code>/uploads/...</code> → <code>/api/public/uploads/...</code> во всех таблицах;</li>
      <li>Очистит ссылки на отсутствующие <code>/uploads/demo/*</code> (поставит NULL).</li>
    </ol>
  </div>

  <h3>SQL для применения:</h3>
  <pre><?= htmlspecialchars($sql) ?></pre>

  <form method="post" action="?go=1" onsubmit="return confirm('Применить миграцию к БД?');">
    <button type="submit" class="btn btn-primary">▶ Применить миграцию</button>
    <a href="/api/public/admin/index.php" class="btn btn-secondary">Отмена</a>
  </form>

<?php else: ?>
  <?php
  // Режим выполнения: разбиваем SQL на отдельные стейтменты по `;` в конце строк
  // (грубо, но рабоче — комментарии тоже надо вырезать).
  $clean = preg_replace('#--[^\n]*\n#', "\n", $sql);
  $statements = array_filter(array_map('trim', explode(';', (string)$clean)), fn($s) => $s !== '');

  $report = [];
  $errors = 0;
  $applied = 0;
  $totalAffected = 0;
  foreach ($statements as $i => $stmt) {
      try {
          $affected = $pdo->exec($stmt);
          $applied++;
          $totalAffected += (int)$affected;
          $report[] = ['ok' => true, 'sql' => $stmt, 'affected' => (int)$affected];
      } catch (Throwable $e) {
          $errors++;
          $report[] = ['ok' => false, 'sql' => $stmt, 'error' => $e->getMessage()];
      }
  }
  ?>
  <div class="box <?= $errors === 0 ? 'ok' : 'bad' ?>">
    <h2 style="margin:0;">
      <?= $errors === 0 ? '✓ Миграция применена успешно' : '⚠ Завершено с ошибками' ?>
    </h2>
    <p>Стейтментов выполнено: <strong><?= $applied ?></strong> · Ошибок: <strong><?= $errors ?></strong> · Затронуто строк всего: <strong><?= $totalAffected ?></strong></p>
  </div>

  <h3>Детали:</h3>
  <?php foreach ($report as $i => $r): ?>
    <details <?= !$r['ok'] ? 'open' : '' ?> style="margin-bottom:6px;">
      <summary class="<?= $r['ok'] ? 'ok' : 'bad' ?>">
        #<?= $i+1 ?> ·
        <?php if ($r['ok']): ?>
          ✓ OK · затронуто строк: <?= $r['affected'] ?>
        <?php else: ?>
          ✗ ОШИБКА: <?= htmlspecialchars($r['error']) ?>
        <?php endif; ?>
      </summary>
      <pre><?= htmlspecialchars($r['sql']) ?></pre>
    </details>
  <?php endforeach; ?>

  <p style="margin-top:24px;">
    <a href="/api/public/admin/check_image_paths.php" class="btn btn-primary">🩺 Запустить проверку картинок</a>
    <a href="/api/public/admin/index.php" class="btn btn-secondary">← В админку</a>
  </p>
<?php endif; ?>

</body></html>
