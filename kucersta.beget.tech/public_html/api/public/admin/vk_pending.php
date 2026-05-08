<?php
/**
 * Админ-страница: модерация постов из ВК (предложка).
 *
 * Куда положить: /api/public/admin/vk_pending.php
 *
 * НОВОЕ:
 *   - Кнопка "▶ Запустить парсер сейчас" (AJAX → vk_parser_run.php)
 *   - Заголовок поста — крупное поле с большим шрифтом
 *   - Лайтбокс: клик по фото открывает его на весь экран
 *   - Можно выбрать НЕСКОЛЬКО фото — они все попадут в опубликованную историю
 */
declare(strict_types=1);

require __DIR__ . '/_bootstrap.php';
requireLogin();
if (!canManageContent()) {
    flash('Недостаточно прав для раздела контента.');
    redirectTo('/admin/index.php');
}

// Поддерживается ли в БД поле images_json в stories?
$storiesHasImagesJson = false;
try {
    $pdo->query('SELECT images_json FROM stories LIMIT 1');
    $storiesHasImagesJson = true;
} catch (Throwable $e) {
    $storiesHasImagesJson = false;
}

// ─── Обработка POST-действий ────────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = (string)($_POST['action'] ?? '');
    requireCsrf();

    if ($action === 'approve') {
        $id = (int)($_POST['id'] ?? 0);
        $title = trim((string)($_POST['title'] ?? ''));
        $content = trim((string)($_POST['content'] ?? ''));

        // Список выбранных фото (индексы из images_json) — может быть несколько
        $rawSelected = $_POST['selected_images'] ?? [];
        if (!is_array($rawSelected)) {
            $rawSelected = [$rawSelected];
        }
        $selectedIdxs = [];
        foreach ($rawSelected as $v) {
            $v = (int)$v;
            if ($v >= 0) $selectedIdxs[] = $v;
        }
        // Уникализируем, сохраняя порядок
        $selectedIdxs = array_values(array_unique($selectedIdxs));

        $publishNow = !empty($_POST['publish_now']) ? 1 : 0;

        if ($id <= 0 || $title === '' || $content === '') {
            flash('Заполните заголовок и текст.');
            redirectTo('/admin/vk_pending.php');
        }

        $row = $pdo->prepare('SELECT * FROM vk_pending_stories WHERE id=:id LIMIT 1');
        $row->execute(['id' => $id]);
        $pending = $row->fetch(PDO::FETCH_ASSOC);
        if (!$pending) {
            flash('Запись не найдена.');
            redirectTo('/admin/vk_pending.php');
        }
        if ($pending['status'] !== 'pending') {
            flash('Эта запись уже обработана.');
            redirectTo('/admin/vk_pending.php');
        }

        $images = json_decode((string)$pending['images_json'], true);
        if (!is_array($images)) $images = [];

        $chosen = [];
        foreach ($selectedIdxs as $idx) {
            if (isset($images[$idx])) $chosen[] = (string)$images[$idx];
        }
        $imageUrl = $chosen[0] ?? null;
        $chosenJson = $chosen ? json_encode(array_values(array_unique($chosen)), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) : null;

        $maxOrder = (int)$pdo->query('SELECT COALESCE(MAX(sort_order), 0) FROM stories')->fetchColumn();

        $pdo->beginTransaction();
        try {
            if ($storiesHasImagesJson) {
                $insStory = $pdo->prepare(
                    'INSERT INTO stories(title, content, image_url, images_json, sort_order, is_published)
                     VALUES (:title, :content, :image_url, :images_json, :sort_order, :is_published)'
                );
                $insStory->execute([
                    'title'        => mb_substr($title, 0, 250),
                    'content'      => $content,
                    'image_url'    => $imageUrl,
                    'images_json'  => $chosenJson,
                    'sort_order'   => $maxOrder + 1,
                    'is_published' => $publishNow,
                ]);
            } else {
                $insStory = $pdo->prepare(
                    'INSERT INTO stories(title, content, image_url, sort_order, is_published)
                     VALUES (:title, :content, :image_url, :sort_order, :is_published)'
                );
                $insStory->execute([
                    'title'        => mb_substr($title, 0, 250),
                    'content'      => $content,
                    'image_url'    => $imageUrl,
                    'sort_order'   => $maxOrder + 1,
                    'is_published' => $publishNow,
                ]);
            }
            $newStoryId = (int)$pdo->lastInsertId();

            $upd = $pdo->prepare(
                'UPDATE vk_pending_stories
                 SET status="approved",
                     title=:title,
                     content=:content,
                     selected_image=:sel,
                     published_story_id=:sid,
                     reviewed_by_user_id=:uid,
                     reviewed_at=NOW()
                 WHERE id=:id'
            );
            $u = getCurrentUser();
            $upd->execute([
                'title'   => mb_substr($title, 0, 250),
                'content' => $content,
                'sel'     => $selectedIdxs ? $selectedIdxs[0] : -1,
                'sid'     => $newStoryId,
                'uid'     => isset($u['id']) ? (int)$u['id'] : null,
                'id'      => $id,
            ]);
            $pdo->commit();
            auditLog($pdo, 'vk_approve', 'vk_pending', (string)$id, [
                'story_id' => $newStoryId, 'publish_now' => $publishNow,
                'photos' => count($chosen),
            ]);
            flash($publishNow ? ('Опубликовано в ленту историй (' . count($chosen) . ' фото).') : 'Сохранено как черновик в историях.');
        } catch (Throwable $e) {
            $pdo->rollBack();
            flash('Ошибка публикации: ' . $e->getMessage());
        }
        redirectTo('/admin/vk_pending.php');
    }

    if ($action === 'reject') {
        $id = (int)($_POST['id'] ?? 0);
        $reason = trim((string)($_POST['reject_reason'] ?? ''));
        if ($id > 0) {
            $u = getCurrentUser();
            $pdo->prepare(
                'UPDATE vk_pending_stories
                 SET status="rejected", reject_reason=:r, reviewed_by_user_id=:uid, reviewed_at=NOW()
                 WHERE id=:id AND status="pending"'
            )->execute([
                'r' => mb_substr($reason, 0, 500) ?: null,
                'uid' => isset($u['id']) ? (int)$u['id'] : null,
                'id' => $id,
            ]);
            auditLog($pdo, 'vk_reject', 'vk_pending', (string)$id, ['reason' => $reason]);
            flash('Запись отклонена.');
        }
        redirectTo('/admin/vk_pending.php');
    }

    if ($action === 'delete' && isAdmin()) {
        $id = (int)($_POST['id'] ?? 0);
        if ($id > 0) {
            $pdo->prepare('DELETE FROM vk_pending_stories WHERE id=:id')->execute(['id' => $id]);
            auditLog($pdo, 'vk_delete', 'vk_pending', (string)$id, null);
            flash('Запись удалена из предложки.');
        }
        redirectTo('/admin/vk_pending.php');
    }

    redirectTo('/admin/vk_pending.php');
}

// ─── Фильтрация и выборка ───────────────────────────────────────────────────
$statusFilter = (string)($_GET['status'] ?? 'pending');
if (!in_array($statusFilter, ['pending', 'approved', 'rejected', 'all'], true)) {
    $statusFilter = 'pending';
}

$sql = 'SELECT id, vk_owner_id, vk_post_id, vk_post_url, title, content, images_json,
               selected_image, vk_published_at, status, published_story_id,
               reject_reason, created_at
        FROM vk_pending_stories';
$params = [];
if ($statusFilter !== 'all') {
    $sql .= ' WHERE status = :st';
    $params['st'] = $statusFilter;
}
$sql .= ' ORDER BY vk_published_at DESC, id DESC LIMIT 200';

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$counts = [];
foreach ($pdo->query("SELECT status, COUNT(*) AS c FROM vk_pending_stories GROUP BY status")
              ->fetchAll(PDO::FETCH_ASSOC) as $r) {
    $counts[(string)$r['status']] = (int)$r['c'];
}

$lastRuns = $pdo->query(
    'SELECT id, started_at, finished_at, fetched_total, added_new, skipped_dup, status, message
     FROM vk_parser_runs ORDER BY id DESC LIMIT 10'
)->fetchAll(PDO::FETCH_ASSOC);

$lastOkAt = null;
foreach ($lastRuns as $r) {
    if ((string)$r['status'] === 'ok' && !empty($r['finished_at'])) {
        $lastOkAt = (string)$r['finished_at'];
        break;
    }
}

$title = 'ВК: предложка историй';
$user  = getCurrentUser();
require __DIR__ . '/_layout_top.php';
$msg = flash();
?>

<?php if ($msg): ?><div class="flash"><?= h($msg) ?></div><?php endif; ?>

<div class="card">
  <h2 style="margin-top:0;">Истории / мероприятия</h2>
  <p class="muted">Лента событий для абитуриентов: ручное управление + автоматическая предложка из VK.</p>
  <div class="tabs">
    <a class="tab" href="/api/public/admin/stories.php">Опубликованные истории</a>
    <a class="tab isActive" href="/api/public/admin/vk_pending.php">
      ВК предложка
      <?php if (!empty($counts['pending'])): ?>
        <span style="display:inline-block;background:#ef4444;color:#fff;border-radius:10px;padding:1px 8px;margin-left:6px;font-size:11px;font-weight:700;"><?= (int)$counts['pending'] ?></span>
      <?php endif; ?>
    </a>
  </div>
</div>

<div class="card">
  <div style="display:flex;flex-wrap:wrap;gap:10px;align-items:center;justify-content:space-between;">
    <div>
      <strong>Источник:</strong> <a href="https://vk.com/media_ak" target="_blank" rel="noopener">vk.com/media_ak</a><br>
      <span class="muted">
        Pending: <?= (int)($counts['pending'] ?? 0) ?> ·
        Approved: <?= (int)($counts['approved'] ?? 0) ?> ·
        Rejected: <?= (int)($counts['rejected'] ?? 0) ?>
        <?php if ($lastOkAt): ?>· Последний успешный парсинг: <?= h($lastOkAt) ?><?php endif; ?>
      </span>
    </div>
    <div style="display:flex;gap:8px;align-items:center;">
      <form method="get" style="display:flex;gap:6px;align-items:center;margin:0;">
        <select name="status" onchange="this.form.submit()" style="padding:8px 10px;border:1px solid #d1d5db;border-radius:8px;">
          <option value="pending"  <?= $statusFilter === 'pending'  ? 'selected' : '' ?>>На модерации</option>
          <option value="approved" <?= $statusFilter === 'approved' ? 'selected' : '' ?>>Одобренные</option>
          <option value="rejected" <?= $statusFilter === 'rejected' ? 'selected' : '' ?>>Отклонённые</option>
          <option value="all"      <?= $statusFilter === 'all'      ? 'selected' : '' ?>>Все</option>
        </select>
      </form>
      <button id="vkRunParserBtn" type="button" class="btn btnAccent" style="padding:10px 16px;font-weight:600;">
        ▶ Запустить парсер сейчас
      </button>
    </div>
  </div>
  <div id="vkRunParserResult" style="display:none;margin-top:12px;padding:10px 12px;border-radius:8px;font-size:13px;line-height:1.5;"></div>
</div>

<?php if (!$rows): ?>
  <div class="card">
    <p class="muted" style="margin:0;">Записей нет. Запустите парсер кнопкой выше или дождитесь следующего срабатывания cron.</p>
  </div>
<?php endif; ?>

<?php foreach ($rows as $r):
    $rowImages = json_decode((string)$r['images_json'], true);
    if (!is_array($rowImages)) $rowImages = [];
    $defaultIdx = (int)$r['selected_image'];
    $statusBadge = match ((string)$r['status']) {
        'pending'  => ['На модерации', '#f59e0b'],
        'approved' => ['Одобрено',     '#16a34a'],
        'rejected' => ['Отклонено',    '#9ca3af'],
        default    => [(string)$r['status'], '#6b7280'],
    };
?>
<div class="card" id="vk-<?= (int)$r['id'] ?>">
  <div style="display:flex;flex-wrap:wrap;gap:10px;align-items:center;justify-content:space-between;margin-bottom:10px;">
    <div>
      <span style="display:inline-block;background:<?= $statusBadge[1] ?>;color:#fff;border-radius:10px;padding:2px 10px;font-size:11px;font-weight:700;"><?= h($statusBadge[0]) ?></span>
      <span class="muted" style="margin-left:8px;">
        VK ID: <?= (int)$r['vk_post_id'] ?> · Опубликовано в VK: <?= h((string)$r['vk_published_at']) ?>
        <?php if (!empty($r['vk_post_url'])): ?>· <a href="<?= h((string)$r['vk_post_url']) ?>" target="_blank" rel="noopener">Открыть в VK ↗</a><?php endif; ?>
      </span>
    </div>
    <?php if ((string)$r['status'] === 'approved' && !empty($r['published_story_id'])): ?>
      <a class="btn btnGhost" href="/api/public/admin/stories.php?edit=<?= (int)$r['published_story_id'] ?>">Открыть в историях →</a>
    <?php endif; ?>
  </div>

  <?php if ((string)$r['status'] === 'pending'): ?>
    <form method="post" enctype="multipart/form-data">
      <?= csrfField() ?>
      <input type="hidden" name="action" value="approve">
      <input type="hidden" name="id" value="<?= (int)$r['id'] ?>">

      <label style="font-size:15px;font-weight:600;">Заголовок</label>
      <input name="title" value="<?= h((string)$r['title']) ?>" required
             style="font-size:18px;padding:14px 16px;line-height:1.4;min-height:56px;">

      <label style="font-size:15px;font-weight:600;margin-top:14px;">Текст</label>
      <textarea name="content" rows="6" required style="font-size:14px;padding:12px;line-height:1.55;"><?= h((string)$r['content']) ?></textarea>

      <label style="font-size:15px;font-weight:600;margin-top:14px;">
        Выберите фото для истории
        <span class="muted" style="font-weight:400;font-size:12px;">(можно несколько — листаются внутри одной истории)</span>
      </label>
      <?php if (!$rowImages): ?>
        <div class="muted">В посте нет фото.</div>
      <?php else: ?>
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(170px,1fr));gap:10px;margin-top:6px;">
          <?php foreach ($rowImages as $idx => $imgPath):
              $checked = ($idx === $defaultIdx);
          ?>
            <label class="vk-photo-tile" data-img="<?= h((string)$imgPath) ?>" style="position:relative;display:block;cursor:pointer;border-radius:10px;overflow:hidden;background:#f3f4f6;">
              <input type="checkbox" name="selected_images[]" value="<?= (int)$idx ?>" <?= $checked ? 'checked' : '' ?>
                     style="position:absolute;top:8px;left:8px;z-index:3;width:22px;height:22px;cursor:pointer;">
              <img src="<?= h((string)$imgPath) ?>" alt="" style="width:100%;height:200px;object-fit:cover;display:block;">
              <button type="button" class="vk-zoom-btn" title="Открыть"
                      style="position:absolute;top:8px;right:8px;z-index:3;border:none;background:rgba(0,0,0,0.55);color:#fff;border-radius:6px;width:30px;height:30px;cursor:pointer;font-size:14px;">⤢</button>
            </label>
          <?php endforeach; ?>
        </div>
      <?php endif; ?>

      <div style="margin-top:14px;display:flex;flex-wrap:wrap;gap:10px;align-items:center;">
        <label style="margin:0;display:inline-flex;align-items:center;gap:6px;">
          <input type="checkbox" name="publish_now" value="1" checked> Опубликовать сразу в приложении
        </label>
        <button type="submit">✔ Опубликовать</button>
      </div>
    </form>

    <hr style="margin:18px 0;border:none;border-top:1px solid #e5e7eb;">

    <form method="post" onsubmit="return confirm('Отклонить эту запись?');">
      <?= csrfField() ?>
      <input type="hidden" name="action" value="reject">
      <input type="hidden" name="id" value="<?= (int)$r['id'] ?>">
      <label>Причина отклонения (необязательно)</label>
      <input name="reject_reason" placeholder="Например: реклама / дубль / не подходит для абитуриентов">
      <button class="danger" type="submit" style="margin-top:8px;">✖ Отклонить</button>
    </form>

  <?php else: ?>
    <h3 style="margin:6px 0 8px;font-size:18px;font-weight:700;line-height:1.4;"><?= h((string)$r['title']) ?></h3>
    <div style="white-space:pre-wrap;color:#374151;line-height:1.55;margin-bottom:10px;font-size:14px;"><?= h((string)$r['content']) ?></div>
    <?php if ($rowImages): ?>
      <div style="display:flex;gap:8px;flex-wrap:wrap;">
        <?php foreach ($rowImages as $idx => $imgPath): ?>
          <div class="vk-photo-tile" data-img="<?= h((string)$imgPath) ?>" style="position:relative;cursor:zoom-in;">
            <img src="<?= h((string)$imgPath) ?>" alt="" style="width:120px;height:120px;object-fit:cover;border-radius:8px;<?= $idx === $defaultIdx ? 'outline:3px solid #2563eb;' : 'opacity:0.85;' ?>">
            <?php if ($idx === $defaultIdx): ?>
              <span style="position:absolute;top:4px;left:4px;background:#2563eb;color:#fff;border-radius:6px;padding:1px 6px;font-size:10px;font-weight:700;">главное</span>
            <?php endif; ?>
          </div>
        <?php endforeach; ?>
      </div>
    <?php endif; ?>
    <?php if ((string)$r['status'] === 'rejected' && !empty($r['reject_reason'])): ?>
      <p class="muted" style="margin-top:10px;"><strong>Причина:</strong> <?= h((string)$r['reject_reason']) ?></p>
    <?php endif; ?>
    <?php if (isAdmin()): ?>
      <form method="post" style="margin-top:10px;" onsubmit="return confirm('Полностью удалить запись из предложки?');">
        <?= csrfField() ?>
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" value="<?= (int)$r['id'] ?>">
        <button class="danger" type="submit">Удалить из предложки</button>
      </form>
    <?php endif; ?>
  <?php endif; ?>
</div>
<?php endforeach; ?>

<div class="card">
  <h3 style="margin-top:0;">Последние запуски парсера (Scrapy)</h3>
  <?php if (!$lastRuns): ?>
    <p class="muted" style="margin:0;">Парсер ещё ни разу не запускался. Нажмите «Запустить парсер сейчас» или проверьте cron.</p>
  <?php else: ?>
    <table>
      <thead><tr><th>Старт (UTC)</th><th>Финиш</th><th>Получено</th><th>Добавлено</th><th>Дубликатов</th><th>Статус</th><th>Сообщение</th></tr></thead>
      <tbody>
        <?php foreach ($lastRuns as $run): ?>
          <tr>
            <td><?= h((string)$run['started_at']) ?></td>
            <td><?= h((string)($run['finished_at'] ?? '—')) ?></td>
            <td><?= (int)$run['fetched_total'] ?></td>
            <td><?= (int)$run['added_new'] ?></td>
            <td><?= (int)$run['skipped_dup'] ?></td>
            <td>
              <?php if ((string)$run['status'] === 'ok'): ?>
                <span style="color:#16a34a;font-weight:600;">OK</span>
              <?php else: ?>
                <span style="color:#dc2626;font-weight:600;">ERROR</span>
              <?php endif; ?>
            </td>
            <td><?= h((string)($run['message'] ?? '')) ?></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  <?php endif; ?>
</div>

<!-- ─── Lightbox для просмотра фото ─── -->
<div id="vkLightbox" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.92);z-index:9999;align-items:center;justify-content:center;cursor:zoom-out;">
  <img id="vkLightboxImg" src="" alt="" style="max-width:96vw;max-height:96vh;border-radius:12px;box-shadow:0 8px 30px rgba(0,0,0,0.5);">
  <button type="button" id="vkLightboxClose" style="position:absolute;top:24px;right:24px;width:48px;height:48px;border:none;border-radius:50%;background:rgba(255,255,255,0.15);color:#fff;font-size:24px;cursor:pointer;">×</button>
</div>

<script>
/* ─── Lightbox ─── */
(() => {
  const box = document.getElementById('vkLightbox');
  const img = document.getElementById('vkLightboxImg');
  const closeBtn = document.getElementById('vkLightboxClose');
  function open(url) { img.src = url; box.style.display = 'flex'; }
  function close() { box.style.display = 'none'; img.src = ''; }
  document.addEventListener('click', (e) => {
    const tile = e.target.closest('.vk-photo-tile');
    if (!tile) return;
    // Если кликнули по галочке внутри плитки — НЕ открываем lightbox
    if (e.target.matches('input[type="checkbox"]')) return;
    // Кнопка-лупа или клик мимо чекбокса
    if (e.target.closest('.vk-zoom-btn') || !e.target.closest('input')) {
      e.preventDefault();
      const url = tile.getAttribute('data-img');
      if (url) open(url);
    }
  });
  closeBtn?.addEventListener('click', close);
  box.addEventListener('click', (e) => { if (e.target === box) close(); });
  document.addEventListener('keydown', (e) => { if (e.key === 'Escape') close(); });
})();

/* ─── Запуск парсера через AJAX ─── */
(() => {
  const btn = document.getElementById('vkRunParserBtn');
  const out = document.getElementById('vkRunParserResult');
  if (!btn || !out) return;
  btn.addEventListener('click', async () => {
    btn.disabled = true;
    const originalText = btn.textContent;
    btn.textContent = '⏳ Парсер работает…';
    out.style.display = 'block';
    out.style.background = '#fef3c7';
    out.style.border = '1px solid #fde68a';
    out.style.color = '#92400e';
    out.textContent = 'Запускаем Scrapy-парсер. Это занимает 5-30 секунд…';
    try {
      const r = await fetch('/api/public/admin/vk_parser_run.php', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' },
      });
      const json = await r.json();
      if (json.ok) {
        const lr = json.last_run || {};
        out.style.background = '#dcfce7';
        out.style.border = '1px solid #86efac';
        out.style.color = '#166534';
        out.innerHTML = '<strong>Парсер отработал успешно.</strong> ' +
          (lr.added_new !== undefined ? 'Новых: ' + lr.added_new + ', дубликатов: ' + lr.skipped_dup + ', получено: ' + lr.fetched_total + '. ' : '') +
          'Время: ' + json.elapsed_s + ' сек. Перезагрузите страницу, чтобы увидеть новые посты.';
        if (lr.added_new && Number(lr.added_new) > 0) {
          setTimeout(() => location.reload(), 1500);
        }
      } else {
        out.style.background = '#fee2e2';
        out.style.border = '1px solid #fca5a5';
        out.style.color = '#991b1b';
        out.innerHTML = '<strong>Ошибка:</strong> ' + (json.message || ('exit_code=' + json.exit_code)) +
          (json.stdout ? '<br><pre style="margin-top:8px;font-size:11px;white-space:pre-wrap;max-height:300px;overflow:auto;">' + escapeHtml(json.stdout) + '</pre>' : '') +
          (json.stderr ? '<br><pre style="margin-top:4px;font-size:11px;white-space:pre-wrap;color:#7f1d1d;max-height:300px;overflow:auto;">' + escapeHtml(json.stderr) + '</pre>' : '');
      }
    } catch (err) {
      out.style.background = '#fee2e2';
      out.style.border = '1px solid #fca5a5';
      out.style.color = '#991b1b';
      out.textContent = 'Сетевая ошибка: ' + err.message;
    } finally {
      btn.disabled = false;
      btn.textContent = originalText;
    }
  });
  function escapeHtml(s) {
    return String(s).replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
  }
})();
</script>

<?php require __DIR__ . '/_layout_bottom.php'; ?>
