<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';
if (!$canEdit) { http_response_code(403); echo 'Нет прав'; exit; }

$id = (int)($_GET['id'] ?? 0);
$isNew = $id === 0;
$pageTitle = $isNew ? 'Новый партнёр' : 'Редактирование партнёра';

$row = ['name'=>'', 'description'=>'', 'website_url'=>'', 'logo_url'=>'', 'sort_order'=>0, 'is_published'=>1];

if (!$isNew) {
    $st = $pdo->prepare('SELECT * FROM partners WHERE id=:id');
    $st->execute(['id'=>$id]);
    $r = $st->fetch();
    if (!$r) { http_response_code(404); echo 'Партнёр не найден'; exit; }
    $row = $r;
}

$errors = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $row['name'] = trim((string)($_POST['name'] ?? ''));
    $row['description'] = trim((string)($_POST['description'] ?? ''));
    $row['website_url'] = trim((string)($_POST['website_url'] ?? ''));
    $row['logo_url'] = trim((string)($_POST['logo_url'] ?? ''));
    $row['sort_order'] = (int)($_POST['sort_order'] ?? 0);
    $row['is_published'] = isset($_POST['is_published']) ? 1 : 0;

    // Загрузка лого
    if (!empty($_FILES['logo_file']['name']) && $_FILES['logo_file']['error'] === UPLOAD_ERR_OK) {
        require_once __DIR__ . '/../../../src/Upload.php';
        try {
            $info = Upload::saveImage($_FILES['logo_file'], 'partners');
            $row['logo_url'] = $info['url'];
        } catch (Throwable $e) {
            $errors[] = 'Ошибка загрузки лого: ' . $e->getMessage();
        }
    }

    if ($row['name'] === '') $errors[] = 'Укажите название';

    if (empty($errors)) {
        if ($isNew) {
            $sql = 'INSERT INTO partners(name, description, website_url, logo_url, sort_order, is_published)
                    VALUES (:n, :d, :w, :l, :s, :p)';
        } else {
            $sql = 'UPDATE partners SET name=:n, description=:d, website_url=:w, logo_url=:l, sort_order=:s, is_published=:p WHERE id=:id';
        }
        $params = ['n'=>$row['name'], 'd'=>$row['description'], 'w'=>$row['website_url'] ?: null,
                   'l'=>$row['logo_url'] ?: null, 's'=>$row['sort_order'], 'p'=>$row['is_published']];
        if (!$isNew) $params['id'] = $id;
        $pdo->prepare($sql)->execute($params);
        header('Location: partners.php'); exit;
    }
}

require_once __DIR__ . '/../_layout_top.php';
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>
    <div class="career-content">
        <h1><?= htmlspecialchars($pageTitle) ?></h1>

        <?php if (!empty($errors)): ?>
            <div style="background:#f8d7da; color:#58151c; padding:12px; border-radius:6px; margin:12px 0;">
                <?php foreach ($errors as $e): ?><div><?= htmlspecialchars($e) ?></div><?php endforeach; ?>
            </div>
        <?php endif; ?>

        <form method="post" enctype="multipart/form-data" style="background:white; padding:20px; border:1px solid #e0e0e0; border-radius:8px; max-width:800px;">
            <div style="margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px;">Название *</label>
                <input type="text" name="name" value="<?= htmlspecialchars($row['name']) ?>" required style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
            </div>

            <div style="margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px;">Описание</label>
                <textarea name="description" rows="4" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;"><?= htmlspecialchars((string)$row['description']) ?></textarea>
            </div>

            <div style="margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px;">Сайт</label>
                <input type="url" name="website_url" value="<?= htmlspecialchars((string)$row['website_url']) ?>" placeholder="https://" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
            </div>

            <div style="margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px;">Логотип</label>
                <?php if ($row['logo_url']): ?>
                    <div style="margin-bottom:8px;"><img src="<?= htmlspecialchars($row['logo_url']) ?>" style="max-width:120px; max-height:80px;"></div>
                <?php endif; ?>
                <input type="file" name="logo_file" accept="image/*">
                <input type="hidden" name="logo_url" value="<?= htmlspecialchars((string)$row['logo_url']) ?>">
                <small style="color:#666; display:block;">Загрузите PNG/JPG/WebP до 5 МБ</small>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div>
                    <label style="display:block; font-weight:600; margin-bottom:4px;">Сортировка</label>
                    <input type="number" name="sort_order" value="<?= (int)$row['sort_order'] ?>" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
                <div style="padding-top:24px;">
                    <label><input type="checkbox" name="is_published" value="1" <?= $row['is_published'] ? 'checked' : '' ?>> Опубликован</label>
                </div>
            </div>

            <div style="margin-top:24px;">
                <button type="submit" style="padding:10px 20px; background:#0d6efd; color:white; border:none; border-radius:6px; cursor:pointer;">💾 Сохранить</button>
                <a href="partners.php" style="padding:10px 20px; color:#6c757d; text-decoration:none;">Отмена</a>
            </div>
        </form>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
