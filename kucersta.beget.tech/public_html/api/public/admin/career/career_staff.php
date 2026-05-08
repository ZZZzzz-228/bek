<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';
$pageTitle = 'Карьера — Сотрудники центра';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $canEdit) {
    if (!empty($_POST['delete_id'])) {
        $pdo->prepare('DELETE FROM staff_members WHERE id=:id')->execute(['id'=>(int)$_POST['delete_id']]);
    } elseif (!empty($_POST['save'])) {
        $editId = (int)($_POST['edit_id'] ?? 0);
        $data = [
            'full_name' => trim((string)($_POST['full_name'] ?? '')),
            'position_title' => trim((string)($_POST['position_title'] ?? '')),
            'email' => trim((string)($_POST['email'] ?? '')) ?: null,
            'phone' => trim((string)($_POST['phone'] ?? '')) ?: null,
            'office_hours' => trim((string)($_POST['office_hours'] ?? '')) ?: null,
            'photo_url' => trim((string)($_POST['photo_url'] ?? '')) ?: null,
            'sort_order' => (int)($_POST['sort_order'] ?? 0),
            'is_published' => isset($_POST['is_published']) ? 1 : 0,
        ];

        if (!empty($_FILES['photo_file']['name']) && $_FILES['photo_file']['error'] === UPLOAD_ERR_OK) {
            require_once __DIR__ . '/../../../src/Upload.php';
            try {
                $info = Upload::saveImage($_FILES['photo_file'], 'staff');
                $data['photo_url'] = $info['url'];
            } catch (Throwable $e) {}
        }

        if ($data['full_name'] !== '' && $data['position_title'] !== '') {
            if ($editId > 0) {
                $sql = 'UPDATE staff_members SET full_name=:full_name, position_title=:position_title,
                        email=:email, phone=:phone, office_hours=:office_hours, photo_url=:photo_url,
                        sort_order=:sort_order, is_published=:is_published, department=\'career_center\'
                        WHERE id=:id';
                $data['id'] = $editId;
            } else {
                $sql = 'INSERT INTO staff_members(full_name, position_title, email, phone, office_hours, photo_url, sort_order, is_published, department)
                        VALUES (:full_name, :position_title, :email, :phone, :office_hours, :photo_url, :sort_order, :is_published, \'career_center\')';
            }
            $pdo->prepare($sql)->execute($data);
        }
    }
    header('Location: career_staff.php'); exit;
}

$rows = $pdo->query("SELECT * FROM staff_members WHERE department='career_center' ORDER BY sort_order, full_name")->fetchAll();
$editId = (int)($_GET['edit'] ?? 0);
$editRow = null;
if ($editId > 0) {
    $st = $pdo->prepare('SELECT * FROM staff_members WHERE id=:id');
    $st->execute(['id'=>$editId]);
    $editRow = $st->fetch();
}

require_once __DIR__ . '/../_layout_top.php';
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>
    <div class="career-content">
        <h1>👥 Сотрудники центра карьеры</h1>
        <p style="color:#6c757d;">Руководитель центра, HR-менеджер, координатор практик и т.п.</p>

        <?php if ($canEdit): ?>
        <form method="post" enctype="multipart/form-data" style="background:white; padding:16px; border:1px solid #e0e0e0; border-radius:8px; margin-bottom:20px;">
            <h3 style="margin-top:0;"><?= $editRow ? 'Редактировать сотрудника' : 'Добавить сотрудника' ?></h3>
            <?php if ($editRow): ?><input type="hidden" name="edit_id" value="<?= $editRow['id'] ?>"><?php endif; ?>
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div>
                    <label style="display:block; font-weight:600;">ФИО *</label>
                    <input type="text" name="full_name" required value="<?= htmlspecialchars($editRow['full_name'] ?? '') ?>" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
                <div>
                    <label style="display:block; font-weight:600;">Должность *</label>
                    <input type="text" name="position_title" required value="<?= htmlspecialchars($editRow['position_title'] ?? '') ?>" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
                <div>
                    <label style="display:block; font-weight:600;">Email</label>
                    <input type="email" name="email" value="<?= htmlspecialchars($editRow['email'] ?? '') ?>" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
                <div>
                    <label style="display:block; font-weight:600;">Телефон</label>
                    <input type="text" name="phone" value="<?= htmlspecialchars($editRow['phone'] ?? '') ?>" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
                <div>
                    <label style="display:block; font-weight:600;">Часы приёма</label>
                    <input type="text" name="office_hours" value="<?= htmlspecialchars($editRow['office_hours'] ?? '') ?>" placeholder="Пн-Пт 9:00–17:00" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
                <div>
                    <label style="display:block; font-weight:600;">Сортировка</label>
                    <input type="number" name="sort_order" value="<?= (int)($editRow['sort_order'] ?? 0) ?>" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
            </div>
            <div style="margin-top:12px;">
                <label style="display:block; font-weight:600;">Фото</label>
                <?php if (!empty($editRow['photo_url'])): ?>
                    <img src="<?= htmlspecialchars($editRow['photo_url']) ?>" style="width:80px; height:80px; object-fit:cover; border-radius:50%; margin-bottom:8px;">
                <?php endif; ?>
                <input type="file" name="photo_file" accept="image/*">
                <input type="hidden" name="photo_url" value="<?= htmlspecialchars($editRow['photo_url'] ?? '') ?>">
            </div>
            <div style="margin-top:12px;">
                <label><input type="checkbox" name="is_published" value="1" <?= !$editRow || $editRow['is_published'] ? 'checked' : '' ?>> Опубликован</label>
            </div>
            <div style="margin-top:12px;">
                <button type="submit" name="save" value="1" style="padding:8px 16px; background:#0d6efd; color:white; border:none; border-radius:4px;">
                    <?= $editRow ? '💾 Обновить' : '+ Добавить' ?>
                </button>
                <?php if ($editRow): ?><a href="career_staff.php" style="padding:8px 16px; color:#6c757d; text-decoration:none;">Отмена</a><?php endif; ?>
            </div>
        </form>
        <?php endif; ?>

        <table style="width:100%; border-collapse:collapse; background:white; border:1px solid #e0e0e0; border-radius:8px;">
            <thead style="background:#f8f9fa;">
                <tr>
                    <th style="padding:10px;"></th>
                    <th style="padding:10px; text-align:left;">ФИО</th>
                    <th style="padding:10px; text-align:left;">Должность</th>
                    <th style="padding:10px; text-align:left;">Контакты</th>
                    <th style="padding:10px; text-align:left;">Часы</th>
                    <th style="padding:10px; text-align:left;">Статус</th>
                    <?php if ($canEdit): ?><th style="padding:10px;"></th><?php endif; ?>
                </tr>
            </thead>
            <tbody>
            <?php if (empty($rows)): ?>
                <tr><td colspan="7" style="padding:24px; text-align:center; color:#6c757d;">Сотрудников ещё нет</td></tr>
            <?php else: foreach ($rows as $s): ?>
                <tr style="border-top:1px solid #f0f0f0;">
                    <td style="padding:10px;">
                        <?php if ($s['photo_url']): ?>
                            <img src="<?= htmlspecialchars($s['photo_url']) ?>" style="width:48px; height:48px; object-fit:cover; border-radius:50%;">
                        <?php else: ?>
                            <div style="width:48px; height:48px; background:#e9ecef; border-radius:50%;"></div>
                        <?php endif; ?>
                    </td>
                    <td style="padding:10px;"><strong><?= htmlspecialchars($s['full_name']) ?></strong></td>
                    <td style="padding:10px;"><?= htmlspecialchars($s['position_title']) ?></td>
                    <td style="padding:10px; font-size:13px;">
                        <?= $s['email'] ? htmlspecialchars($s['email']).'<br>' : '' ?>
                        <?= $s['phone'] ? htmlspecialchars($s['phone']) : '' ?>
                    </td>
                    <td style="padding:10px; font-size:13px;"><?= htmlspecialchars((string)$s['office_hours']) ?></td>
                    <td style="padding:10px;"><?= $s['is_published'] ? '✅' : '⛔' ?></td>
                    <?php if ($canEdit): ?>
                    <td style="padding:10px;">
                        <a href="?edit=<?= $s['id'] ?>" style="margin-right:8px;">✏️</a>
                        <form method="post" style="display:inline;" onsubmit="return confirm('Удалить?')">
                            <input type="hidden" name="delete_id" value="<?= $s['id'] ?>">
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
