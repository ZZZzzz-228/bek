<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';

$pageTitle = 'Карьера — Вакансии';

// Обработка bulk-действий
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $canEdit) {
    $action = (string)($_POST['action'] ?? '');
    $ids = array_map('intval', (array)($_POST['ids'] ?? []));
    if (!empty($ids)) {
        $in = implode(',', array_fill(0, count($ids), '?'));
        if ($action === 'activate') {
            $pdo->prepare("UPDATE vacancies SET is_active = 1 WHERE id IN ($in)")->execute($ids);
        } elseif ($action === 'deactivate') {
            $pdo->prepare("UPDATE vacancies SET is_active = 0 WHERE id IN ($in)")->execute($ids);
        } elseif ($action === 'delete') {
            $pdo->prepare("DELETE FROM vacancies WHERE id IN ($in)")->execute($ids);
        }
    }
    header('Location: vacancies.php');
    exit;
}

// Фильтры
$filterPartner = (int)($_GET['partner_id'] ?? 0);
$filterStatus = (string)($_GET['status'] ?? 'all');
$filterQ = trim((string)($_GET['q'] ?? ''));

$where = ['1=1'];
$params = [];
if ($filterPartner > 0) { $where[] = 'v.partner_id = :pid'; $params['pid'] = $filterPartner; }
if ($filterStatus === 'active') { $where[] = 'v.is_active = 1 AND (v.expires_at IS NULL OR v.expires_at >= CURDATE())'; }
if ($filterStatus === 'inactive') { $where[] = 'v.is_active = 0'; }
if ($filterStatus === 'expired') { $where[] = 'v.expires_at IS NOT NULL AND v.expires_at < CURDATE()'; }
if ($filterQ !== '') { $where[] = '(v.title LIKE :q OR v.company LIKE :q)'; $params['q'] = '%' . $filterQ . '%'; }

$sql = 'SELECT v.id, v.title, v.company, v.partner_id, v.city, v.employment_type, v.salary,
               v.published_at, v.expires_at, v.is_active, p.name AS partner_name
        FROM vacancies v
        LEFT JOIN partners p ON p.id = v.partner_id
        WHERE ' . implode(' AND ', $where) . '
        ORDER BY v.published_at DESC, v.id DESC LIMIT 500';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$rows = $stmt->fetchAll();

$partners = $pdo->query('SELECT id, name FROM partners ORDER BY name')->fetchAll();

require_once __DIR__ . '/../_layout_top.php';
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>

    <div class="career-content">
        <div style="display:flex; justify-content:space-between; align-items:center;">
            <h1>💼 Вакансии</h1>
            <?php if ($canEdit): ?>
                <a href="vacancy_edit.php" class="btn btn-primary" style="padding:8px 16px; background:#0d6efd; color:white; text-decoration:none; border-radius:6px;">+ Новая вакансия</a>
            <?php endif; ?>
        </div>

        <form method="get" style="display:flex; gap:12px; margin: 16px 0; flex-wrap:wrap; align-items:end;">
            <div>
                <label style="display:block; font-size:12px; color:#666;">Поиск</label>
                <input type="text" name="q" value="<?= htmlspecialchars($filterQ) ?>" placeholder="Название/компания" style="padding:6px 10px; border:1px solid #ccc; border-radius:4px;">
            </div>
            <div>
                <label style="display:block; font-size:12px; color:#666;">Партнёр</label>
                <select name="partner_id" style="padding:6px 10px; border:1px solid #ccc; border-radius:4px;">
                    <option value="0">— Все —</option>
                    <?php foreach ($partners as $p): ?>
                        <option value="<?= $p['id'] ?>" <?= $filterPartner === (int)$p['id'] ? 'selected' : '' ?>>
                            <?= htmlspecialchars($p['name']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div>
                <label style="display:block; font-size:12px; color:#666;">Статус</label>
                <select name="status" style="padding:6px 10px; border:1px solid #ccc; border-radius:4px;">
                    <option value="all" <?= $filterStatus==='all'?'selected':'' ?>>Все</option>
                    <option value="active" <?= $filterStatus==='active'?'selected':'' ?>>Активные</option>
                    <option value="inactive" <?= $filterStatus==='inactive'?'selected':'' ?>>Неактивные</option>
                    <option value="expired" <?= $filterStatus==='expired'?'selected':'' ?>>Истёкшие</option>
                </select>
            </div>
            <button type="submit" style="padding:8px 16px; background:#6c757d; color:white; border:none; border-radius:4px; cursor:pointer;">Применить</button>
            <a href="vacancies.php" style="padding:8px 16px; color:#6c757d; text-decoration:none;">Сбросить</a>
        </form>

        <form method="post">
            <?php if ($canEdit): ?>
            <div style="margin-bottom:8px;">
                <select name="action" style="padding:6px;">
                    <option value="">— Действие —</option>
                    <option value="activate">Активировать</option>
                    <option value="deactivate">Деактивировать</option>
                    <option value="delete">Удалить</option>
                </select>
                <button type="submit" onclick="return confirm('Применить к выбранным?')" style="padding:6px 12px; background:#dc3545; color:white; border:none; border-radius:4px; cursor:pointer;">Применить</button>
            </div>
            <?php endif; ?>

            <table style="width:100%; border-collapse:collapse; background:white; border:1px solid #e0e0e0; border-radius:8px; overflow:hidden;">
                <thead style="background:#f8f9fa;">
                    <tr>
                        <?php if ($canEdit): ?><th style="padding:10px;"><input type="checkbox" onchange="document.querySelectorAll('input[name=\'ids[]\']').forEach(c=>c.checked=this.checked)"></th><?php endif; ?>
                        <th style="padding:10px; text-align:left;">ID</th>
                        <th style="padding:10px; text-align:left;">Должность</th>
                        <th style="padding:10px; text-align:left;">Компания / партнёр</th>
                        <th style="padding:10px; text-align:left;">Город</th>
                        <th style="padding:10px; text-align:left;">Зарплата</th>
                        <th style="padding:10px; text-align:left;">Опубл.</th>
                        <th style="padding:10px; text-align:left;">До</th>
                        <th style="padding:10px; text-align:left;">Статус</th>
                        <th style="padding:10px;"></th>
                    </tr>
                </thead>
                <tbody>
                <?php if (empty($rows)): ?>
                    <tr><td colspan="10" style="padding:24px; text-align:center; color:#6c757d;">Нет вакансий по выбранным фильтрам</td></tr>
                <?php else: foreach ($rows as $v):
                    $expired = $v['expires_at'] && strtotime($v['expires_at']) < time();
                ?>
                    <tr style="border-top:1px solid #f0f0f0;">
                        <?php if ($canEdit): ?><td style="padding:10px;"><input type="checkbox" name="ids[]" value="<?= $v['id'] ?>"></td><?php endif; ?>
                        <td style="padding:10px; color:#999;"><?= $v['id'] ?></td>
                        <td style="padding:10px;"><strong><?= htmlspecialchars($v['title']) ?></strong><br><small style="color:#999;"><?= htmlspecialchars($v['employment_type'] ?? '') ?></small></td>
                        <td style="padding:10px;"><?= htmlspecialchars($v['partner_name'] ?? $v['company']) ?></td>
                        <td style="padding:10px;"><?= htmlspecialchars($v['city'] ?? '') ?></td>
                        <td style="padding:10px;"><?= htmlspecialchars($v['salary'] ?? '') ?></td>
                        <td style="padding:10px; font-size:12px;"><?= $v['published_at'] ? date('d.m.Y', strtotime($v['published_at'])) : '—' ?></td>
                        <td style="padding:10px; font-size:12px; <?= $expired ? 'color:#dc3545;' : '' ?>"><?= $v['expires_at'] ? date('d.m.Y', strtotime($v['expires_at'])) : '—' ?></td>
                        <td style="padding:10px;">
                            <?php if ($v['is_active']): ?>
                                <span style="padding:2px 8px; background:#d1e7dd; color:#0a3622; border-radius:4px; font-size:11px;">Активна</span>
                            <?php else: ?>
                                <span style="padding:2px 8px; background:#f8d7da; color:#58151c; border-radius:4px; font-size:11px;">Неактивна</span>
                            <?php endif; ?>
                        </td>
                        <td style="padding:10px;"><a href="vacancy_edit.php?id=<?= $v['id'] ?>" style="text-decoration:none;">✏️</a></td>
                    </tr>
                <?php endforeach; endif; ?>
                </tbody>
            </table>
        </form>

        <p style="color:#6c757d; font-size:12px; margin-top:12px;">Найдено: <?= count($rows) ?></p>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
