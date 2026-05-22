<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';
$pageTitle = 'Карьера — Резюме студентов';

$filter = (string)($_GET['filter'] ?? 'all'); // all|published|hidden
if (!in_array($filter, ['all', 'published', 'hidden'], true)) {
    $filter = 'all';
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $canEdit) {
    $id = (int)($_POST['id'] ?? 0);
    $action = (string)($_POST['action'] ?? '');
    if ($id > 0) {
        if ($action === 'unpublish') {
            $pdo->prepare('UPDATE student_resumes SET is_published=0 WHERE id=:id')->execute(['id' => $id]);
        }
        if ($action === 'publish') {
            $pdo->prepare('UPDATE student_resumes SET is_published=1 WHERE id=:id')->execute(['id' => $id]);
        }
        if ($action === 'delete') {
            $pdo->prepare('DELETE FROM student_resumes WHERE id=:id')->execute(['id' => $id]);
        }
    }
    header('Location: student_resumes.php?filter=' . urlencode($filter));
    exit;
}

$where = '';
if ($filter === 'published') $where = 'WHERE r.is_published = 1';
if ($filter === 'hidden') $where = 'WHERE r.is_published = 0';

$rows = $pdo->query(
    'SELECT r.*,
            COALESCE(u.full_name, CONCAT("ID ", r.student_user_id)) AS student_name,
            COALESCE(u.email, "") AS student_email,
            COALESCE(u.phone, "") AS student_phone
     FROM student_resumes r
     LEFT JOIN users u ON u.id = r.student_user_id
     ' . $where . '
     ORDER BY r.updated_at DESC, r.id DESC LIMIT 500'
)->fetchAll();

require_once __DIR__ . '/../_layout_top.php';
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>
    <div class="career-content">
        <h1>📄 Резюме студентов</h1>
        <p style="color:#6c757d;">Здесь видны и черновики, и опубликованные резюме. Можно публиковать/скрывать/удалять.</p>

        <div style="display:flex; gap:8px; margin: 12px 0 18px 0; flex-wrap:wrap;">
            <a href="?filter=all" style="padding:6px 12px; <?= $filter==='all' ? 'background:#0d6efd; color:white;' : 'color:#6c757d;' ?>; text-decoration:none; border-radius:4px;">Все</a>
            <a href="?filter=published" style="padding:6px 12px; <?= $filter==='published' ? 'background:#0d6efd; color:white;' : 'color:#6c757d;' ?>; text-decoration:none; border-radius:4px;">Опубликованные</a>
            <a href="?filter=hidden" style="padding:6px 12px; <?= $filter==='hidden' ? 'background:#0d6efd; color:white;' : 'color:#6c757d;' ?>; text-decoration:none; border-radius:4px;">Черновики</a>
        </div>

        <?php if (empty($rows)): ?>
            <div style="background:white; padding:40px; text-align:center; color:#6c757d; border:1px solid #e0e0e0; border-radius:8px;">
                Резюме пока нет
            </div>
        <?php else: ?>
            <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(360px, 1fr)); gap:16px;">
                <?php foreach ($rows as $r):
                    $skills = json_decode((string)$r['skills_json'], true) ?: [];
                ?>
                <div style="background:white; padding:16px; border:1px solid #e0e0e0; border-radius:8px;">
                    <div style="display:flex; gap:10px; align-items:flex-start; justify-content:space-between;">
                        <h3 style="margin:0 0 4px 0;"><?= htmlspecialchars($r['title']) ?></h3>
                        <div style="white-space:nowrap; font-size:12px;">
                            <?= (int)$r['is_published'] === 1
                                ? '<span style="color:#198754;">✅ Опубл.</span>'
                                : '<span style="color:#dc3545;">⛔ Черновик</span>' ?>
                        </div>
                    </div>
                    <div style="color:#6c757d; font-size:13px;"><?= htmlspecialchars($r['student_name']) ?></div>
                    <div style="font-size:12px; color:#999; margin-bottom:12px;">
                        <?= htmlspecialchars($r['student_email']) ?>
                        <?php if ($r['student_phone']): ?> • <?= htmlspecialchars($r['student_phone']) ?><?php endif; ?>
                    </div>
                    <?php if ($r['summary']): ?>
                        <p style="font-size:14px; color:#333;"><?= nl2br(htmlspecialchars(mb_substr((string)$r['summary'], 0, 200))) ?></p>
                    <?php endif; ?>
                    <?php if (!empty($skills)): ?>
                        <div style="margin-top:8px;">
                            <?php foreach (array_slice($skills, 0, 8) as $sk):
                                $name = is_array($sk) ? ($sk['name'] ?? '') : (string)$sk;
                                if ($name === '') continue;
                            ?>
                                <span style="display:inline-block; padding:2px 8px; background:#e7f1ff; color:#0d6efd; border-radius:12px; font-size:11px; margin-right:4px; margin-bottom:4px;"><?= htmlspecialchars($name) ?></span>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>
                    <div style="margin-top:12px; font-size:12px; color:#6c757d;">Обновлено: <?= date('d.m.Y', strtotime($r['updated_at'])) ?></div>
                    <?php if ($canEdit): ?>
                        <div style="margin-top:12px; display:flex; gap:8px; align-items:center;">
                            <form method="post" style="display:inline;">
                                <input type="hidden" name="id" value="<?= (int)$r['id'] ?>">
                                <?php if ((int)$r['is_published'] === 1): ?>
                                    <button name="action" value="unpublish" style="padding:6px 10px; border:1px solid #e0e0e0; background:#fff; border-radius:6px; cursor:pointer;" title="Скрыть">🚫 Скрыть</button>
                                <?php else: ?>
                                    <button name="action" value="publish" style="padding:6px 10px; border:1px solid #0d6efd; background:#0d6efd; color:#fff; border-radius:6px; cursor:pointer;" title="Опубликовать">✅ Опубликовать</button>
                                <?php endif; ?>
                                <button name="action" value="delete" onclick="return confirm('Удалить резюме навсегда?')" style="padding:6px 10px; border:1px solid #dc3545; background:#fff; color:#dc3545; border-radius:6px; cursor:pointer;" title="Удалить">🗑 Удалить</button>
                            </form>
                        </div>
                    <?php endif; ?>
                </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
