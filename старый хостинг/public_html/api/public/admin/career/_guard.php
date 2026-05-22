<?php

declare(strict_types=1);

require_once __DIR__ . '/../_bootstrap.php';

// Используем существующую систему авторизации админки
$user = requireLogin();
$adminUserId = (int)($user['id'] ?? 0);
$adminRoles = (array)($user['roles'] ?? []);

// Кто может работать с модулем "Карьера"
$careerAllowedRoles = ['admin', 'career_manager', 'staff', 'content_manager'];

$hasAccess = false;
foreach ($careerAllowedRoles as $role) {
    if (in_array($role, $adminRoles, true)) {
        $hasAccess = true;
        break;
    }
}

if (!$hasAccess) {
    http_response_code(403);
    require_once __DIR__ . '/../_layout_top.php';
    echo '<div class="card" style="text-align:center; padding:40px;">';
    echo '<h1>403 — Доступ запрещён</h1>';
    echo '<p>У вашей учётной записи нет прав на работу с модулем «Карьера».</p>';
    echo '<p>Ваши роли: <code>' . htmlspecialchars(implode(', ', $adminRoles)) . '</code></p>';
    echo '<p>Нужна одна из ролей: <code>admin</code>, <code>career_manager</code>, <code>staff</code>, <code>content_manager</code>.</p>';
    echo '<p><a href="/api/public/admin/index.php">← Вернуться в админ-панель</a></p>';
    echo '</div>';
    require_once __DIR__ . '/../_layout_bottom.php';
    exit;
}

// Проверка, может ли текущий пользователь редактировать
$canEdit = !empty(array_intersect($adminRoles, ['admin', 'career_manager', 'content_manager']));

// $pdo уже доступен через _bootstrap.php
