<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';

$pageTitle = 'Карьера — Дашборд';
require_once __DIR__ . '/../_layout_top.php';

// Сбор статистики
$stats = [
    'vacancies_total'   => (int)$pdo->query('SELECT COUNT(*) FROM vacancies')->fetchColumn(),
    'vacancies_active'  => (int)$pdo->query('SELECT COUNT(*) FROM vacancies WHERE is_active = 1 AND (expires_at IS NULL OR expires_at >= CURDATE())')->fetchColumn(),
    'vacancies_expiring'=> (int)$pdo->query('SELECT COUNT(*) FROM vacancies WHERE is_active = 1 AND expires_at BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)')->fetchColumn(),
    'partners_total'    => (int)$pdo->query('SELECT COUNT(*) FROM partners WHERE is_published = 1')->fetchColumn(),
    'events_upcoming'   => (int)$pdo->query('SELECT COUNT(*) FROM events WHERE is_published = 1 AND starts_at >= NOW()')->fetchColumn(),
    'events_past'       => (int)$pdo->query('SELECT COUNT(*) FROM events WHERE is_published = 1 AND starts_at < NOW()')->fetchColumn(),
    'portfolios_total'  => (int)$pdo->query('SELECT COUNT(*) FROM student_portfolio_items WHERE is_published = 1')->fetchColumn(),
    'resumes_total'     => (int)$pdo->query('SELECT COUNT(*) FROM student_resumes WHERE is_published = 1')->fetchColumn(),
    'career_staff'      => (int)$pdo->query("SELECT COUNT(*) FROM staff_members WHERE department = 'career_center' AND is_published = 1")->fetchColumn(),
];

// Ближайшие 5 мероприятий
$upcomingEvents = $pdo->query(
    'SELECT id, title, starts_at, location, category FROM events
     WHERE is_published = 1 AND starts_at >= NOW()
     ORDER BY starts_at ASC LIMIT 5'
)->fetchAll();

// Истекающие вакансии
$expiringVacancies = $pdo->query(
    'SELECT id, title, company, expires_at FROM vacancies
     WHERE is_active = 1 AND expires_at BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 14 DAY)
     ORDER BY expires_at ASC LIMIT 10'
)->fetchAll();
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>

    <div class="career-content">
        <h1>📊 Дашборд модуля «Карьера»</h1>
        <p style="color: #6c757d;">Сводка по вакансиям, партнёрам, мероприятиям и студенческому контенту.</p>

        <style>
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); gap: 16px; margin: 20px 0; }
        .stat-card { background: white; border: 1px solid #e0e0e0; border-radius: 8px; padding: 16px; }
        .stat-card .label { color: #6c757d; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-card .value { font-size: 28px; font-weight: 700; color: #212529; margin-top: 6px; }
        .stat-card.warn { border-left: 4px solid #ffc107; }
        .stat-card.ok { border-left: 4px solid #198754; }
        .stat-card.info { border-left: 4px solid #0d6efd; }
        .panel { background: white; border: 1px solid #e0e0e0; border-radius: 8px; padding: 16px; margin: 16px 0; }
        .panel h3 { margin-top: 0; }
        .panel table { width: 100%; border-collapse: collapse; }
        .panel table td, .panel table th { padding: 8px; border-bottom: 1px solid #f0f0f0; text-align: left; font-size: 14px; }
        .panel table th { color: #6c757d; font-weight: 600; font-size: 12px; text-transform: uppercase; }
        .badge { display: inline-block; padding: 2px 8px; border-radius: 4px; font-size: 11px; }
        .badge-warn { background: #fff3cd; color: #856404; }
        .empty { padding: 24px; text-align: center; color: #6c757d; font-size: 14px; }
        </style>

        <div class="stats-grid">
            <div class="stat-card ok">
                <div class="label">Активных вакансий</div>
                <div class="value"><?= $stats['vacancies_active'] ?></div>
            </div>
            <div class="stat-card warn">
                <div class="label">Истекают за 7 дней</div>
                <div class="value"><?= $stats['vacancies_expiring'] ?></div>
            </div>
            <div class="stat-card info">
                <div class="label">Всего вакансий</div>
                <div class="value"><?= $stats['vacancies_total'] ?></div>
            </div>
            <div class="stat-card ok">
                <div class="label">Партнёров</div>
                <div class="value"><?= $stats['partners_total'] ?></div>
            </div>
            <div class="stat-card info">
                <div class="label">Будущих мероприятий</div>
                <div class="value"><?= $stats['events_upcoming'] ?></div>
            </div>
            <div class="stat-card">
                <div class="label">Прошедших мероприятий</div>
                <div class="value"><?= $stats['events_past'] ?></div>
            </div>
            <div class="stat-card info">
                <div class="label">Портфолио студентов</div>
                <div class="value"><?= $stats['portfolios_total'] ?></div>
            </div>
            <div class="stat-card info">
                <div class="label">Резюме (опубл.)</div>
                <div class="value"><?= $stats['resumes_total'] ?></div>
            </div>
            <div class="stat-card">
                <div class="label">Сотрудников центра</div>
                <div class="value"><?= $stats['career_staff'] ?></div>
            </div>
        </div>

        <div class="panel">
            <h3>📅 Ближайшие мероприятия</h3>
            <?php if (empty($upcomingEvents)): ?>
                <div class="empty">Нет запланированных мероприятий. <a href="event_edit.php">Создать</a></div>
            <?php else: ?>
                <table>
                    <thead><tr><th>Когда</th><th>Название</th><th>Где</th><th>Категория</th><th></th></tr></thead>
                    <tbody>
                    <?php foreach ($upcomingEvents as $e): ?>
                        <tr>
                            <td><?= date('d.m.Y H:i', strtotime($e['starts_at'])) ?></td>
                            <td><?= htmlspecialchars($e['title']) ?></td>
                            <td><?= htmlspecialchars($e['location'] ?? '—') ?></td>
                            <td><?= htmlspecialchars($e['category']) ?></td>
                            <td><a href="event_edit.php?id=<?= $e['id'] ?>">✏️</a></td>
                        </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>

        <div class="panel">
            <h3>⚠️ Истекающие вакансии (14 дней)</h3>
            <?php if (empty($expiringVacancies)): ?>
                <div class="empty">Нет истекающих вакансий</div>
            <?php else: ?>
                <table>
                    <thead><tr><th>До</th><th>Должность</th><th>Компания</th><th></th></tr></thead>
                    <tbody>
                    <?php foreach ($expiringVacancies as $v): ?>
                        <tr>
                            <td><span class="badge badge-warn"><?= date('d.m.Y', strtotime($v['expires_at'])) ?></span></td>
                            <td><?= htmlspecialchars($v['title']) ?></td>
                            <td><?= htmlspecialchars($v['company']) ?></td>
                            <td><a href="vacancy_edit.php?id=<?= $v['id'] ?>">✏️</a></td>
                        </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
            <?php endif; ?>
        </div>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
