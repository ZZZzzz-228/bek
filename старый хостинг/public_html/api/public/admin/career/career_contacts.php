<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';
$pageTitle = 'Карьера — Контакты центра';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $canEdit) {
    if (!empty($_POST['delete_id'])) {
        $pdo->prepare('DELETE FROM contacts WHERE id=:id')->execute(['id'=>(int)$_POST['delete_id']]);
    } elseif (!empty($_POST['save'])) {
        $editId = (int)($_POST['edit_id'] ?? 0);
        $type = (string)($_POST['type'] ?? 'phone');
        $value = trim((string)($_POST['value'] ?? ''));
        $label = trim((string)($_POST['label'] ?? '')) ?: null;
        $sort = (int)($_POST['sort_order'] ?? 0);
        $active = isset($_POST['is_active']) ? 1 : 0;

        if ($value !== '') {
            if ($editId > 0) {
                $pdo->prepare("UPDATE contacts SET type=:t, value=:v, label=:l, sort_order=:s, is_active=:a, category='career_center' WHERE id=:id")
                    ->execute(['t'=>$type, 'v'=>$value, 'l'=>$label, 's'=>$sort, 'a'=>$active, 'id'=>$editId]);
            } else {
                $pdo->prepare("INSERT INTO contacts(type, value, label, sort_order, is_active, category) VALUES (:t, :v, :l, :s, :a, 'career_center')")
                    ->execute(['t'=>$type, 'v'=>$value, 'l'=>$label, 's'=>$sort, 'a'=>$active]);
            }
        }
    }
    header('Location: career_contacts.php'); exit;
}

$rows = $pdo->query("SELECT * FROM contacts WHERE category='career_center' ORDER BY sort_order, id")->fetchAll();
require_once __DIR__ . '/../_layout_top.php';
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>
    <div class="career-content">
        <h1>📞 Контакты центра карьеры</h1>
        <p style="color:#6c757d;">Телефоны, email, адреса — отображаются в приложении на экране «Контакты центра».</p>

        <?php if ($canEdit): ?>
        <form method="post" style="background:white; padding:16px; border:1px solid #e0e0e0; border-radius:8px; margin-bottom:20px;">
            <h3 style="margin-top:0;">Добавить контакт</h3>
            <div style="display:grid; grid-template-columns:120px 1fr 1fr 100px auto; gap:8px; align-items:end;">
                <select name="type" style="padding:8px; border:1px solid #ccc; border-radius:4px;">
                    <option value="phone">Телефон</option>
                    <option value="email">Email</option>
                    <option value="website">Сайт/адрес</option>
                </select>
                <input type="text" name="value" placeholder="Значение" required style="padding:8px; border:1px solid #ccc; border-radius:4px;">
                <input type="text" name="label" placeholder="Подпись (необязательно)" style="padding:8px; border:1px solid #ccc; border-radius:4px;">
                <input type="number" name="sort_order" value="0" style="padding:8px; border:1px solid #ccc; border-radius:4px;">
                <button type="submit" name="save" value="1" style="padding:8px 16px; background:#0d6efd; color:white; border:none; border-radius:4px;">Добавить</button>
            </div>
            <label style="margin-top:8px; display:block;"><input type="checkbox" name="is_active" value="1" checked> Активен</label>
        </form>
        <?php endif; ?>

        <table style="width:100%; border-collapse:collapse; background:white; border:1px solid #e0e0e0; border-radius:8px;">
            <thead style="background:#f8f9fa;">
                <tr>
                    <th style="padding:10px; text-align:left;">Тип</th>
                    <th style="padding:10px; text-align:left;">Значение</th>
                    <th style="padding:10px; text-align:left;">Подпись</th>
                    <th style="padding:10px; text-align:left;">Сорт.</th>
                    <th style="padding:10px; text-align:left;">Активен</th>
                    <?php if ($canEdit): ?><th style="padding:10px;"></th><?php endif; ?>
                </tr>
            </thead>
            <tbody>
            <?php if (empty($rows)): ?>
                <tr><td colspan="6" style="padding:24px; text-align:center; color:#6c757d;">Пока нет контактов. Добавьте первый сверху.</td></tr>
            <?php else: foreach ($rows as $c): ?>
                <tr style="border-top:1px solid #f0f0f0;">
                    <td style="padding:10px;"><?= htmlspecialchars($c['type']) ?></td>
                    <td style="padding:10px;"><strong><?= htmlspecialchars($c['value']) ?></strong></td>
                    <td style="padding:10px;"><?= htmlspecialchars((string)$c['label']) ?></td>
                    <td style="padding:10px;"><?= $c['sort_order'] ?></td>
                    <td style="padding:10px;"><?= $c['is_active'] ? '✅' : '⛔' ?></td>
                    <?php if ($canEdit): ?>
                    <td style="padding:10px;">
                        <form method="post" style="display:inline;" onsubmit="return confirm('Удалить?')">
                            <input type="hidden" name="delete_id" value="<?= $c['id'] ?>">
                            <button type="submit" style="background:none; border:none; cursor:pointer; color:#dc3545;">🗑</button>
                        </form>
                    </td>
                    <?php endif; ?>
                </tr>
            <?php endforeach; endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
