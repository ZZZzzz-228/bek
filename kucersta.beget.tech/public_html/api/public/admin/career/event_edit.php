<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';
if (!$canEdit) { http_response_code(403); echo 'Нет прав'; exit; }

$id = (int)($_GET['id'] ?? 0);
$isNew = $id === 0;
$pageTitle = $isNew ? 'Новое мероприятие' : 'Редактирование мероприятия';

$row = [
    'title'=>'', 'description'=>'', 'starts_at'=>date('Y-m-d\TH:i'), 'ends_at'=>'',
    'location'=>'', 'category'=>'career', 'cover_url'=>'', 'partner_id'=>null,
    'external_url'=>'', 'is_published'=>1,
];

if (!$isNew) {
    $st = $pdo->prepare('SELECT * FROM events WHERE id=:id');
    $st->execute(['id'=>$id]);
    $r = $st->fetch();
    if (!$r) { http_response_code(404); echo 'Не найдено'; exit; }
    $row = $r;
}

$errors = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $row['title'] = trim((string)($_POST['title'] ?? ''));
    $row['description'] = trim((string)($_POST['description'] ?? ''));
    $row['starts_at'] = trim((string)($_POST['starts_at'] ?? ''));
    $row['ends_at'] = trim((string)($_POST['ends_at'] ?? '')) ?: null;
    $row['location'] = trim((string)($_POST['location'] ?? ''));
    $row['category'] = trim((string)($_POST['category'] ?? 'career'));
    $row['cover_url'] = trim((string)($_POST['cover_url'] ?? ''));
    $row['partner_id'] = !empty($_POST['partner_id']) ? (int)$_POST['partner_id'] : null;
    $row['external_url'] = trim((string)($_POST['external_url'] ?? ''));
    $row['is_published'] = isset($_POST['is_published']) ? 1 : 0;

    // Загрузка обложки
    if (!empty($_FILES['cover_file']['name']) && $_FILES['cover_file']['error'] === UPLOAD_ERR_OK) {
        require_once __DIR__ . '/../../../src/Upload.php';
        try {
            $info = Upload::saveImage($_FILES['cover_file'], 'events');
            $row['cover_url'] = $info['url'];
        } catch (Throwable $e) {
            $errors[] = 'Ошибка обложки: ' . $e->getMessage();
        }
    }

    if ($row['title'] === '') $errors[] = 'Название обязательно';
    if (empty($row['starts_at'])) $errors[] = 'Дата начала обязательна';

    if (empty($errors)) {
        $startsAt = str_replace('T', ' ', $row['starts_at']) . (strlen($row['starts_at']) === 16 ? ':00' : '');
        $endsAt = $row['ends_at'] ? str_replace('T', ' ', $row['ends_at']) . (strlen($row['ends_at']) === 16 ? ':00' : '') : null;

        if ($isNew) {
            $sql = 'INSERT INTO events(title, description, starts_at, ends_at, location, category, cover_url, partner_id, external_url, is_published, created_by)
                    VALUES (:t, :d, :s, :e, :l, :c, :cv, :pid, :ext, :pub, :cb)';
        } else {
            $sql = 'UPDATE events SET title=:t, description=:d, starts_at=:s, ends_at=:e, location=:l,
                    category=:c, cover_url=:cv, partner_id=:pid, external_url=:ext, is_published=:pub WHERE id=:id';
        }
        $params = [
            't'=>$row['title'], 'd'=>$row['description'], 's'=>$startsAt, 'e'=>$endsAt,
            'l'=>$row['location'] ?: null, 'c'=>$row['category'], 'cv'=>$row['cover_url'] ?: null,
            'pid'=>$row['partner_id'], 'ext'=>$row['external_url'] ?: null, 'pub'=>$row['is_published'],
        ];
        if ($isNew) $params['cb'] = $adminUserId;
        else $params['id'] = $id;

        $pdo->prepare($sql)->execute($params);
        header('Location: events.php'); exit;
    }
}

$partners = $pdo->query('SELECT id, name FROM partners WHERE is_published=1 ORDER BY name')->fetchAll();
$categories = ['career'=>'Карьера', 'meetup'=>'Митап', 'fair'=>'Ярмарка', 'workshop'=>'Воркшоп', 'excursion'=>'Экскурсия', 'other'=>'Другое'];

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
                <input type="text" name="title" value="<?= htmlspecialchars($row['title']) ?>" required style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
            </div>

            <div style="margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px;">Описание</label>
                <textarea name="description" rows="5" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;"><?= htmlspecialchars((string)$row['description']) ?></textarea>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div>
                    <label style="display:block; font-weight:600; margin-bottom:4px;">Начало *</label>
                    <input type="datetime-local" name="starts_at" value="<?= htmlspecialchars(str_replace(' ', 'T', substr((string)$row['starts_at'], 0, 16))) ?>" required style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
                <div>
                    <label style="display:block; font-weight:600; margin-bottom:4px;">Конец</label>
                    <input type="datetime-local" name="ends_at" value="<?= $row['ends_at'] ? htmlspecialchars(str_replace(' ', 'T', substr((string)$row['ends_at'], 0, 16))) : '' ?>" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                </div>
            </div>

            <div style="margin-top:14px; margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px;">Место</label>
                <input type="text" name="location" value="<?= htmlspecialchars((string)$row['location']) ?>" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <div>
                    <label style="display:block; font-weight:600; margin-bottom:4px;">Категория</label>
                    <select name="category" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                        <?php foreach ($categories as $k=>$v): ?>
                            <option value="<?= $k ?>" <?= $row['category']===$k?'selected':'' ?>><?= htmlspecialchars($v) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div>
                    <label style="display:block; font-weight:600; margin-bottom:4px;">Партнёр</label>
                    <select name="partner_id" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                        <option value="">— Не привязан —</option>
                        <?php foreach ($partners as $p): ?>
                            <option value="<?= $p['id'] ?>" <?= (int)$row['partner_id']===(int)$p['id']?'selected':'' ?>>
                                <?= htmlspecialchars($p['name']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>

            <div style="margin-top:14px; margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px;">Внешняя ссылка (регистрация и т.п.)</label>
                <input type="url" name="external_url" value="<?= htmlspecialchars((string)$row['external_url']) ?>" placeholder="https://" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
            </div>

            <div style="margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px;">Обложка</label>
                <?php if ($row['cover_url']): ?>
                    <div style="margin-bottom:8px;"><img src="<?= htmlspecialchars($row['cover_url']) ?>" style="max-width:200px; max-height:140px; border-radius:6px;"></div>
                <?php endif; ?>
                <input type="file" name="cover_file" accept="image/*">
                <input type="hidden" name="cover_url" value="<?= htmlspecialchars((string)$row['cover_url']) ?>">
            </div>

            <div style="margin-top:14px;">
                <label><input type="checkbox" name="is_published" value="1" <?= $row['is_published'] ? 'checked' : '' ?>> Опубликовано</label>
            </div>

            <div style="margin-top:24px;">
                <button type="submit" style="padding:10px 20px; background:#0d6efd; color:white; border:none; border-radius:6px; cursor:pointer;">💾 Сохранить</button>
                <a href="events.php" style="padding:10px 20px; color:#6c757d; text-decoration:none;">Отмена</a>
            </div>
        </form>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
