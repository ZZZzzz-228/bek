<?php
require __DIR__ . '/_bootstrap.php';
$user = requireLogin();

function tableExists(PDO $pdo, string $name): bool
{
    try {
        $stmt = $pdo->query('SHOW TABLES LIKE ' . $pdo->quote($name));
        return (bool)$stmt->fetchColumn();
    } catch (Throwable $e) {
        return false;
    }
}

function columnExists(PDO $pdo, string $table, string $column): bool
{
    try {
        $stmt = $pdo->prepare("SHOW COLUMNS FROM `{$table}` LIKE :c");
        $stmt->execute(['c' => $column]);
        return (bool)$stmt->fetchColumn();
    } catch (Throwable $e) {
        return false;
    }
}

function safeCount(PDO $pdo, string $sql): int
{
    try {
        return (int)$pdo->query($sql)->fetchColumn();
    } catch (Throwable $e) {
        return 0;
    }
}

$appsTable = tableExists($pdo, 'applications');

// ── KPI ────────────────────────────────────────────────────────────────────
$newApps         = $appsTable ? safeCount($pdo, 'SELECT COUNT(*) FROM applications WHERE status = "new"') : 0;
$studentsTotal   = safeCount(
    $pdo,
    "SELECT COUNT(DISTINCT u.id) FROM users u
     JOIN user_roles ur ON ur.user_id = u.id
     JOIN roles r ON r.id = ur.role_id AND r.code = 'student'"
);
$newsPublished   = safeCount($pdo, 'SELECT COUNT(*) FROM news_items WHERE is_published = 1');
$vacanciesActive = safeCount($pdo, 'SELECT COUNT(*) FROM vacancies WHERE is_active = 1');

// ── Модуль "Карьера": активные вакансии (не истёкшие) + ближайшие мероприятия
$careerVacancies = safeCount(
    $pdo,
    'SELECT COUNT(*) FROM vacancies
     WHERE is_active = 1 AND (expires_at IS NULL OR expires_at >= CURDATE())'
);
$careerEventsUpcoming = 0;
if (tableExists($pdo, 'events')) {
    $careerEventsUpcoming = safeCount(
        $pdo,
        'SELECT COUNT(*) FROM events WHERE is_published = 1 AND starts_at >= NOW()'
    );
}
$careerTotal = $careerVacancies + $careerEventsUpcoming;

// Бейдж со счётчиком pending-записей в VK предложке (если таблица есть)
$pendingVk = 0;
if (tableExists($pdo, 'vk_pending_stories')) {
    $pendingVk = safeCount($pdo, "SELECT COUNT(*) FROM vk_pending_stories WHERE status = 'pending'");
}

// ── График заявок за 14 дней ───────────────────────────────────────────────
$chartDays   = [];
$chartCounts = array_fill(0, 14, 0);
if ($appsTable) {
    for ($i = 13; $i >= 0; $i--) {
        $chartDays[] = date('Y-m-d', strtotime("-{$i} days"));
    }
    $from = $chartDays[0] . ' 00:00:00';
    $to   = $chartDays[13] . ' 23:59:59';
    try {
        $stmt = $pdo->prepare(
            'SELECT DATE(created_at) AS d, COUNT(*) AS c FROM applications
             WHERE created_at >= :from AND created_at <= :to
             GROUP BY DATE(created_at)'
        );
        $stmt->execute(['from' => $from, 'to' => $to]);
        $byDay = [];
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $r) {
            $byDay[(string)$r['d']] = (int)$r['c'];
        }
        foreach ($chartDays as $idx => $d) {
            $chartCounts[$idx] = $byDay[$d] ?? 0;
        }
    } catch (Throwable $e) {
        // Тихо падаем — оставим нули
    }
}
$maxBar = max($chartCounts) ?: 1;

// ── Последние заявки ───────────────────────────────────────────────────────
$lastApps = [];
if ($appsTable) {
    $hasSpecText = columnExists($pdo, 'applications', 'specialty_text');
    $hasSpecName = columnExists($pdo, 'applications', 'specialty_name');

    if ($hasSpecText) {
        $specSel = 'specialty_text';
    } elseif ($hasSpecName) {
        $specSel = 'specialty_name AS specialty_text';
    } else {
        $specSel = "'' AS specialty_text";
    }

    try {
        $lastApps = $pdo->query(
            "SELECT id, full_name, phone, email, {$specSel}, status, created_at, type
             FROM applications
             ORDER BY id DESC
             LIMIT 6"
        )->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable $e) {
        error_log('Dashboard lastApps failed: ' . $e->getMessage());
        $lastApps = [];
    }
}

// ── Последние новости ──────────────────────────────────────────────────────
$lastNews = [];
try {
    $lastNews = $pdo->query(
        'SELECT id, title, published_at FROM news_items ORDER BY id DESC LIMIT 5'
    )->fetchAll(PDO::FETCH_ASSOC);
} catch (Throwable $e) {}

// ── Последние входы в систему ──────────────────────────────────────────────
$recentLogins = [];
if (tableExists($pdo, 'admin_login_log')) {
    try {
        $recentLogins = $pdo->query(
            'SELECT u.full_name, u.email, l.ip, l.created_at
             FROM admin_login_log l
             JOIN users u ON u.id = l.user_id
             ORDER BY l.created_at DESC
             LIMIT 5'
        )->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable $e) {
        $recentLogins = [];
    }
}

function statusRu(string $s): string
{
    return match ($s) {
        'new'        => 'Новая',
        'processing' => 'В работе',
        'approved'   => 'Принята',
        'rejected'   => 'Отклонена',
        default      => $s,
    };
}

$title = 'Дашборд';
require __DIR__ . '/_layout_top.php';
$msg = flash();
if ($msg): ?>
  <div class="flash"><?= h($msg) ?></div>
<?php endif; ?>

<div class="kpiGrid">
  <div class="kpiCard <?= $newApps > 5 ? 'alert' : '' ?>">
    <div class="kpiValue"><?= (int)$newApps ?></div>
    <div class="kpiLabel">Новых заявок</div>
  </div>
  <div class="kpiCard">
    <div class="kpiValue"><?= (int)$studentsTotal ?></div>
    <div class="kpiLabel">Студентов в системе</div>
  </div>
  <div class="kpiCard">
    <div class="kpiValue"><?= (int)$newsPublished ?></div>
    <div class="kpiLabel">Опубликовано новостей</div>
  </div>
  <div class="kpiCard">
    <div class="kpiValue"><?= (int)$vacanciesActive ?></div>
    <div class="kpiLabel">Активных вакансий</div>
  </div>
  <?php if ($pendingVk > 0): ?>
  <div class="kpiCard alert">
    <div class="kpiValue"><?= (int)$pendingVk ?></div>
    <div class="kpiLabel">ВК предложка ожидает</div>
  </div>
  <?php endif; ?>
  <a href="/api/public/admin/career/dashboard.php" class="kpiCard" style="text-decoration:none; color:inherit; cursor:pointer; border-left:4px solid #0d6efd;">
    <div class="kpiValue"><?= (int)$careerTotal ?></div>
    <div class="kpiLabel">🚀 Карьера: вакансии + события</div>
  </a>
</div>

<div class="grid2">
  <div class="card">
    <h2>Заявки за 14 дней</h2>
    <?php if (!$appsTable): ?>
      <p class="muted">Таблица заявок не создана. Выполните миграцию <code>api/database/migration_admin_panel_v2.sql</code>.</p>
    <?php else: ?>
      <div class="chart">
        <?php foreach ($chartDays as $i => $d): ?>
          <?php $h = (int)round(($chartCounts[$i] / $maxBar) * 120); ?>
          <div class="chartCol">
            <div class="chartBar" style="height: <?= max(4, $h) ?>px;" title="<?= h($d) ?>: <?= (int)$chartCounts[$i] ?>"></div>
            <div class="chartLbl"><?= h(substr($d, 5)) ?></div>
          </div>
        <?php endforeach; ?>
      </div>
    <?php endif; ?>
  </div>

  <div class="card">
    <h2>Быстрые действия</h2>
    <div class="quickActions">
      <a class="btn btnAccent" href="/api/public/admin/news.php">Добавить новость</a>
      <?php if (hasRole('admin')): ?>
        <a class="btn" href="/api/public/admin/students.php?create=1">Создать студента</a>
      <?php endif; ?>
      <a class="btn btnGhost" href="/api/public/admin/applications.php">Все заявки</a>
      <?php if ($pendingVk > 0): ?>
        <a class="btn btnGhost" href="/api/public/admin/vk_pending.php">ВК предложка (<?= (int)$pendingVk ?>)</a>
      <?php endif; ?>
      <!-- Карьера -->
      <a class="btn btnAccent" href="/api/public/admin/career/dashboard.php" style="background:#0d6efd;">🚀 Модуль «Карьера»</a>
      <a class="btn btnGhost" href="/api/public/admin/career/vacancies.php">Вакансии</a>
      <a class="btn btnGhost" href="/api/public/admin/career/events.php">Мероприятия</a>
    </div>
    <p class="muted" style="margin-top:12px;">
      Вы вошли как <?= h((string)($user['full_name'] ?? '')) ?>
      (<?= h(implode(', ', (array)($user['roles'] ?? []))) ?>).
    </p>
  </div>
</div>

<div class="grid2">
  <div class="card">
    <h2>Последние заявки</h2>
    <?php if (!$lastApps): ?>
      <p class="muted">Пока нет заявок.</p>
    <?php else: ?>
      <div class="tableWrap">
        <table>
          <thead>
            <tr>
              <th>Дата</th>
              <th>ФИО</th>
              <th>Специальность</th>
              <th>Статус</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
          <?php foreach ($lastApps as $a):
            $statusClass = match ((string)$a['status']) {
                'new'        => 'stNew',
                'processing' => 'stProc',
                'approved'   => 'stOk',
                default      => 'stNo',
            };
          ?>
            <tr>
              <td><?= h((string)$a['created_at']) ?></td>
              <td><?= h((string)$a['full_name']) ?></td>
              <td><?= h((string)($a['specialty_text'] ?? '')) ?></td>
              <td><span class="<?= $statusClass ?>"><?= h(statusRu((string)$a['status'])) ?></span></td>
              <td><a href="/api/public/admin/application_view.php?id=<?= (int)$a['id'] ?>">Открыть</a></td>
            </tr>
          <?php endforeach; ?>
          </tbody>
        </table>
      </div>
    <?php endif; ?>
  </div>

  <div class="card">
    <h2>Последние новости</h2>
    <?php if (!$lastNews): ?>
      <p class="muted">Новостей нет.</p>
    <?php else: ?>
      <ul style="margin:0;padding-left:18px;">
        <?php foreach ($lastNews as $n): ?>
          <li style="margin-bottom:8px;">
            <a href="/api/public/admin/news.php?edit=<?= (int)$n['id'] ?>"><?= h((string)$n['title']) ?></a>
            <span class="muted"> — <?= h((string)($n['published_at'] ?? '')) ?></span>
          </li>
        <?php endforeach; ?>
      </ul>
    <?php endif; ?>
  </div>
</div>

<?php if ($recentLogins): ?>
<div class="card">
  <h2>Последние входы в систему</h2>
  <div class="tableWrap">
    <table>
      <thead>
        <tr><th>Пользователь</th><th>IP</th><th>Время</th></tr>
      </thead>
      <tbody>
      <?php foreach ($recentLogins as $log): ?>
        <tr>
          <td>
            <?= h((string)$log['full_name']) ?><br>
            <span class="muted" style="font-size:.85em;"><?= h((string)$log['email']) ?></span>
          </td>
          <td><?= h((string)$log['ip']) ?></td>
          <td><?= h(substr((string)$log['created_at'], 0, 16)) ?></td>
        </tr>
      <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</div>
<?php endif; ?>

<?php require __DIR__ . '/_layout_bottom.php'; ?>
