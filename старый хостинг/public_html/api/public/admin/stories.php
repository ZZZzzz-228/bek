<?php
require __DIR__ . '/_bootstrap.php';
requireLogin();
if (!canManageContent()) {
    flash('Недостаточно прав для раздела контента.');
    redirectTo('/admin/index.php');
}

// ────────────────────────────────────────────────────────────────────────────
// Хелпер: разобрать images_json в массив URL-ов
// ────────────────────────────────────────────────────────────────────────────
function story_decode_images(?string $json): array
{
    if ($json === null || $json === '') {
        return [];
    }
    $decoded = json_decode($json, true);
    if (!is_array($decoded)) {
        return [];
    }
    $out = [];
    foreach ($decoded as $u) {
        if (is_string($u) && $u !== '') {
            $out[] = $u;
        }
    }
    return $out;
}

// Поддерживается ли в БД поле images_json?
$hasImagesJson = false;
try {
    $pdo->query('SELECT images_json FROM stories LIMIT 1');
    $hasImagesJson = true;
} catch (Throwable $e) {
    $hasImagesJson = false;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    if ($action === 'save') {
        requireCsrf();
        $id = (int)($_POST['id'] ?? 0);
        $title = trim((string)($_POST['title'] ?? ''));
        $content = trim((string)($_POST['content'] ?? ''));
        $imageUrl = trim((string)($_POST['image_url'] ?? ''));
        $sortOrder = (int)($_POST['sort_order'] ?? 0);
        $isPublished = isset($_POST['is_published']) ? 1 : 0;
        $publishFrom = trim((string)($_POST['publish_from'] ?? ''));
        $publishTo = trim((string)($_POST['publish_to'] ?? ''));
        $publishFromSql = $publishFrom !== '' ? str_replace('T', ' ', $publishFrom) . ':00' : null;
        $publishToSql = $publishTo !== '' ? str_replace('T', ' ', $publishTo) . ':00' : null;

        // ────────────── Фотогалерея (множественные фото) ──────────────
        // 1. Берём существующие фото, которые НЕ были помечены на удаление
        $existingImages = [];
        $rawExisting = $_POST['existing_images'] ?? [];
        if (is_array($rawExisting)) {
            foreach ($rawExisting as $url) {
                $url = trim((string)$url);
                if ($url !== '') {
                    $existingImages[] = $url;
                }
            }
        }
        // 2. Принимаем НОВЫЕ кропнутые фото (data:image/...) — массив
        $rawCropped = $_POST['cropped_images_data'] ?? [];
        if (!is_array($rawCropped)) {
            $rawCropped = [$rawCropped];
        }
        foreach ($rawCropped as $dataUrl) {
            $dataUrl = (string)$dataUrl;
            if ($dataUrl === '') {
                continue;
            }
            $saved = saveBase64Image($dataUrl);
            if ($saved !== null) {
                $existingImages[] = $saved;
            }
        }
        // 3. Принимаем НОВЫЕ некропнутые загрузки (поле image_files[])
        if (!empty($_FILES['image_files']) && is_array($_FILES['image_files']['name'] ?? null)) {
            $count = count($_FILES['image_files']['name']);
            for ($i = 0; $i < $count; $i++) {
                if (($_FILES['image_files']['error'][$i] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
                    continue;
                }
                // Обманываем saveUploadedImage: подкладываем нужный $_FILES слот
                $_FILES['__story_one'] = [
                    'name'     => $_FILES['image_files']['name'][$i],
                    'type'     => $_FILES['image_files']['type'][$i],
                    'tmp_name' => $_FILES['image_files']['tmp_name'][$i],
                    'error'    => $_FILES['image_files']['error'][$i],
                    'size'     => $_FILES['image_files']['size'][$i],
                ];
                $saved = saveUploadedImage('__story_one');
                unset($_FILES['__story_one']);
                if ($saved !== null) {
                    $existingImages[] = $saved;
                }
            }
        }

        // image_url — главное (первое) фото для совместимости с ленточным API
        $imageUrl = $existingImages ? $existingImages[0] : '';
        $imagesJson = $existingImages ? json_encode(array_values(array_unique($existingImages)), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) : null;

        if ($title === '' || $content === '') {
            flash('Заполните title и content.');
            redirectTo('/admin/stories.php');
        }

        if ($id > 0) {
            if ($hasImagesJson) {
                $stmt = $pdo->prepare(
                    'UPDATE stories
                     SET title=:title, content=:content, image_url=:image_url, images_json=:images_json,
                         sort_order=:sort_order, is_published=:is_published,
                         publish_from=:publish_from, publish_to=:publish_to
                     WHERE id=:id'
                );
                $stmt->execute([
                    'id' => $id, 'title' => $title, 'content' => $content,
                    'image_url' => $imageUrl !== '' ? $imageUrl : null,
                    'images_json' => $imagesJson,
                    'sort_order' => $sortOrder, 'is_published' => $isPublished,
                    'publish_from' => $publishFromSql, 'publish_to' => $publishToSql,
                ]);
            } else {
                $stmt = $pdo->prepare(
                    'UPDATE stories
                     SET title=:title, content=:content, image_url=:image_url,
                         sort_order=:sort_order, is_published=:is_published,
                         publish_from=:publish_from, publish_to=:publish_to
                     WHERE id=:id'
                );
                $stmt->execute([
                    'id' => $id, 'title' => $title, 'content' => $content,
                    'image_url' => $imageUrl !== '' ? $imageUrl : null,
                    'sort_order' => $sortOrder, 'is_published' => $isPublished,
                    'publish_from' => $publishFromSql, 'publish_to' => $publishToSql,
                ]);
            }
            auditLog($pdo, 'update', 'story', (string)$id, [
                'title' => $title, 'sort_order' => $sortOrder, 'is_published' => $isPublished,
                'photos' => count($existingImages),
            ]);
            flash('История обновлена.');
        } else {
            if ($hasImagesJson) {
                $stmt = $pdo->prepare(
                    'INSERT INTO stories(title, content, image_url, images_json, sort_order, is_published)
                     VALUES (:title, :content, :image_url, :images_json, :sort_order, :is_published)'
                );
                $stmt->execute([
                    'title' => $title, 'content' => $content,
                    'image_url' => $imageUrl !== '' ? $imageUrl : null,
                    'images_json' => $imagesJson,
                    'sort_order' => $sortOrder, 'is_published' => $isPublished,
                ]);
            } else {
                $stmt = $pdo->prepare(
                    'INSERT INTO stories(title, content, image_url, sort_order, is_published)
                     VALUES (:title, :content, :image_url, :sort_order, :is_published)'
                );
                $stmt->execute([
                    'title' => $title, 'content' => $content,
                    'image_url' => $imageUrl !== '' ? $imageUrl : null,
                    'sort_order' => $sortOrder, 'is_published' => $isPublished,
                ]);
            }
            $newId = (int)$pdo->lastInsertId();
            $pdo->prepare('UPDATE stories SET publish_from=:pf, publish_to=:pt WHERE id=:id')->execute([
                'pf' => $publishFromSql, 'pt' => $publishToSql, 'id' => $newId,
            ]);
            auditLog($pdo, 'create', 'story', (string)$newId, [
                'title' => $title, 'photos' => count($existingImages),
            ]);
            flash('История добавлена.');
        }
    }

    if ($action === 'delete') {
        requireCsrf();
        if (!isAdmin()) {
            flash('Удаление доступно только администратору.');
            redirectTo('/admin/stories.php');
        }
        $id = (int)($_POST['id'] ?? 0);
        if ($id > 0) {
            $stmt = $pdo->prepare('DELETE FROM stories WHERE id=:id');
            $stmt->execute(['id' => $id]);
            auditLog($pdo, 'delete', 'story', (string)$id, null);
            flash('История удалена.');
        }
    }

    if ($action === 'toggle_publish') {
        requireCsrf();
        $id = (int)($_POST['id'] ?? 0);
        if ($id > 0) {
            $stmt = $pdo->prepare('UPDATE stories SET is_published = 1 - is_published WHERE id=:id');
            $stmt->execute(['id' => $id]);
            auditLog($pdo, 'toggle_publish', 'story', (string)$id, null);
            flash('Статус истории переключен.');
        }
    }

    if ($action === 'move_up' || $action === 'move_down') {
        requireCsrf();
        $id = (int)($_POST['id'] ?? 0);
        if ($id > 0) {
            $delta = $action === 'move_up' ? -1 : 1;
            $stmt = $pdo->prepare('UPDATE stories SET sort_order = GREATEST(0, sort_order + :delta) WHERE id=:id');
            $stmt->bindValue(':delta', $delta, PDO::PARAM_INT);
            $stmt->bindValue(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            auditLog($pdo, $action, 'story', (string)$id, null);
            flash('Порядок истории изменен.');
        }
    }

    if ($action === 'reorder') {
        requireCsrf();
        $orderJson = (string)($_POST['order_json'] ?? '');
        $ids = json_decode($orderJson, true);
        if (is_array($ids)) {
            $sort = 0;
            $stmt = $pdo->prepare('UPDATE stories SET sort_order = :sort_order WHERE id = :id');
            foreach ($ids as $storyId) {
                $storyId = (int)$storyId;
                if ($storyId <= 0) {
                    continue;
                }
                $stmt->execute(['id' => $storyId, 'sort_order' => $sort]);
                $sort++;
            }
            auditLog($pdo, 'reorder', 'story', 'bulk', ['ids' => $ids]);
            flash('Порядок историй сохранен.');
        }
    }

    // ────────── Массовые действия (bulk_* + ids[]) ──────────
    if (str_starts_with($action, 'bulk_')) {
        requireCsrf();
        $rawIds = $_POST['ids'] ?? [];
        if (!is_array($rawIds)) {
            $rawIds = [];
        }
        $ids = [];
        foreach ($rawIds as $v) {
            $v = (int)$v;
            if ($v > 0) {
                $ids[] = $v;
            }
        }
        if (!$ids) {
            flash('Не выбрано ни одной истории.');
            redirectTo('/admin/stories.php');
        }
        $in = implode(',', array_fill(0, count($ids), '?'));

        if ($action === 'bulk_delete') {
            if (!isAdmin()) {
                flash('Удаление доступно только администратору.');
                redirectTo('/admin/stories.php');
            }
            $stmt = $pdo->prepare("DELETE FROM stories WHERE id IN ({$in})");
            $stmt->execute($ids);
            auditLog($pdo, 'bulk_delete', 'story', 'bulk', ['ids' => $ids]);
            flash('Удалено: ' . count($ids));
        }
        if ($action === 'bulk_publish') {
            $stmt = $pdo->prepare("UPDATE stories SET is_published = 1 WHERE id IN ({$in})");
            $stmt->execute($ids);
            auditLog($pdo, 'bulk_publish', 'story', 'bulk', ['ids' => $ids]);
            flash('Опубликовано: ' . count($ids));
        }
        if ($action === 'bulk_unpublish') {
            $stmt = $pdo->prepare("UPDATE stories SET is_published = 0 WHERE id IN ({$in})");
            $stmt->execute($ids);
            auditLog($pdo, 'bulk_unpublish', 'story', 'bulk', ['ids' => $ids]);
            flash('Скрыто: ' . count($ids));
        }
        if ($action === 'bulk_move_up' || $action === 'bulk_move_down') {
            $delta = $action === 'bulk_move_up' ? -1 : 1;
            $stmt = $pdo->prepare("UPDATE stories SET sort_order = GREATEST(0, sort_order + :delta) WHERE id IN ({$in})");
            $stmt->bindValue(':delta', $delta, PDO::PARAM_INT);
            foreach ($ids as $i => $v) {
                $stmt->bindValue($i + 1, $v, PDO::PARAM_INT);
            }
            $stmt->execute();
            auditLog($pdo, $action, 'story', 'bulk', ['ids' => $ids]);
            flash('Порядок изменён для: ' . count($ids));
        }
    }

    redirectTo('/admin/stories.php');
}

$editId = (int)($_GET['edit'] ?? 0);
$editItem = null;
if ($editId > 0) {
    $stmt = $pdo->prepare('SELECT * FROM stories WHERE id = :id LIMIT 1');
    $stmt->execute(['id' => $editId]);
    $editItem = $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
}

if ($hasImagesJson) {
    $stories = $pdo->query('SELECT id, title, image_url, images_json, sort_order, is_published FROM stories ORDER BY sort_order ASC, id ASC')->fetchAll(PDO::FETCH_ASSOC);
} else {
    $stories = $pdo->query('SELECT id, title, image_url, sort_order, is_published FROM stories ORDER BY sort_order ASC, id ASC')->fetchAll(PDO::FETCH_ASSOC);
}

// Бейдж VK предложки
$pendingCount = 0;
try {
    $pendingCount = (int)$pdo->query("SELECT COUNT(*) FROM vk_pending_stories WHERE status='pending'")->fetchColumn();
} catch (Throwable $e) {
    $pendingCount = 0;
}

// Текущие фото редактируемой истории
$editImages = [];
if ($editItem) {
    if ($hasImagesJson && !empty($editItem['images_json'])) {
        $editImages = story_decode_images((string)$editItem['images_json']);
    } elseif (!empty($editItem['image_url'])) {
        $editImages = [(string)$editItem['image_url']];
    }
}

$title = 'Управление историями';
$user = getCurrentUser();
$canDelete = isAdmin();
require __DIR__ . '/_layout_top.php';
$msg = flash();
if ($msg): ?><div class="flash"><?= h($msg) ?></div><?php endif; ?>

<div class="card">
  <h2 style="margin-top:0;">Истории / мероприятия</h2>
  <p class="muted">Лента событий для абитуриентов: ручное управление + автоматическая предложка из VK.</p>
  <div class="tabs">
    <a class="tab isActive" href="/api/public/admin/stories.php">Опубликованные истории</a>
    <a class="tab" href="/api/public/admin/vk_pending.php">
      ВК предложка
      <?php if ($pendingCount > 0): ?>
        <span style="display:inline-block;background:#ef4444;color:#fff;border-radius:10px;padding:1px 8px;margin-left:6px;font-size:11px;font-weight:700;"><?= (int)$pendingCount ?></span>
      <?php endif; ?>
    </a>
  </div>
</div>

<div class="card">
  <h2 style="margin-top:0;"><?= $editItem ? 'Редактировать историю' : 'Добавить историю' ?></h2>
  <?php
    $publishFromValue = !empty($editItem['publish_from']) ? str_replace(' ', 'T', substr((string)$editItem['publish_from'], 0, 16)) : '';
    $publishToValue = !empty($editItem['publish_to']) ? str_replace(' ', 'T', substr((string)$editItem['publish_to'], 0, 16)) : '';
  ?>
  <form method="post" enctype="multipart/form-data" id="storyEditForm">
    <?= csrfField() ?>
    <input type="hidden" name="action" value="save">
    <input type="hidden" name="id" value="<?= (int)($editItem['id'] ?? 0) ?>">

    <label style="font-size:15px;font-weight:600;">Заголовок</label>
    <input name="title" value="<?= h((string)($editItem['title'] ?? '')) ?>" required
           style="font-size:18px;padding:14px 16px;line-height:1.4;min-height:56px;">

    <label style="font-size:15px;font-weight:600;margin-top:14px;">Текст</label>
    <textarea name="content" rows="6" required style="font-size:14px;padding:12px;line-height:1.55;"><?= h((string)($editItem['content'] ?? '')) ?></textarea>

    <input type="hidden" name="image_url" value="<?= h((string)($editItem['image_url'] ?? '')) ?>">

    <!-- ─── Галерея ─── -->
    <div style="margin-top:18px;padding:14px;border:1px solid #e5e7eb;border-radius:10px;background:#fafbfc;">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;">
        <strong style="font-size:14px;">Фотографии истории <span class="muted">(можно несколько)</span></strong>
        <span class="muted" id="story_photos_counter" style="font-size:12px;"><?= count($editImages) ?> фото</span>
      </div>

      <!-- Уже сохранённые фото -->
      <div id="story_existing_grid" style="display:grid;grid-template-columns:repeat(auto-fill,minmax(120px,1fr));gap:10px;margin-bottom:10px;">
        <?php foreach ($editImages as $idx => $url): ?>
          <div class="story-existing-tile" data-url="<?= h($url) ?>" style="position:relative;border-radius:10px;overflow:hidden;background:#f3f4f6;">
            <img src="<?= h($url) ?>" alt="" style="width:100%;height:140px;object-fit:cover;display:block;">
            <input type="hidden" name="existing_images[]" value="<?= h($url) ?>">
            <button type="button" class="story-existing-remove" title="Удалить фото"
                    style="position:absolute;top:4px;right:4px;background:#ef4444;color:#fff;border:none;border-radius:50%;width:26px;height:26px;cursor:pointer;font-weight:700;">×</button>
            <?php if ($idx === 0): ?>
              <span style="position:absolute;bottom:4px;left:4px;background:#2563eb;color:#fff;font-size:10px;font-weight:700;border-radius:6px;padding:2px 6px;">обложка</span>
            <?php endif; ?>
          </div>
        <?php endforeach; ?>
      </div>

      <!-- Загрузка новых фото с кропом -->
      <label style="display:block;font-size:13px;font-weight:600;margin-bottom:6px;">
        Добавить фото (можно сразу несколько):
      </label>
      <input id="story_image_files" type="file" accept="image/jpeg,image/png,image/webp" multiple>
      <div class="muted" style="font-size:12px;margin-top:4px;">
        Формат сторис: 9:16. Можно перетащить углы рамки чтобы выбрать любую часть фото.
      </div>

      <!-- Очередь только что добавленных фото для кропа -->
      <div id="story_crop_queue" style="margin-top:14px;display:none;">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
          <strong style="font-size:13px;">Кадрирование (<span id="story_crop_idx">1</span>/<span id="story_crop_total">1</span>)</strong>
          <div>
            <button type="button" class="btn btnGhost" id="story_crop_prev" style="padding:6px 10px;">&larr;</button>
            <button type="button" class="btn btnGhost" id="story_crop_next" style="padding:6px 10px;">&rarr;</button>
            <button type="button" class="btn btnGhost" id="story_crop_remove" style="padding:6px 10px;color:#dc2626;">Убрать это фото</button>
          </div>
        </div>
        <div style="max-width:340px;margin:0 auto;">
          <img id="story_crop_preview" src="" alt="" style="max-width:100%;display:block;">
        </div>
        <p class="muted" style="font-size:12px;margin-top:6px;">
          Все добавленные сюда фото будут сохранены в нужном кадре после нажатия «Сохранить».
        </p>
      </div>
    </div>

    <label style="margin-top:14px;">Порядок</label>
    <input name="sort_order" type="number" value="<?= (int)($editItem['sort_order'] ?? 0) ?>">
    <label><input type="checkbox" name="is_published" <?= ($editItem === null || !empty($editItem['is_published'])) ? 'checked' : '' ?>> Опубликовано</label>
    <div class="grid2">
      <div>
        <label>Публиковать с (планировщик)</label>
        <input type="datetime-local" name="publish_from" value="<?= h($publishFromValue) ?>">
      </div>
      <div>
        <label>Публиковать по (опционально)</label>
        <input type="datetime-local" name="publish_to" value="<?= h($publishToValue) ?>">
      </div>
    </div>
    <br>
    <button type="submit">Сохранить</button>
    <?php if ($editItem): ?>
      <a class="btn btnGhost" href="/api/public/admin/stories.php" style="margin-left:8px;">Отмена</a>
    <?php endif; ?>
  </form>
</div>

<div class="card">
  <h2 style="margin-top:0;">Список историй</h2>
  <div style="display:flex;flex-wrap:wrap;gap:10px;align-items:center;margin-bottom:10px;">
    <input id="storiesSearchInput" placeholder="Поиск по заголовку..." style="max-width:340px;margin:0;">
    <select id="storiesStatusFilter" style="max-width:180px;padding:10px;border:1px solid #d1d5db;border-radius:8px;">
      <option value="all">Все статусы</option>
      <option value="published">Опубликовано</option>
      <option value="draft">Черновик</option>
    </select>
  </div>
  <div class="muted" style="margin-bottom:8px;">Можно перетаскивать строки мышкой.</div>

  <!-- Объединённая форма для bulk-операций + reorder -->
  <form method="post" id="storiesBulkForm" style="margin-bottom:12px;display:flex;flex-wrap:wrap;gap:6px;align-items:center;">
    <?= csrfField() ?>
    <input type="hidden" name="action" id="storiesBulkAction" value="reorder">
    <input type="hidden" name="order_json" id="storiesOrderJson">
    <button type="button" id="bulkSaveOrderBtn">Сохранить порядок</button>
    <button type="button" id="bulkSelectAllBtn">Отметить все</button>
    <button type="button" id="bulkPublishBtn">Опубликовать</button>
    <button type="button" id="bulkUnpublishBtn">Скрыть</button>
    <button type="button" id="bulkMoveUpBtn">Вверх</button>
    <button type="button" id="bulkMoveDownBtn">Вниз</button>
    <?php if ($canDelete): ?>
      <button type="button" id="bulkDeleteBtn" class="danger">Удалить выбранные</button>
    <?php endif; ?>
    <span id="bulkSelectedCount" class="muted" style="margin-left:auto;font-size:13px;"></span>
  </form>

  <table>
    <thead>
    <tr>
      <th style="width:32px;"><input type="checkbox" id="bulkCheckAllHead" title="Отметить все"></th>
      <th>ID</th>
      <th>Заголовок</th>
      <th>Изображение</th>
      <th>Порядок</th>
      <th>Статус</th>
      <th>Действия</th>
    </tr>
    </thead>
    <tbody id="storiesSortableBody">
    <?php foreach ($stories as $row):
        $rowImages = $hasImagesJson ? story_decode_images((string)($row['images_json'] ?? '')) : [];
        if (!$rowImages && !empty($row['image_url'])) {
            $rowImages = [(string)$row['image_url']];
        }
        $cover = $rowImages[0] ?? '';
        $extraCount = max(0, count($rowImages) - 1);
    ?>
      <tr draggable="true" data-id="<?= (int)$row['id'] ?>" data-title="<?= h(mb_strtolower((string)$row['title'])) ?>" data-status="<?= (int)$row['is_published'] === 1 ? 'published' : 'draft' ?>">
        <td>
          <input type="checkbox" form="storiesBulkForm" name="ids[]" value="<?= (int)$row['id'] ?>" class="bulkRowCheckbox">
        </td>
        <td><?= (int)$row['id'] ?></td>
        <td><?= h((string)$row['title']) ?></td>
        <td>
          <?php if ($cover !== ''): ?>
            <a href="<?= h($cover) ?>" target="_blank">Открыть</a>
            <div style="position:relative;display:inline-block;margin-top:6px;">
              <img src="<?= h($cover) ?>" alt="" style="width:62px;height:110px;object-fit:cover;border-radius:6px;">
              <?php if ($extraCount > 0): ?>
                <span style="position:absolute;bottom:4px;right:4px;background:rgba(0,0,0,0.65);color:#fff;font-size:11px;font-weight:700;border-radius:8px;padding:2px 6px;">+<?= $extraCount ?></span>
              <?php endif; ?>
            </div>
          <?php else: ?>
            <span class="muted">Нет</span>
          <?php endif; ?>
        </td>
        <td><?= (int)$row['sort_order'] ?></td>
        <td><?= (int)$row['is_published'] === 1 ? 'Опубликовано' : 'Черновик' ?></td>
        <td>
          <a class="btn btnGhost" href="/api/public/admin/stories.php?edit=<?= (int)$row['id'] ?>" style="padding:4px 10px;font-size:12px;">Редактировать</a>
          <form method="post" style="display:inline;">
            <?= csrfField() ?>
            <input type="hidden" name="action" value="toggle_publish">
            <input type="hidden" name="id" value="<?= (int)$row['id'] ?>">
            <button type="submit" style="padding:4px 10px;font-size:12px;"><?= (int)$row['is_published'] === 1 ? 'Скрыть' : 'Показать' ?></button>
          </form>
          <form method="post" style="display:inline;">
            <?= csrfField() ?>
            <input type="hidden" name="action" value="move_up">
            <input type="hidden" name="id" value="<?= (int)$row['id'] ?>">
            <button type="submit" style="padding:4px 10px;font-size:12px;">▲</button>
          </form>
          <form method="post" style="display:inline;">
            <?= csrfField() ?>
            <input type="hidden" name="action" value="move_down">
            <input type="hidden" name="id" value="<?= (int)$row['id'] ?>">
            <button type="submit" style="padding:4px 10px;font-size:12px;">▼</button>
          </form>
          <?php if ($canDelete): ?>
            <form method="post" style="display:inline;">
              <?= csrfField() ?>
              <input type="hidden" name="action" value="delete">
              <input type="hidden" name="id" value="<?= (int)$row['id'] ?>">
              <button class="danger" type="submit" onclick="return confirm('Удалить историю?')" style="padding:4px 10px;font-size:12px;">Удалить</button>
            </form>
          <?php endif; ?>
        </td>
      </tr>
    <?php endforeach; ?>
    </tbody>
  </table>
</div>

<link rel="stylesheet" href="https://unpkg.com/cropperjs@1.6.2/dist/cropper.min.css">
<script src="https://unpkg.com/cropperjs@1.6.2/dist/cropper.min.js"></script>

<script>
/* ───── МНОЖЕСТВЕННАЯ ЗАГРУЗКА ФОТО + КРОППЕР НА КАЖДОЕ ───── */
(() => {
  const input = document.getElementById('story_image_files');
  const queueWrap = document.getElementById('story_crop_queue');
  const preview = document.getElementById('story_crop_preview');
  const counter = document.getElementById('story_photos_counter');
  const idxEl = document.getElementById('story_crop_idx');
  const totalEl = document.getElementById('story_crop_total');
  const prevBtn = document.getElementById('story_crop_prev');
  const nextBtn = document.getElementById('story_crop_next');
  const removeBtn = document.getElementById('story_crop_remove');
  const form = document.getElementById('storyEditForm');
  const existingGrid = document.getElementById('story_existing_grid');
  if (!input || !form) return;

  // queue: [{dataUrl: string, croppedDataUrl: string|null}]
  let queue = [];
  let cropper = null;
  let curIdx = 0;

  function existingCount() {
    return existingGrid ? existingGrid.querySelectorAll('.story-existing-tile').length : 0;
  }
  function updateCounter() {
    if (counter) counter.textContent = (existingCount() + queue.length) + ' фото';
  }

  // Удаление существующих фото
  if (existingGrid) {
    existingGrid.addEventListener('click', (e) => {
      const btn = e.target.closest('.story-existing-remove');
      if (!btn) return;
      const tile = btn.closest('.story-existing-tile');
      if (tile) {
        tile.remove();
        // Помечаем первую плитку как «обложка»
        const first = existingGrid.querySelector('.story-existing-tile');
        existingGrid.querySelectorAll('.story-existing-tile span').forEach(s => s.remove());
        if (first) {
          const badge = document.createElement('span');
          badge.style.cssText = 'position:absolute;bottom:4px;left:4px;background:#2563eb;color:#fff;font-size:10px;font-weight:700;border-radius:6px;padding:2px 6px;';
          badge.textContent = 'обложка';
          first.appendChild(badge);
        }
        updateCounter();
      }
    });
  }

  function readFiles(files) {
    const promises = [];
    for (const file of files) {
      promises.push(new Promise((resolve) => {
        const reader = new FileReader();
        reader.onload = () => resolve({ dataUrl: reader.result, croppedDataUrl: null });
        reader.readAsDataURL(file);
      }));
    }
    return Promise.all(promises);
  }

  function showCurrent() {
    if (queue.length === 0) {
      queueWrap.style.display = 'none';
      if (cropper) { cropper.destroy(); cropper = null; }
      return;
    }
    queueWrap.style.display = '';
    curIdx = Math.max(0, Math.min(curIdx, queue.length - 1));
    idxEl.textContent = (curIdx + 1);
    totalEl.textContent = queue.length;
    if (cropper) { cropper.destroy(); cropper = null; }
    preview.src = queue[curIdx].dataUrl;
    cropper = new Cropper(preview, {
      aspectRatio: 9 / 16,
      viewMode: 1,
      autoCropArea: 1,
      cropend: updateCrop,
      ready: updateCrop
    });
  }
  function updateCrop() {
    if (!cropper || queue.length === 0) return;
    const canvas = cropper.getCroppedCanvas({ width: 1080, height: 1920 });
    queue[curIdx].croppedDataUrl = canvas.toDataURL('image/jpeg', 0.9);
  }

  input.addEventListener('change', async (e) => {
    const files = Array.from(e.target.files || []);
    if (!files.length) return;
    const newOnes = await readFiles(files);
    queue = queue.concat(newOnes);
    curIdx = queue.length - newOnes.length;
    showCurrent();
    updateCounter();
    input.value = '';
  });

  prevBtn?.addEventListener('click', () => {
    if (cropper) updateCrop();
    if (curIdx > 0) curIdx--;
    showCurrent();
  });
  nextBtn?.addEventListener('click', () => {
    if (cropper) updateCrop();
    if (curIdx < queue.length - 1) curIdx++;
    showCurrent();
  });
  removeBtn?.addEventListener('click', () => {
    queue.splice(curIdx, 1);
    if (curIdx >= queue.length) curIdx = queue.length - 1;
    showCurrent();
    updateCounter();
  });

  form.addEventListener('submit', () => {
    if (cropper) updateCrop();
    // Удалим предыдущие hidden поля cropped_images_data[] (если submit повторный)
    form.querySelectorAll('input[data-tmp-cropped="1"]').forEach(el => el.remove());
    queue.forEach((q) => {
      const hidden = document.createElement('input');
      hidden.type = 'hidden';
      hidden.name = 'cropped_images_data[]';
      hidden.value = q.croppedDataUrl || q.dataUrl;
      hidden.setAttribute('data-tmp-cropped', '1');
      form.appendChild(hidden);
    });
  });

  updateCounter();
})();
</script>

<script>
/* ───── DRAG-AND-DROP ПОРЯДКА ───── */
(() => {
  const tbody = document.getElementById('storiesSortableBody');
  if (!tbody) return;
  let dragRow = null;
  tbody.querySelectorAll('tr[draggable="true"]').forEach((row) => {
    row.addEventListener('dragstart', () => { dragRow = row; row.style.opacity = '0.5'; });
    row.addEventListener('dragend', () => { row.style.opacity = ''; dragRow = null; });
    row.addEventListener('dragover', (e) => e.preventDefault());
    row.addEventListener('drop', (e) => {
      e.preventDefault();
      if (!dragRow || dragRow === row) return;
      const rows = Array.from(tbody.querySelectorAll('tr[draggable="true"]'));
      if (rows.indexOf(dragRow) < rows.indexOf(row)) row.after(dragRow); else row.before(dragRow);
    });
  });
})();
</script>

<script>
/* ───── BULK-ОПЕРАЦИИ ───── */
(() => {
  const form = document.getElementById('storiesBulkForm');
  const actionInput = document.getElementById('storiesBulkAction');
  const orderInput = document.getElementById('storiesOrderJson');
  const tbody = document.getElementById('storiesSortableBody');
  const headCheckbox = document.getElementById('bulkCheckAllHead');
  const counterEl = document.getElementById('bulkSelectedCount');
  if (!form || !tbody) return;

  function getCheckboxes() {
    return Array.from(document.querySelectorAll('.bulkRowCheckbox'));
  }
  function getSelectedIds() {
    return getCheckboxes().filter(c => c.checked).map(c => Number(c.value));
  }
  function updateCounter() {
    const n = getSelectedIds().length;
    if (counterEl) counterEl.textContent = n > 0 ? ('Выбрано: ' + n) : '';
    if (headCheckbox) {
      const all = getCheckboxes();
      const checked = all.filter(c => c.checked);
      headCheckbox.indeterminate = checked.length > 0 && checked.length < all.length;
      headCheckbox.checked = all.length > 0 && checked.length === all.length;
    }
  }
  document.addEventListener('change', (e) => {
    if (e.target.classList && e.target.classList.contains('bulkRowCheckbox')) updateCounter();
  });
  headCheckbox?.addEventListener('change', () => {
    getCheckboxes().forEach(c => { c.checked = headCheckbox.checked; });
    updateCounter();
  });
  document.getElementById('bulkSelectAllBtn')?.addEventListener('click', () => {
    const visible = getCheckboxes().filter(c => c.closest('tr')?.style.display !== 'none');
    const allChecked = visible.length > 0 && visible.every(c => c.checked);
    visible.forEach(c => { c.checked = !allChecked; });
    updateCounter();
  });

  function doBulk(action, confirmMsg) {
    const ids = getSelectedIds();
    if (!ids.length) { alert('Сначала выберите хотя бы одну историю.'); return; }
    if (confirmMsg && !confirm(confirmMsg + ' (' + ids.length + ' шт.)?')) return;
    actionInput.value = action;
    form.submit();
  }
  document.getElementById('bulkPublishBtn')?.addEventListener('click', () => doBulk('bulk_publish'));
  document.getElementById('bulkUnpublishBtn')?.addEventListener('click', () => doBulk('bulk_unpublish'));
  document.getElementById('bulkMoveUpBtn')?.addEventListener('click', () => doBulk('bulk_move_up'));
  document.getElementById('bulkMoveDownBtn')?.addEventListener('click', () => doBulk('bulk_move_down'));
  document.getElementById('bulkDeleteBtn')?.addEventListener('click', () => doBulk('bulk_delete', 'Удалить выбранные истории безвозвратно?'));

  document.getElementById('bulkSaveOrderBtn')?.addEventListener('click', () => {
    const order = Array.from(tbody.querySelectorAll('tr[draggable="true"]'))
      .map(r => Number(r.dataset.id || 0)).filter(id => id > 0);
    orderInput.value = JSON.stringify(order);
    actionInput.value = 'reorder';
    // Очищаем ids[] из формы — не относится к reorder
    form.querySelectorAll('.bulkRowCheckbox').forEach(c => c.checked = false);
    form.submit();
  });

  updateCounter();
})();
</script>

<script>
/* ───── ФИЛЬТР ───── */
(() => {
  const search = document.getElementById('storiesSearchInput');
  const status = document.getElementById('storiesStatusFilter');
  const tbody = document.getElementById('storiesSortableBody');
  if (!search || !status || !tbody) return;
  function applyFilters() {
    const q = search.value.trim().toLowerCase();
    const st = status.value;
    Array.from(tbody.querySelectorAll('tr')).forEach((row) => {
      const t = row.dataset.title || '';
      const s = row.dataset.status || '';
      const matchQ = q === '' || t.includes(q);
      const matchS = st === 'all' || st === s;
      row.style.display = matchQ && matchS ? '' : 'none';
    });
  }
  search.addEventListener('input', applyFilters);
  status.addEventListener('change', applyFilters);
})();
</script>

<?php require __DIR__ . '/_layout_bottom.php'; ?>
