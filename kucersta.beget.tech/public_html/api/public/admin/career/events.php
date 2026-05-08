<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';

$pageTitle = 'Карьера — Мероприятия';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $canEdit) {
    $action = (string)($_POST['action'] ?? '');
    $ids = array_map('intval', (array)($_POST['ids'] ?? []));
    if (!empty($ids)) {
        $in = implode(',', array_fill(0, count($ids), '?'));
        if ($action === 'publish') $pdo->prepare("UPDATE events SET is_published = 1 WHERE id IN ($in)")->execute($ids);
        if ($action === 'unpublish') $pdo->prepare("UPDATE events SET is_published = 0 WHERE id IN ($in)")->execute($ids);
        if ($action === 'delete') $pdo->prepare("DELETE FROM events WHERE id IN ($in)")->execute($ids);
    }
    header('Location: events.php');
    exit;
}

$filterPeriod = (string)($_GET['period'] ?? 'all');
$where = ['1=1'];
if ($filterPeriod === 'upcoming') $where[] = 'starts_at >= NOW()';
if ($filterPeriod === 'past') $where[] = 'starts_at < NOW()';

$sql = 'SELECT e.*, p.name AS partner_name FROM events e
        LEFT JOIN partners p ON p.id = e.partner_id
        WHERE ' . implode(' AND ', $where) . '
        ORDER BY e.starts_at DESC LIMIT 500';
$rows = $pdo->query($sql)->fetchAll();

require_once __DIR__ . '/../_layout_top.php';
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>
    <div class="career-content">
        <div style="display:flex; justify-content:space-between; align-items:center;">
            <h1>📅 Мероприятия</h1>
            <?php if ($canEdit): ?>
                <a href="event_edit.php" style="padding:8px 16px; background:#0d6efd; color:white; text-decoration:none; border-radius:6px;">+ Новое мероприятие</a>
            <?php endif; ?>
        </div>

        <div style="margin:16px 0;">
            <a href="?period=all" style="padding:6px 12px; <?= $filterPeriod==='all' ? 'background:#0d6efd; color:white;' : 'color:#6c757d;' ?>; text-decoration:none; border-radius:4px;">Все</a>
            <a href="?period=upcoming" style="padding:6px 12px; <?= $filterPeriod==='upcoming' ? 'background:#0d6efd; color:white;' : 'color:#6c757d;' ?>; text-decoration:none; border-radius:4px;">Будущие</a>
            <a href="?period=past" style="padding:6px 12px; <?= $filterPeriod==='past' ? 'background:#0d6efd; color:white;' : 'color:#6c757d;' ?>; text-decoration:none; border-radius:4px;">Прошедшие</a>
        </div>

        <form method="post">
            <?php if ($canEdit): ?>
            <div style="margin-bottom:8px;">
                <select name="action" style="padding:6px;">
                    <option value="">— Действие —</option>
                    <option value="publish">Опубликовать</option>
                    <option value="unpublish">Скрыть</option>
                    <option value="delete">Удалить</option>
                </select>
                <button type="submit" onclick="return confirm('Применить?')" style="padding:6px 12px;">Применить</button>
            </div>
            <?php endif; ?>

            <table style="width:100%; border-collapse:collapse; background:white; border:1px solid #e0e0e0; border-radius:8px;">
                <thead style="background:#f8f9fa;">
                    <tr>
                        <?php if ($canEdit): ?><th style="padding:10px;"><input type="checkbox" onchange="document.querySelectorAll('input[name=\'ids[]\']').forEach(c=>c.checked=this.checked)"></th><?php endif; ?>
                        <th style="padding:10px; text-align:left;">Когда</th>
                        <th style="padding:10px; text-align:left;">Название</th>
                        <th style="padding:10px; text-align:left;">Где</th>
                        <th style="padding:10px; text-align:left;">Категория</th>
                        <th style="padding:10px; text-align:left;">Партнёр</th>
                        <th style="padding:10px; text-align:left;">Статус</th>
                        <th style="padding:10px;"></th>
                    </tr>
                </thead>
                <tbody>
                <?php if (empty($rows)): ?>
                    <tr><td colspan="8" style="padding:24px; text-align:center; color:#6c757d;">Нет мероприятий</td></tr>
                <?php else: foreach ($rows as $e): ?>
                    <tr style="border-top:1px solid #f0f0f0;">
                        <?php if ($canEdit): ?><td style="padding:10px;"><input type="checkbox" name="ids[]" value="<?= $e['id'] ?>"></td><?php endif; ?>
                        <td style="padding:10px;"><?= date('d.m.Y H:i', strtotime($e['starts_at'])) ?></td>
                        <td style="padding:10px;"><strong><?= htmlspecialchars($e['title']) ?></strong></td>
                        <td style="padding:10px;"><?= htmlspecialchars($e['location'] ?? '—') ?></td>
                        <td style="padding:10px;"><?= htmlspecialchars($e['category']) ?></td>
                        <td style="padding:10px;"><?= htmlspecialchars($e['partner_name'] ?? '—') ?></td>
                        <td style="padding:10px;">
                            <?php if ($e['is_published']): ?>
                                <span style="padding:2px 8px; background:#d1e7dd; color:#0a3622; border-radius:4px; font-size:11px;">Опубл.</span>
                            <?php else: ?>
                                <span style="padding:2px 8px; background:#f8d7da; color:#58151c; border-radius:4px; font-size:11px;">Скрыто</span>
                            <?php endif; ?>
                        </td>
                        <td style="padding:10px;"><a href="event_edit.php?id=<?= $e['id'] ?>">✏️</a></td>
                    </tr>
                <?php endforeach; endif; ?>
                </tbody>
            </table>
        </form>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
