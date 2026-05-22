<?php

declare(strict_types=1);

require_once __DIR__ . '/_guard.php';
$pageTitle = 'Карьера — Отчёты';

function safeQuery(PDO $pdo, string $sql): array
{
    try {
        return $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable $e) {
        error_log('[career/reports] ' . $e->getMessage() . ' | SQL: ' . $sql);
        return [];
    }
}

// 1. Топ партнёров по вакансиям
$topPartnersByVacancies = safeQuery(
    $pdo,
    'SELECT p.id, p.name, COUNT(v.id) AS cnt
     FROM partners p LEFT JOIN vacancies v ON v.partner_id = p.id AND v.is_active = 1
     GROUP BY p.id, p.name ORDER BY cnt DESC LIMIT 10'
);

// 2. Вакансии по городам
$vacanciesByCity = safeQuery(
    $pdo,
    "SELECT city, COUNT(*) AS cnt FROM vacancies
     WHERE is_active = 1 AND city IS NOT NULL AND city <> ''
     GROUP BY city ORDER BY cnt DESC LIMIT 10"
);

// 3. Топ типов занятости
$byEmploymentType = safeQuery(
    $pdo,
    "SELECT employment_type, COUNT(*) AS cnt FROM vacancies
     WHERE is_active = 1 AND employment_type IS NOT NULL AND employment_type <> ''
     GROUP BY employment_type ORDER BY cnt DESC LIMIT 10"
);

// 4. Категории мероприятий
$eventsByCategory = safeQuery(
    $pdo,
    "SELECT category, COUNT(*) AS cnt FROM events
     WHERE is_published = 1 GROUP BY category ORDER BY cnt DESC"
);

// 5. Портфолио по группам
$portfoliosByGroup = safeQuery(
    $pdo,
    "SELECT g.name AS group_name, COUNT(DISTINCT pi.student_user_id) AS students_with_portfolio
     FROM groups_ref g
     LEFT JOIN student_profiles sp ON sp.group_id = g.id
     LEFT JOIN student_portfolio_items pi ON pi.student_user_id = sp.user_id AND pi.is_published = 1
     GROUP BY g.id, g.name HAVING students_with_portfolio > 0
     ORDER BY students_with_portfolio DESC LIMIT 20"
);

// 6. Резюме по группам
$resumesByGroup = safeQuery(
    $pdo,
    "SELECT g.name AS group_name, COUNT(DISTINCT r.student_user_id) AS students_with_resume
     FROM groups_ref g
     LEFT JOIN student_profiles sp ON sp.group_id = g.id
     LEFT JOIN student_resumes r ON r.student_user_id = sp.user_id AND r.is_published = 1
     GROUP BY g.id, g.name HAVING students_with_resume > 0
     ORDER BY students_with_resume DESC LIMIT 20"
);

// 7. Сводные счётчики
$summary = [
    'total_vacancies'  => 0,
    'total_partners'   => 0,
    'total_events'     => 0,
    'total_portfolios' => 0,
    'total_resumes'    => 0,
];
try { $summary['total_vacancies']  = (int)$pdo->query('SELECT COUNT(*) FROM vacancies WHERE is_active = 1')->fetchColumn(); } catch (Throwable $e) {}
try { $summary['total_partners']   = (int)$pdo->query('SELECT COUNT(*) FROM partners WHERE is_published = 1')->fetchColumn(); } catch (Throwable $e) {}
try { $summary['total_events']     = (int)$pdo->query('SELECT COUNT(*) FROM events WHERE is_published = 1')->fetchColumn(); } catch (Throwable $e) {}
try { $summary['total_portfolios'] = (int)$pdo->query('SELECT COUNT(*) FROM student_portfolio_items WHERE is_published = 1')->fetchColumn(); } catch (Throwable $e) {}
try { $summary['total_resumes']    = (int)$pdo->query('SELECT COUNT(*) FROM student_resumes WHERE is_published = 1')->fetchColumn(); } catch (Throwable $e) {}

require_once __DIR__ . '/../_layout_top.php';
?>

<style>
.rep-wrap { max-width: 100%; }
.rep-summary { display: grid; grid-template-columns: repeat(5, 1fr); gap: 10px; margin-bottom: 18px; }
.rep-summary .cell {
    background: white; padding: 14px 10px; border: 1px solid #e0e0e0;
    border-radius: 8px; text-align: center; min-width: 0;
}
.rep-summary .num { font-size: 22px; font-weight: 700; color: #0d6efd; line-height: 1; }
.rep-summary .lbl { font-size: 11px; color: #6c757d; text-transform: uppercase; margin-top: 6px; letter-spacing: 0.3px; }

.rep-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
.rep-card {
    background: white; padding: 14px 16px; border: 1px solid #e0e0e0;
    border-radius: 8px; min-width: 0; overflow: hidden;
}
.rep-card h3 { margin: 0 0 10px 0; font-size: 15px; }
.rep-card table { width: 100%; border-collapse: collapse; table-layout: fixed; }
.rep-card td, .rep-card th {
    padding: 6px 4px; border-bottom: 1px solid #f0f0f0;
    font-size: 13px; text-align: left;
    overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}
.rep-card .num { text-align: right; font-weight: 600; color: #0d6efd; width: 50px; }
.rep-card .name-col { width: auto; }
.rep-empty { color: #6c757d; font-size: 13px; padding: 12px 0; }

@media (max-width: 1100px) { .rep-summary { grid-template-columns: repeat(3, 1fr); } }
@media (max-width: 800px) {
    .rep-grid { grid-template-columns: 1fr; }
    .rep-summary { grid-template-columns: repeat(2, 1fr); }
}
</style>

<div class="career-layout">
    <?php require __DIR__ . '/_menu.php'; ?>

    <div class="career-content">
        <h1 style="margin-bottom: 8px;">📈 Отчёты</h1>
        <p style="color:#6c757d; margin-top:0; margin-bottom:18px; font-size:14px;">
            Аналитика по модулю «Карьера» — ключевые цифры и распределение данных.
        </p>

        <div class="rep-wrap">

            <div class="rep-summary">
                <div class="cell">
                    <div class="num"><?= (int)$summary['total_vacancies'] ?></div>
                    <div class="lbl">Активн. вакансий</div>
                </div>
                <div class="cell">
                    <div class="num"><?= (int)$summary['total_partners'] ?></div>
                    <div class="lbl">Партнёров</div>
                </div>
                <div class="cell">
                    <div class="num"><?= (int)$summary['total_events'] ?></div>
                    <div class="lbl">Мероприятий</div>
                </div>
                <div class="cell">
                    <div class="num"><?= (int)$summary['total_portfolios'] ?></div>
                    <div class="lbl">Портфолио</div>
                </div>
                <div class="cell">
                    <div class="num"><?= (int)$summary['total_resumes'] ?></div>
                    <div class="lbl">Резюме</div>
                </div>
            </div>

            <div class="rep-grid">

                <div class="rep-card">
                    <h3>🏆 Топ партнёров по вакансиям</h3>
                    <?php if (empty($topPartnersByVacancies)): ?>
                        <div class="rep-empty">Нет данных</div>
                    <?php else: ?>
                        <table>
                            <?php foreach ($topPartnersByVacancies as $p): ?>
                                <tr>
                                    <td class="name-col" title="<?= htmlspecialchars((string)$p['name']) ?>">
                                        <?= htmlspecialchars((string)$p['name']) ?>
                                    </td>
                                    <td class="num"><?= (int)$p['cnt'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </table>
                    <?php endif; ?>
                </div>

                <div class="rep-card">
                    <h3>🌍 Вакансии по городам</h3>
                    <?php if (empty($vacanciesByCity)): ?>
                        <div class="rep-empty">Нет данных</div>
                    <?php else: ?>
                        <table>
                            <?php foreach ($vacanciesByCity as $c): ?>
                                <tr>
                                    <td class="name-col" title="<?= htmlspecialchars((string)$c['city']) ?>">
                                        <?= htmlspecialchars((string)$c['city']) ?>
                                    </td>
                                    <td class="num"><?= (int)$c['cnt'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </table>
                    <?php endif; ?>
                </div>

                <div class="rep-card">
                    <h3>💼 По типу занятости</h3>
                    <?php if (empty($byEmploymentType)): ?>
                        <div class="rep-empty">Нет данных</div>
                    <?php else: ?>
                        <table>
                            <?php foreach ($byEmploymentType as $t): ?>
                                <tr>
                                    <td class="name-col" title="<?= htmlspecialchars((string)$t['employment_type']) ?>">
                                        <?= htmlspecialchars((string)$t['employment_type']) ?>
                                    </td>
                                    <td class="num"><?= (int)$t['cnt'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </table>
                    <?php endif; ?>
                </div>

                <div class="rep-card">
                    <h3>📅 Мероприятия по категориям</h3>
                    <?php if (empty($eventsByCategory)): ?>
                        <div class="rep-empty">Мероприятий пока нет</div>
                    <?php else: ?>
                        <?php
                        $catLabels = [
                            'career'    => 'Карьера',
                            'meetup'    => 'Митап',
                            'fair'      => 'Ярмарка',
                            'workshop'  => 'Воркшоп',
                            'excursion' => 'Экскурсия',
                            'other'     => 'Другое',
                        ];
                        ?>
                        <table>
                            <?php foreach ($eventsByCategory as $e):
                                $name = $catLabels[$e['category']] ?? $e['category'];
                            ?>
                                <tr>
                                    <td class="name-col"><?= htmlspecialchars((string)$name) ?></td>
                                    <td class="num"><?= (int)$e['cnt'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </table>
                    <?php endif; ?>
                </div>

                <div class="rep-card">
                    <h3>🎨 Портфолио по группам</h3>
                    <?php if (empty($portfoliosByGroup)): ?>
                        <div class="rep-empty">Студенты ещё не загружали портфолио</div>
                    <?php else: ?>
                        <table>
                            <thead>
                                <tr>
                                    <th class="name-col">Группа</th>
                                    <th class="num">Чел.</th>
                                </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($portfoliosByGroup as $g): ?>
                                <tr>
                                    <td class="name-col" title="<?= htmlspecialchars((string)$g['group_name']) ?>">
                                        <?= htmlspecialchars((string)$g['group_name']) ?>
                                    </td>
                                    <td class="num"><?= (int)$g['students_with_portfolio'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                            </tbody>
                        </table>
                    <?php endif; ?>
                </div>

                <div class="rep-card">
                    <h3>📄 Резюме по группам</h3>
                    <?php if (empty($resumesByGroup)): ?>
                        <div class="rep-empty">Резюме ещё не публиковались</div>
                    <?php else: ?>
                        <table>
                            <thead>
                                <tr>
                                    <th class="name-col">Группа</th>
                                    <th class="num">Чел.</th>
                                </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($resumesByGroup as $g): ?>
                                <tr>
                                    <td class="name-col" title="<?= htmlspecialchars((string)$g['group_name']) ?>">
                                        <?= htmlspecialchars((string)$g['group_name']) ?>
                                    </td>
                                    <td class="num"><?= (int)$g['students_with_resume'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                            </tbody>
                        </table>
                    <?php endif; ?>
                </div>

            </div>
        </div>
    </div>
</div>

<?php require_once __DIR__ . '/../_layout_bottom.php'; ?>
