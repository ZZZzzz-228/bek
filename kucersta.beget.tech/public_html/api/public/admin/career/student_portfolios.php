<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';
$pageTitle = 'Карьера — Портфолио студентов';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $canEdit) {
    $id = (int)($_POST['id'] ?? 0);
    $action = (string)($_POST['action'] ?? '');
    if ($id > 0) {
        if ($action === 'unpublish') $pdo->prepare('UPDATE student_portfolio_items SET is_published=0 WHERE id=:id')->execute(['id'=>$id]);
        if ($action === 'publish') $pdo->prepare('UPDATE student_portfolio_items SET is_published=1 WHERE id=:id')->execute(['id'=>$id]);
        if ($action === 'delete') $pdo->prepare('DELETE FROM student_portfolio_items WHERE id=:id')->execute(['id'=>$id]);
    }
    header('Location: student_portfolios.php'); exit;
}

$rows = $pdo->query(
    'SELECT pi.*, u.full_name AS student_name, u.email AS student_email
     FROM student_portfolio_items pi
     JOIN users u ON u.id = pi.student_user_id
     ORDER BY pi.created_at DESC LIMIT 500'
)->fetchAll();

function normalizeExternalUrl(?string $raw): ?string
{
    $value = trim((string)$raw);
    if ($value === '' || strtolower($value) === 'false' || strtolower($value) === 'null') {
        return null;
    }
    if (!preg_match('#^https?://#i', $value)) {
        $value = 'https://' . $value;
    }
    return $value;
}

require_once __DIR__ . '/../_layout_top.php';
?>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>
    <div class="career-content">
        <h1>🎨 Портфолио студентов</h1>
        <p style="color:#6c757d;">Модерация работ — можно скрыть или удалить нарушающий контент.</p>

        <table style="width:100%; border-collapse:collapse; background:white; border:1px solid #e0e0e0; border-radius:8px;">
            <thead style="background:#f8f9fa;">
                <tr>
                    <th style="padding:10px;"></th>
                    <th style="padding:10px; text-align:left;">Работа</th>
                    <th style="padding:10px; text-align:left;">Студент</th>
                    <th style="padding:10px; text-align:left;">Создано</th>
                    <th style="padding:10px; text-align:left;">Статус</th>
                    <?php if ($canEdit): ?><th style="padding:10px;"></th><?php endif; ?>
                </tr>
            </thead>
            <tbody>
            <?php if (empty($rows)): ?>
                <tr><td colspan="6" style="padding:24px; text-align:center; color:#6c757d;">Пока нет работ от студентов</td></tr>
            <?php else: foreach ($rows as $r):
                $projectUrl = normalizeExternalUrl($r['project_url'] ?? null);
            ?>
                <tr style="border-top:1px solid #f0f0f0;">
                    <td style="padding:10px;">
                        <?php if ($r['image_url']): ?>
                            <img src="<?= htmlspecialchars($r['image_url']) ?>" style="width:64px; height:48px; object-fit:cover; border-radius:4px;">
                        <?php else: ?>
                            <div style="width:64px; height:48px; background:#e9ecef; border-radius:4px;"></div>
                        <?php endif; ?>
                    </td>
                    <td style="padding:10px;">
                        <strong><?= htmlspecialchars($r['title']) ?></strong>
                        <?php if ($projectUrl): ?><br><a href="<?= htmlspecialchars($projectUrl) ?>" target="_blank" style="font-size:12px;">🔗 Открыть</a><?php endif; ?>
                    </td>
                    <td style="padding:10px;">
                        <?= htmlspecialchars($r['student_name']) ?><br>
                        <small style="color:#6c757d;"><?= htmlspecialchars($r['student_email']) ?></small>
                    </td>
                    <td style="padding:10px; font-size:12px;"><?= date('d.m.Y', strtotime($r['created_at'])) ?></td>
                    <td style="padding:10px;">
                        <?= $r['is_published'] ? '<span style="color:#198754;">✅ Опубл.</span>' : '<span style="color:#dc3545;">⛔ Скрыто</span>' ?>
                    </td>
                    <?php if ($canEdit): ?>
                    <td style="padding:10px; white-space:nowrap;">
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<?= $r['id'] ?>">
                            <?php if ($r['is_published']): ?>
                                <button name="action" value="unpublish" style="background:none; border:none; cursor:pointer;" title="Скрыть">🚫</button>
                            <?php else: ?>
                                <button name="action" value="publish" style="background:none; border:none; cursor:pointer;" title="Опубликовать">✅</button>
                            <?php endif; ?>
                            <button name="action" value="delete" onclick="return confirm('Удалить навсегда?')" style="background:none; border:none; cursor:pointer; color:#dc3545;" title="Удалить">🗑</button>
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
