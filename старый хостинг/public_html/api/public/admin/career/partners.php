<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';

$pageTitle = 'Карьера — Партнёры';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $canEdit) {
    $action = (string)($_POST['action'] ?? '');
    $ids = array_map('intval', (array)($_POST['ids'] ?? []));
    if (!empty($ids)) {
        $in = implode(',', array_fill(0, count($ids), '?'));
        if ($action === 'publish') $pdo->prepare("UPDATE partners SET is_published = 1 WHERE id IN ($in)")->execute($ids);
        if ($action === 'unpublish') $pdo->prepare("UPDATE partners SET is_published = 0 WHERE id IN ($in)")->execute($ids);
        if ($action === 'delete') $pdo->prepare("DELETE FROM partners WHERE id IN ($in)")->execute($ids);
    }
    header('Location: partners.php');
    exit;
}

$rows = $pdo->query(
    'SELECT p.*, (SELECT COUNT(*) FROM vacancies v WHERE v.partner_id = p.id AND v.is_active = 1) AS active_vacancies
     FROM partners p ORDER BY p.sort_order ASC, p.name ASC'
)->fetchAll();

require_once __DIR__ . '/../_layout_top.php';
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>
    <div class="career-content">
        <div style="display:flex; justify-content:space-between; align-items:center;">
            <h1>🤝 Партнёры</h1>
            <?php if ($canEdit): ?>
                <a href="partner_edit.php" style="padding:8px 16px; background:#0d6efd; color:white; text-decoration:none; border-radius:6px;">+ Новый партнёр</a>
            <?php endif; ?>
        </div>

        <form method="post">
            <?php if ($canEdit): ?>
            <div style="margin:12px 0;">
                <select name="action" style="padding:6px;">
                    <option value="">— Действие —</option>
                    <option value="publish">Опубликовать</option>
                    <option value="unpublish">Скрыть</option>
                    <option value="delete">Удалить</option>
                </select>
                <button type="submit" onclick="return confirm('Применить?')" style="padding:6px 12px; background:#6c757d; color:white; border:none; border-radius:4px;">Применить</button>
            </div>
            <?php endif; ?>

            <table style="width:100%; border-collapse:collapse; background:white; border:1px solid #e0e0e0; border-radius:8px;">
                <thead style="background:#f8f9fa;">
                    <tr>
                        <?php if ($canEdit): ?><th style="padding:10px;"><input type="checkbox" onchange="document.querySelectorAll('input[name=\'ids[]\']').forEach(c=>c.checked=this.checked)"></th><?php endif; ?>
                        <th style="padding:10px; text-align:left;">Лого</th>
                        <th style="padding:10px; text-align:left;">Название</th>
                        <th style="padding:10px; text-align:left;">Сайт</th>
                        <th style="padding:10px; text-align:left;">Активн. вакансий</th>
                        <th style="padding:10px; text-align:left;">Сортировка</th>
                        <th style="padding:10px;"></th>
                    </tr>
                </thead>
                <tbody>
                <?php foreach ($rows as $p): ?>
                    <tr style="border-top:1px solid #f0f0f0;">
                        <?php if ($canEdit): ?><td style="padding:10px;"><input type="checkbox" name="ids[]" value="<?= $p['id'] ?>"></td><?php endif; ?>
                        <td style="padding:10px;">
                            <?php if ($p['logo_url']): ?>
                                <img src="<?= htmlspecialchars($p['logo_url']) ?>" style="width:48px; height:48px; object-fit:contain; background:#f8f9fa; border-radius:4px;">
                            <?php else: ?>
                                <div style="width:48px; height:48px; background:#e9ecef; border-radius:4px;"></div>
                            <?php endif; ?>
                        </td>
                        <td style="padding:10px;">
                            <strong><?= htmlspecialchars($p['name']) ?></strong>
                            <?php if (!$p['is_published']): ?> <small style="color:#dc3545;">(скрыт)</small><?php endif; ?>
                        </td>
                        <td style="padding:10px;"><?= $p['website_url'] ? '<a href="'.htmlspecialchars($p['website_url']).'" target="_blank">'.htmlspecialchars(parse_url($p['website_url'], PHP_URL_HOST) ?: $p['website_url']).'</a>' : '—' ?></td>
                        <td style="padding:10px;"><?= $p['active_vacancies'] ?></td>
                        <td style="padding:10px;"><?= $p['sort_order'] ?></td>
                        <td style="padding:10px;"><a href="partner_edit.php?id=<?= $p['id'] ?>">✏️</a></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </form>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
