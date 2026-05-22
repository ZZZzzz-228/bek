<?php

declare(strict_types=1);

// Текущая страница для подсветки активного пункта
$current = basename($_SERVER['SCRIPT_NAME'] ?? '');

$menuItems = [
    ['file' => 'dashboard.php',          'icon' => '📊', 'label' => 'Дашборд'],
    ['file' => 'vacancies.php',          'icon' => '💼', 'label' => 'Вакансии'],
    ['file' => 'partners.php',           'icon' => '🤝', 'label' => 'Партнёры'],
    ['file' => 'events.php',             'icon' => '📅', 'label' => 'Мероприятия'],
    ['file' => 'career_contacts.php',    'icon' => '📞', 'label' => 'Контакты центра'],
    ['file' => 'career_staff.php',       'icon' => '👥', 'label' => 'Сотрудники центра'],
    ['file' => 'student_portfolios.php', 'icon' => '🎨', 'label' => 'Портфолио студентов'],
    ['file' => 'student_resumes.php',    'icon' => '📄', 'label' => 'Резюме студентов'],
    ['file' => 'reports.php',            'icon' => '📈', 'label' => 'Отчёты'],
];
?>
<style>
.career-layout { display: flex; gap: 20px; align-items: flex-start; }
.career-sidebar {
    flex: 0 0 240px;
    background: #f8f9fa;
    border-radius: 8px;
    padding: 16px 0;
    border: 1px solid #e0e0e0;
}
.career-sidebar h3 {
    margin: 0 0 12px 0;
    padding: 0 16px;
    font-size: 14px;
    text-transform: uppercase;
    color: #666;
    letter-spacing: 0.5px;
}
.career-sidebar a {
    display: block;
    padding: 10px 16px;
    color: #333;
    text-decoration: none;
    font-size: 14px;
    border-left: 3px solid transparent;
    transition: all 0.15s;
}
.career-sidebar a:hover { background: #e9ecef; }
.career-sidebar a.active {
    background: #e7f1ff;
    border-left-color: #0d6efd;
    color: #0d6efd;
    font-weight: 600;
}
.career-content { flex: 1; min-width: 0; }
.career-back-link {
    display: inline-block;
    margin-bottom: 12px;
    color: #6c757d;
    text-decoration: none;
    font-size: 13px;
}
.career-back-link:hover { color: #0d6efd; }
</style>
<div class="career-sidebar">
    <h3>Модуль «Карьера»</h3>
    <a href="../index.php" class="career-back-link" style="padding: 10px 16px;">← К админ-панели</a>
    <?php foreach ($menuItems as $item): ?>
        <a href="<?= htmlspecialchars($item['file']) ?>"
           class="<?= $current === $item['file'] ? 'active' : '' ?>">
            <span style="margin-right: 8px;"><?= $item['icon'] ?></span>
            <?= htmlspecialchars($item['label']) ?>
        </a>
    <?php endforeach; ?>
</div>
