<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';

if (!$canEdit) {
    http_response_code(403);
    echo 'Нет прав на редактирование';
    exit;
}

$id = (int)($_GET['id'] ?? 0);
$isNew = $id === 0;
$pageTitle = $isNew ? 'Новая вакансия' : 'Редактирование вакансии';

$errors = [];
$row = [
    'title' => '', 'company' => '', 'partner_id' => null, 'city' => '',
    'employment_type' => '', 'salary' => '', 'description' => '',
    'contact_email' => '', 'contact_phone' => '',
    'published_at' => date('Y-m-d H:i:s'), 'expires_at' => null, 'is_active' => 1,
];

if (!$isNew) {
    $st = $pdo->prepare('SELECT * FROM vacancies WHERE id = :id');
    $st->execute(['id' => $id]);
    $r = $st->fetch();
    if (!$r) { http_response_code(404); echo 'Вакансия не найдена'; exit; }
    $row = $r;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $row['title'] = trim((string)($_POST['title'] ?? ''));
    $row['company'] = trim((string)($_POST['company'] ?? ''));
    $row['partner_id'] = !empty($_POST['partner_id']) ? (int)$_POST['partner_id'] : null;
    $row['city'] = trim((string)($_POST['city'] ?? ''));
    $row['employment_type'] = trim((string)($_POST['employment_type'] ?? ''));
    $row['salary'] = trim((string)($_POST['salary'] ?? ''));
    $row['description'] = trim((string)($_POST['description'] ?? ''));
    $row['contact_email'] = trim((string)($_POST['contact_email'] ?? ''));
    $row['contact_phone'] = trim((string)($_POST['contact_phone'] ?? ''));
    $row['published_at'] = trim((string)($_POST['published_at'] ?? '')) ?: date('Y-m-d H:i:s');
    $row['expires_at'] = trim((string)($_POST['expires_at'] ?? '')) ?: null;
    $row['is_active'] = isset($_POST['is_active']) ? 1 : 0;

    if ($row['title'] === '') $errors[] = 'Заполните название должности';
    if ($row['company'] === '') $errors[] = 'Укажите компанию';

    if (empty($errors)) {
        if ($isNew) {
            $sql = 'INSERT INTO vacancies(title, company, partner_id, city, employment_type, salary, description, contact_email, contact_phone, published_at, expires_at, is_active)
                    VALUES (:title, :company, :pid, :city, :etype, :salary, :desc, :em, :ph, :pub, :exp, :act)';
        } else {
            $sql = 'UPDATE vacancies SET title=:title, company=:company, partner_id=:pid, city=:city, employment_type=:etype,
                    salary=:salary, description=:desc, contact_email=:em, contact_phone=:ph,
                    published_at=:pub, expires_at=:exp, is_active=:act WHERE id=:id';
        }
        $params = [
            'title' => $row['title'], 'company' => $row['company'], 'pid' => $row['partner_id'],
            'city' => $row['city'], 'etype' => $row['employment_type'], 'salary' => $row['salary'],
            'desc' => $row['description'], 'em' => $row['contact_email'] ?: null,
            'ph' => $row['contact_phone'] ?: null, 'pub' => $row['published_at'],
            'exp' => $row['expires_at'], 'act' => $row['is_active'],
        ];
        if (!$isNew) $params['id'] = $id;

        $pdo->prepare($sql)->execute($params);
        header('Location: vacancies.php');
        exit;
    }
}

$partners = $pdo->query('SELECT id, name FROM partners ORDER BY name')->fetchAll();
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

        <form method="post" style="background:white; padding:20px; border:1px solid #e0e0e0; border-radius:8px; max-width:800px;">
            <?php
            $field = function(string $label, string $name, string $value, string $type = 'text', bool $required = false) {
                echo '<div style="margin-bottom:14px;">';
                echo '<label style="display:block; font-weight:600; margin-bottom:4px; font-size:14px;">' . htmlspecialchars($label) . ($required ? ' *' : '') . '</label>';
                echo '<input type="' . $type . '" name="' . $name . '" value="' . htmlspecialchars($value) . '" ' . ($required ? 'required' : '') . ' style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">';
                echo '</div>';
            };
            ?>

            <?php $field('Название должности', 'title', $row['title'], 'text', true); ?>
            <?php $field('Компания', 'company', $row['company'], 'text', true); ?>

            <div style="margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px; font-size:14px;">Партнёр (необязательно)</label>
                <select name="partner_id" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                    <option value="">— Не привязан —</option>
                    <?php foreach ($partners as $p): ?>
                        <option value="<?= $p['id'] ?>" <?= (int)$row['partner_id'] === (int)$p['id'] ? 'selected' : '' ?>>
                            <?= htmlspecialchars($p['name']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <?php $field('Город', 'city', $row['city']); ?>
                <?php $field('Тип занятости', 'employment_type', $row['employment_type']); ?>
            </div>

            <?php $field('Зарплата', 'salary', $row['salary']); ?>

            <div style="margin-bottom:14px;">
                <label style="display:block; font-weight:600; margin-bottom:4px; font-size:14px;">Описание</label>
                <textarea name="description" rows="6" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;"><?= htmlspecialchars($row['description']) ?></textarea>
            </div>

            <h3 style="margin-top:24px;">Контакты работодателя</h3>
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <?php $field('Email для откликов', 'contact_email', (string)$row['contact_email'], 'email'); ?>
                <?php $field('Телефон', 'contact_phone', (string)$row['contact_phone']); ?>
            </div>

            <h3 style="margin-top:24px;">Публикация</h3>
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:12px;">
                <?php $field('Дата публикации', 'published_at', (string)$row['published_at'], 'datetime-local'); ?>
                <?php $field('Действует до (необязат.)', 'expires_at', $row['expires_at'] ? date('Y-m-d', strtotime($row['expires_at'])) : '', 'date'); ?>
            </div>

            <div style="margin-top:14px;">
                <label><input type="checkbox" name="is_active" value="1" <?= $row['is_active'] ? 'checked' : '' ?>> Вакансия активна</label>
            </div>

            <div style="margin-top:24px; display:flex; gap:12px;">
                <button type="submit" style="padding:10px 20px; background:#0d6efd; color:white; border:none; border-radius:6px; cursor:pointer; font-size:14px;">💾 Сохранить</button>
                <a href="vacancies.php" style="padding:10px 20px; color:#6c757d; text-decoration:none;">Отмена</a>
            </div>
        </form>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
