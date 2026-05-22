<?php

declare(strict_types=1);

require_once __DIR__ . '/../src/Response.php';

// CORS preflight — должен отвечать до любой бизнес-логики
if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'OPTIONS') {
    Response::sendPreflight();
}

require_once __DIR__ . '/../src/Database.php';
require_once __DIR__ . '/../src/ApplicationSchema.php';
require_once __DIR__ . '/../src/Jwt.php';
require_once __DIR__ . '/../src/routes/_helpers.php';

$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
$uriPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
$basePath = '/api/public';
$path = rtrim(str_replace($basePath, '', $uriPath), '/');

if ($path === '') {
    $path = '/';
}

// Без БД: проверка, что PHP-сервер и роутер живы
if ($method === 'GET' && $path === '/health') {
    Response::json([
        'ok' => true,
        'service' => 'career-center-api',
        'time' => gmdate('c'),
        'note' => 'DB not checked here; use GET /health/db after fixing config.',
        'modules' => ['auth', 'public', 'student', 'admin', 'career'],
    ]);
}

$configPath = __DIR__ . '/../config.php';
if (!file_exists($configPath)) {
    Response::json([
        'ok' => false,
        'message' => 'Create backend/config.php from backend/config.example.php first.',
    ], 500);
}

$config = require $configPath;
try {
    $pdo = Database::connect($config);
} catch (Throwable $e) {
    Response::json([
        'ok' => false,
        'message' => 'Database connection failed',
        'hint' => 'Make sure PHP has pdo_mysql enabled (extension=pdo_mysql) and DB credentials in backend/config.php match phpMyAdmin (user, password, database name, port).',
    ], 500);
}

if ($method === 'GET' && $path === '/health/db') {
    Response::json([
        'ok' => true,
        'database' => 'connected',
        'time' => gmdate('c'),
    ]);
}

// =====================================================================
// AUTH: регистрация и логин
// =====================================================================

if ($method === 'POST' && $path === '/auth/register') {
    $input = getJsonInput();
    $fullName = trim((string)($input['full_name'] ?? ''));
    $email = mb_strtolower(trim((string)($input['email'] ?? '')));
    $password = (string)($input['password'] ?? '');

    if ($fullName === '' || $email === '' || $password === '') {
        Response::json(['ok' => false, 'message' => 'full_name, email, password required'], 422);
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        Response::json(['ok' => false, 'message' => 'Invalid email'], 422);
    }

    $stmt = $pdo->prepare('SELECT id FROM users WHERE email = :email LIMIT 1');
    $stmt->execute(['email' => $email]);
    if ($stmt->fetch()) {
        Response::json(['ok' => false, 'message' => 'User already exists'], 409);
    }

    $hash = password_hash($password, PASSWORD_BCRYPT);
    $insertUser = $pdo->prepare('INSERT INTO users(full_name, email, password_hash) VALUES (:full_name, :email, :password_hash)');
    $insertUser->execute([
        'full_name' => $fullName,
        'email' => $email,
        'password_hash' => $hash,
    ]);

    $userId = (int)$pdo->lastInsertId();
    $roleId = getRoleIdByCode($pdo, 'applicant');
    $attachRole = $pdo->prepare('INSERT INTO user_roles(user_id, role_id) VALUES (:user_id, :role_id)');
    $attachRole->execute(['user_id' => $userId, 'role_id' => $roleId]);

    Response::json(['ok' => true, 'user_id' => $userId], 201);
}

if ($method === 'POST' && $path === '/auth/login') {
    if (isRateLimited('api-login:' . ($_SERVER['REMOTE_ADDR'] ?? 'unknown'), 8, 300)) {
        Response::json(['ok' => false, 'message' => 'Too many login attempts. Try again later.'], 429);
    }

    $input = getJsonInput();
    $email = mb_strtolower(trim((string)($input['email'] ?? '')));
    $password = (string)($input['password'] ?? '');

    if ($email === '' || $password === '') {
        Response::json(['ok' => false, 'message' => 'email, password required'], 422);
    }

    $stmt = $pdo->prepare('SELECT id, full_name, email, password_hash, is_active FROM users WHERE email = :email LIMIT 1');
    $stmt->execute(['email' => $email]);
    $user = $stmt->fetch();

    if (!$user || !$user['is_active'] || !password_verify($password, $user['password_hash'])) {
        Response::json(['ok' => false, 'message' => 'Invalid credentials'], 401);
    }

    $userId = (int)$user['id'];
    $roles = getUserRoles($pdo, $userId);

    $token = Jwt::sign([
        'sub' => $userId,
        'email' => $user['email'],
        'roles' => $roles,
        'iat' => time(),
        'exp' => time() + 60 * 60 * 24 * 7, // 7 дней
    ]);

    Response::json([
        'ok' => true,
        'token' => $token,
        'user' => [
            'id' => $userId,
            'full_name' => $user['full_name'],
            'email' => $user['email'],
            'roles' => $roles,
        ],
    ]);
}

// =====================================================================
// PUBLIC: контент сайта
// =====================================================================

if ($method === 'GET' && $path === '/contacts') {
    $category = trim((string)($_GET['category'] ?? ''));
    if ($category !== '' && !in_array($category, ['college', 'career_center'], true)) {
        $category = '';
    }
    if ($category === '') {
        $stmt = $pdo->query(
            "SELECT id, type, value, label, image_url, sort_order, category
             FROM contacts
             WHERE is_active = 1
             ORDER BY sort_order ASC, id ASC"
        );
        Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
    }
    $stmt = $pdo->prepare(
        "SELECT id, type, value, label, image_url, sort_order, category
         FROM contacts
         WHERE is_active = 1 AND category = :cat
         ORDER BY sort_order ASC, id ASC"
    );
    $stmt->execute(['cat' => $category]);
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/career/contacts') {
    $stmt = $pdo->prepare(
        "SELECT id, type, value, label, image_url, sort_order, category
         FROM contacts
         WHERE is_active = 1 AND category = 'career_center'
         ORDER BY sort_order ASC, id ASC"
    );
    $stmt->execute();
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/news') {
    $stmt = $pdo->query(
        'SELECT id, title, content, image_url, published_at, created_at
         FROM news_items
         WHERE is_published = 1
         ORDER BY published_at DESC, id DESC
         LIMIT 50'
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/stories') {
    $stmt = $pdo->query(
        'SELECT id, title, image_url, video_url, content, published_at
         FROM stories
         WHERE is_published = 1
         ORDER BY sort_order ASC, published_at DESC
         LIMIT 50'
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/staff') {
    $department = trim((string)($_GET['department'] ?? ''));
    if ($department !== '' && !in_array($department, ['college', 'career_center'], true)) {
        $department = '';
    }
    if ($department === '') {
        $stmt = $pdo->query(
            "SELECT id, full_name, position_title, email, phone, office_hours, photo_url, color_hex, sort_order, department
             FROM staff_members
             WHERE is_published = 1
             ORDER BY sort_order ASC, full_name ASC"
        );
        Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
    }
    if ($department === 'career_center') {
        $stmt = $pdo->query(
            "SELECT id, full_name, position_title, email, phone, office_hours, photo_url, color_hex, sort_order, department
             FROM staff_members
             WHERE is_published = 1
               AND (department = 'career_center' OR department IS NULL OR department = '')
             ORDER BY sort_order ASC, full_name ASC"
        );
        Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
    }
    $stmt = $pdo->prepare(
        "SELECT id, full_name, position_title, email, phone, office_hours, photo_url, color_hex, sort_order, department
         FROM staff_members
         WHERE is_published = 1 AND department = :dep
         ORDER BY sort_order ASC, full_name ASC"
    );
    $stmt->execute(['dep' => $department]);
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/career/staff') {
    $stmt = $pdo->prepare(
        "SELECT id, full_name, position_title, email, phone, office_hours, photo_url, color_hex, sort_order, department
         FROM staff_members
         WHERE is_published = 1
           AND (department = 'career_center' OR department IS NULL OR department = '')
         ORDER BY sort_order ASC, full_name ASC"
    );
    $stmt->execute();
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/vacancies') {
    $stmt = $pdo->query(
        'SELECT id, title, company, city, employment_type, salary, description, published_at
         FROM vacancies
         WHERE is_active = 1
           AND (expires_at IS NULL OR expires_at >= CURDATE())
         ORDER BY published_at DESC, id DESC
         LIMIT 100'
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/pages') {
    $stmt = $pdo->query(
        'SELECT id, slug, title, content, updated_at
         FROM pages
         WHERE is_published = 1
         ORDER BY sort_order ASC, id ASC'
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/specialties') {
    $stmt = $pdo->query(
        'SELECT id, code, title, qualification, study_form, study_years, salary_range,
                description, is_published, sort_order
         FROM specialties
         WHERE is_published = 1
         ORDER BY sort_order ASC, code ASC'
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/education-programs') {
    $stmt = $pdo->query(
        'SELECT id, title, description, duration, price, image_url, is_published, sort_order
         FROM education_programs
         WHERE is_published = 1
         ORDER BY sort_order ASC, id ASC'
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/home/blocks') {
    $stmt = $pdo->query(
        "SELECT `key`, `value`
         FROM site_settings
         WHERE `key` LIKE 'home_%'"
    );
    $rows = $stmt->fetchAll();
    $out = [];
    foreach ($rows as $row) {
        $out[$row['key']] = $row['value'];
    }
    Response::json(['ok' => true, 'data' => $out]);
}

if ($method === 'GET' && $path === '/partners') {
    $stmt = $pdo->query(
        'SELECT id, name, description, website_url, logo_url, sort_order
         FROM partners
         WHERE is_published = 1
         ORDER BY sort_order ASC, name ASC'
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/career-test') {
    $stmt = $pdo->query(
        "SELECT `value` FROM site_settings WHERE `key` = 'career_test_questions' LIMIT 1"
    );
    $row = $stmt->fetch();
    $data = $row ? json_decode((string)$row['value'], true) : [];
    Response::json(['ok' => true, 'data' => $data ?: []]);
}

if ($method === 'GET' && $path === '/application-status') {
    $email = mb_strtolower(trim((string)($_GET['email'] ?? '')));
    if ($email === '') {
        Response::json(['ok' => false, 'message' => 'email required'], 422);
    }
    $stmt = $pdo->prepare(
        'SELECT id, type, full_name, email, phone, specialty_text, status, rejection_reason, created_at, updated_at
         FROM applications
         WHERE email = :email
         ORDER BY id DESC
         LIMIT 20'
    );
    $stmt->execute(['email' => $email]);
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'POST' && $path === '/applications') {
    $input = getJsonInput();
    $type = (string)($input['type'] ?? '');
    if (!in_array($type, ['documents', 'courses'], true)) {
        Response::json(['ok' => false, 'message' => 'Invalid type'], 422);
    }

    $fullName = trim((string)($input['full_name'] ?? ''));
    $email = mb_strtolower(trim((string)($input['email'] ?? '')));
    $phone = trim((string)($input['phone'] ?? ''));
    $specialty = trim((string)($input['specialty_text'] ?? ''));
    $payload = is_array($input['payload'] ?? null) ? $input['payload'] : [];

    if ($fullName === '' || $email === '') {
        Response::json(['ok' => false, 'message' => 'full_name and email required'], 422);
    }
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        Response::json(['ok' => false, 'message' => 'Invalid email'], 422);
    }

    $stmt = $pdo->prepare(
        'INSERT INTO applications(type, full_name, email, phone, specialty_text, payload_json, status)
         VALUES (:type, :full_name, :email, :phone, :spec, :payload, :status)'
    );
    $stmt->execute([
        'type' => $type,
        'full_name' => $fullName,
        'email' => $email,
        'phone' => $phone !== '' ? $phone : null,
        'spec' => $specialty !== '' ? $specialty : null,
        'payload' => json_encode($payload, JSON_UNESCAPED_UNICODE),
        'status' => 'new',
    ]);

    Response::json(['ok' => true, 'application_id' => (int)$pdo->lastInsertId()], 201);
}

// =====================================================================
// STUDENT: профиль, портфолио, резюме (создание/чтение)
// =====================================================================

if ($method === 'GET' && $path === '/student/profile') {
    $auth = requireRole($pdo, ['student', 'admin']);
    $userId = $auth['user_id'];

    $stmt = $pdo->prepare(
        'SELECT u.id, u.full_name, u.email, u.phone,
                sp.student_code, sp.group_id, sp.curator_staff_id, sp.birth_date,
                sp.bio, sp.avatar_url, sp.portfolio_public,
                g.name AS group_name
         FROM users u
         LEFT JOIN student_profiles sp ON sp.user_id = u.id
         LEFT JOIN groups_ref g ON g.id = sp.group_id
         WHERE u.id = :uid LIMIT 1'
    );
    $stmt->execute(['uid' => $userId]);
    $row = $stmt->fetch();
    Response::json(['ok' => true, 'data' => $row ?: null]);
}

if ($method === 'PUT' && $path === '/student/profile') {
    $auth = requireRole($pdo, ['student', 'admin']);
    $userId = $auth['user_id'];

    $body = getJsonInput();
    $fields = [];
    $params = ['uid' => $userId];

    foreach (['bio', 'avatar_url', 'birth_date'] as $k) {
        if (array_key_exists($k, $body)) {
            $fields[] = "$k = :$k";
            $params[$k] = $body[$k];
        }
    }
    if (array_key_exists('portfolio_public', $body)) {
        $fields[] = 'portfolio_public = :portfolio_public';
        $params['portfolio_public'] = (int)(bool)$body['portfolio_public'];
    }

    if (!empty($fields)) {
        $sql = 'UPDATE student_profiles SET ' . implode(', ', $fields) . ' WHERE user_id = :uid';
        $pdo->prepare($sql)->execute($params);
    }

    if (array_key_exists('full_name', $body) || array_key_exists('phone', $body)) {
        $u = [];
        $up = ['uid' => $userId];
        if (array_key_exists('full_name', $body)) {
            $u[] = 'full_name = :full_name';
            $up['full_name'] = (string)$body['full_name'];
        }
        if (array_key_exists('phone', $body)) {
            $u[] = 'phone = :phone';
            $up['phone'] = (string)$body['phone'];
        }
        $pdo->prepare('UPDATE users SET ' . implode(', ', $u) . ' WHERE id = :uid')->execute($up);
    }

    Response::json(['ok' => true]);
}

if ($method === 'GET' && $path === '/student/groups') {
    $stmt = $pdo->query('SELECT id, name, course, specialty_id FROM groups_ref ORDER BY name ASC');
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'GET' && $path === '/student/resumes') {
    $auth = requireRole($pdo, ['student', 'admin', 'career_manager']);
    $userId = $auth['user_id'];

    $stmt = $pdo->prepare(
        'SELECT id, title, summary, skills_json, experience_json, education_json,
                is_published, created_at, updated_at
         FROM student_resumes
         WHERE student_user_id = :uid
         ORDER BY id DESC'
    );
    $stmt->execute(['uid' => $userId]);
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'POST' && $path === '/student/resumes') {
    $auth = requireRole($pdo, ['student', 'admin']);
    $userId = $auth['user_id'];

    $body = getJsonInput();
    $title = trim((string)($body['title'] ?? ''));
    if ($title === '') {
        Response::json(['ok' => false, 'message' => 'title required'], 422);
    }

    $stmt = $pdo->prepare(
        'INSERT INTO student_resumes(student_user_id, title, summary, skills_json, experience_json, education_json, is_published)
         VALUES (:uid, :title, :summary, :skills, :exp, :edu, :pub)'
    );
    $stmt->execute([
        'uid' => $userId,
        'title' => $title,
        'summary' => (string)($body['summary'] ?? ''),
        'skills' => json_encode($body['skills'] ?? [], JSON_UNESCAPED_UNICODE),
        'exp' => json_encode($body['experience'] ?? [], JSON_UNESCAPED_UNICODE),
        'edu' => json_encode($body['education'] ?? [], JSON_UNESCAPED_UNICODE),
        'pub' => (int)(bool)($body['is_published'] ?? false),
    ]);

    Response::json(['ok' => true, 'resume_id' => (int)$pdo->lastInsertId()], 201);
}

if ($method === 'GET' && $path === '/student/portfolio') {
    $auth = requireRole($pdo, ['student', 'admin', 'career_manager']);
    $userId = $auth['user_id'];

    $stmt = $pdo->prepare(
        'SELECT id, title, description, project_url, image_url, gallery_json, tags_json,
                specialty_id, sort_order, is_published, created_at, updated_at
         FROM student_portfolio_items
         WHERE student_user_id = :uid
         ORDER BY sort_order ASC, id DESC'
    );
    $stmt->execute(['uid' => $userId]);
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

if ($method === 'POST' && $path === '/student/portfolio') {
    $auth = requireRole($pdo, ['student', 'admin']);
    $userId = $auth['user_id'];

    $body = getJsonInput();
    $title = trim((string)($body['title'] ?? ''));
    if ($title === '') {
        Response::json(['ok' => false, 'message' => 'title required'], 422);
    }

    $stmt = $pdo->prepare(
        'INSERT INTO student_portfolio_items(student_user_id, title, description, project_url, image_url, gallery_json, tags_json, specialty_id, is_published, sort_order)
         VALUES (:uid, :title, :desc, :url, :img, :gallery, :tags, :spec, :pub, :sort)'
    );
    $stmt->execute([
        'uid' => $userId,
        'title' => $title,
        'desc' => (string)($body['description'] ?? ''),
        'url' => (string)($body['project_url'] ?? '') ?: null,
        'img' => (string)($body['image_url'] ?? '') ?: null,
        'gallery' => isset($body['gallery']) && is_array($body['gallery'])
            ? json_encode(array_values($body['gallery']), JSON_UNESCAPED_UNICODE) : null,
        'tags' => isset($body['tags']) && is_array($body['tags'])
            ? json_encode(array_values($body['tags']), JSON_UNESCAPED_UNICODE) : null,
        'spec' => isset($body['specialty_id']) ? (int)$body['specialty_id'] : null,
        'pub' => (int)(bool)($body['is_published'] ?? true),
        'sort' => (int)($body['sort_order'] ?? 0),
    ]);

    Response::json(['ok' => true, 'item_id' => (int)$pdo->lastInsertId()], 201);
}

// =====================================================================
// МОДУЛЬ "КАРЬЕРА" — все эндпоинты /career/*, /student/portfolio/{id},
// /student/resumes/{id}, /student/portfolio/upload
// =====================================================================

require __DIR__ . '/../src/routes/career_routes.php';

// =====================================================================
// 404 — ни один маршрут не сработал
// =====================================================================

Response::json([
    'ok' => false,
    'message' => 'Route not found',
    'path' => $path,
    'method' => $method,
], 404);
