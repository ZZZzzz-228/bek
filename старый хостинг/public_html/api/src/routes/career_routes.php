<?php

declare(strict_types=1);

// =====================================================================
// Маршруты модуля "Карьера"
// $pdo, $method, $path - переданы из index.php
// =====================================================================

// ---------- /career/vacancies — список с фильтрами ----------
if ($method === 'GET' && $path === '/career/vacancies') {
    $city = trim((string)($_GET['city'] ?? ''));
    $type = trim((string)($_GET['type'] ?? ''));
    $partnerId = (int)($_GET['partner_id'] ?? 0);
    $q = trim((string)($_GET['q'] ?? ''));

    $sql = 'SELECT v.id, v.title, v.company, v.partner_id, v.city, v.employment_type,
                   v.salary, v.description, v.contact_email, v.contact_phone,
                   v.published_at, v.expires_at, v.is_active,
                   p.name AS partner_name, p.logo_url AS partner_logo
            FROM vacancies v
            LEFT JOIN partners p ON p.id = v.partner_id
            WHERE v.is_active = 1
              AND (v.expires_at IS NULL OR v.expires_at >= CURDATE())';
    $params = [];

    if ($city !== '') {
        $sql .= ' AND v.city = :city';
        $params['city'] = $city;
    }
    if ($type !== '') {
        $sql .= ' AND v.employment_type = :type';
        $params['type'] = $type;
    }
    if ($partnerId > 0) {
        $sql .= ' AND v.partner_id = :pid';
        $params['pid'] = $partnerId;
    }
    if ($q !== '') {
        $sql .= ' AND (v.title LIKE :q OR v.company LIKE :q OR v.description LIKE :q)';
        $params['q'] = '%' . $q . '%';
    }

    $sql .= ' ORDER BY v.published_at DESC, v.id DESC LIMIT 200';

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

// ---------- /career/vacancies/{id} — одна вакансия ----------
if ($method === 'GET' && ($p = matchPath('/career/vacancies/{id}', $path)) !== null) {
    $id = (int)$p['id'];
    $stmt = $pdo->prepare(
        'SELECT v.*, p.name AS partner_name, p.logo_url AS partner_logo, p.website_url AS partner_site
         FROM vacancies v
         LEFT JOIN partners p ON p.id = v.partner_id
         WHERE v.id = :id AND v.is_active = 1
         LIMIT 1'
    );
    $stmt->execute(['id' => $id]);
    $row = $stmt->fetch();
    if (!$row) {
        Response::json(['ok' => false, 'message' => 'Vacancy not found'], 404);
    }
    Response::json(['ok' => true, 'data' => $row]);
}

// ---------- /career/partners — список партнёров ----------
if ($method === 'GET' && $path === '/career/partners') {
    $stmt = $pdo->query(
        'SELECT id, name, description, website_url, logo_url, sort_order
         FROM partners
         WHERE is_published = 1
         ORDER BY sort_order ASC, name ASC'
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

// ---------- /career/partners/{id} — партнёр + его вакансии ----------
if ($method === 'GET' && ($p = matchPath('/career/partners/{id}', $path)) !== null) {
    $id = (int)$p['id'];
    $st = $pdo->prepare('SELECT * FROM partners WHERE id = :id AND is_published = 1');
    $st->execute(['id' => $id]);
    $partner = $st->fetch();
    if (!$partner) {
        Response::json(['ok' => false, 'message' => 'Partner not found'], 404);
    }

    $st2 = $pdo->prepare(
        'SELECT id, title, city, employment_type, salary, published_at
         FROM vacancies
         WHERE partner_id = :pid AND is_active = 1
           AND (expires_at IS NULL OR expires_at >= CURDATE())
         ORDER BY published_at DESC LIMIT 50'
    );
    $st2->execute(['pid' => $id]);
    $partner['vacancies'] = $st2->fetchAll();

    $st3 = $pdo->prepare(
        'SELECT id, title, starts_at, location, category
         FROM events
         WHERE partner_id = :pid AND is_published = 1
         ORDER BY starts_at DESC LIMIT 20'
    );
    $st3->execute(['pid' => $id]);
    $partner['events'] = $st3->fetchAll();

    Response::json(['ok' => true, 'data' => $partner]);
}

// ---------- /career/contacts — контакты центра карьеры ----------
if ($method === 'GET' && $path === '/career/contacts') {
    $stmt = $pdo->query(
        "SELECT id, type, value, label, image_url, sort_order
         FROM contacts
         WHERE is_active = 1 AND category = 'career_center'
         ORDER BY sort_order ASC, id ASC"
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

// ---------- /career/staff — сотрудники центра карьеры ----------
if ($method === 'GET' && $path === '/career/staff') {
    $stmt = $pdo->query(
        "SELECT id, full_name, position_title, email, phone, office_hours, photo_url, color_hex, sort_order
         FROM staff_members
         WHERE is_published = 1 AND department = 'career_center'
         ORDER BY sort_order ASC, full_name ASC"
    );
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

// ---------- /career/events — мероприятия (upcoming/past) ----------
if ($method === 'GET' && $path === '/career/events') {
    $period = trim((string)($_GET['period'] ?? 'upcoming'));
    $category = trim((string)($_GET['category'] ?? ''));

    $sql = 'SELECT e.id, e.title, e.description, e.starts_at, e.ends_at, e.location,
                   e.category, e.cover_url, e.partner_id, e.external_url,
                   p.name AS partner_name, p.logo_url AS partner_logo
            FROM events e
            LEFT JOIN partners p ON p.id = e.partner_id
            WHERE e.is_published = 1';
    $params = [];

    if ($period === 'upcoming') {
        $sql .= ' AND e.starts_at >= NOW()';
        $sql .= ' ORDER BY e.starts_at ASC';
    } elseif ($period === 'past') {
        $sql .= ' AND e.starts_at < NOW()';
        $sql .= ' ORDER BY e.starts_at DESC';
    } else {
        $sql .= ' ORDER BY e.starts_at DESC';
    }

    if ($category !== '') {
        $sql = str_replace('WHERE e.is_published = 1', 'WHERE e.is_published = 1 AND e.category = :cat', $sql);
        $params['cat'] = $category;
    }

    $sql .= ' LIMIT 100';

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    Response::json(['ok' => true, 'data' => $stmt->fetchAll()]);
}

// ---------- /career/events/{id} ----------
if ($method === 'GET' && ($p = matchPath('/career/events/{id}', $path)) !== null) {
    $id = (int)$p['id'];
    $stmt = $pdo->prepare(
        'SELECT e.*, p.name AS partner_name, p.logo_url AS partner_logo, p.website_url AS partner_site
         FROM events e
         LEFT JOIN partners p ON p.id = e.partner_id
         WHERE e.id = :id AND e.is_published = 1
         LIMIT 1'
    );
    $stmt->execute(['id' => $id]);
    $row = $stmt->fetch();
    if (!$row) {
        Response::json(['ok' => false, 'message' => 'Event not found'], 404);
    }
    Response::json(['ok' => true, 'data' => $row]);
}

// =====================================================================
// СТУДЕНЧЕСКИЕ: Портфолио (CRUD + загрузка фото)
// =====================================================================

// ---------- PUT /student/portfolio/{id} — редактировать ----------
if ($method === 'PUT' && ($p = matchPath('/student/portfolio/{id}', $path)) !== null) {
    $auth = requireRole($pdo, ['student', 'admin', 'career_manager']);
    $userId = $auth['user_id'];
    $itemId = (int)$p['id'];

    $st = $pdo->prepare(
        'SELECT id, student_user_id FROM student_portfolio_items WHERE id = :id LIMIT 1'
    );
    $st->execute(['id' => $itemId]);
    $row = $st->fetch();
    if (!$row) {
        Response::json(['ok' => false, 'message' => 'Item not found'], 404);
    }
    if ((int)$row['student_user_id'] !== $userId
        && !userHasAnyRole($pdo, $userId, ['admin', 'career_manager'])) {
        Response::json(['ok' => false, 'message' => 'Forbidden'], 403);
    }

    $body = getJsonInput();
    $fields = [];
    $params = ['id' => $itemId];

    foreach (['title', 'description', 'project_url', 'image_url'] as $k) {
        if (array_key_exists($k, $body)) {
            $fields[] = "$k = :$k";
            $params[$k] = $body[$k];
        }
    }
    if (array_key_exists('gallery', $body) && is_array($body['gallery'])) {
        $fields[] = 'gallery_json = :gallery_json';
        $params['gallery_json'] = json_encode(array_values($body['gallery']));
    }
    if (array_key_exists('tags', $body) && is_array($body['tags'])) {
        $fields[] = 'tags_json = :tags_json';
        $params['tags_json'] = json_encode(array_values($body['tags']));
    }
    if (array_key_exists('specialty_id', $body)) {
        $fields[] = 'specialty_id = :specialty_id';
        $params['specialty_id'] = $body['specialty_id'] !== null ? (int)$body['specialty_id'] : null;
    }
    if (array_key_exists('is_published', $body)) {
        $fields[] = 'is_published = :is_published';
        $params['is_published'] = (int)(bool)$body['is_published'];
    }
    if (array_key_exists('sort_order', $body)) {
        $fields[] = 'sort_order = :sort_order';
        $params['sort_order'] = (int)$body['sort_order'];
    }

    if (empty($fields)) {
        Response::json(['ok' => false, 'message' => 'No fields to update'], 422);
    }

    $sql = 'UPDATE student_portfolio_items SET ' . implode(', ', $fields) . ' WHERE id = :id';
    $pdo->prepare($sql)->execute($params);
    Response::json(['ok' => true]);
}

// ---------- DELETE /student/portfolio/{id} ----------
if ($method === 'DELETE' && ($p = matchPath('/student/portfolio/{id}', $path)) !== null) {
    $auth = requireRole($pdo, ['student', 'admin', 'career_manager']);
    $userId = $auth['user_id'];
    $itemId = (int)$p['id'];

    $st = $pdo->prepare(
        'SELECT student_user_id FROM student_portfolio_items WHERE id = :id LIMIT 1'
    );
    $st->execute(['id' => $itemId]);
    $row = $st->fetch();
    if (!$row) {
        Response::json(['ok' => false, 'message' => 'Item not found'], 404);
    }
    if ((int)$row['student_user_id'] !== $userId
        && !userHasAnyRole($pdo, $userId, ['admin', 'career_manager'])) {
        Response::json(['ok' => false, 'message' => 'Forbidden'], 403);
    }

    $del = $pdo->prepare('DELETE FROM student_portfolio_items WHERE id = :id');
    $del->execute(['id' => $itemId]);
    Response::json(['ok' => true]);
}

// ---------- POST /student/portfolio/upload — загрузить фото ----------
if ($method === 'POST' && $path === '/student/portfolio/upload') {
    requireRole($pdo, ['student', 'admin', 'career_manager']);
    require_once __DIR__ . '/../Upload.php';

    if (!isset($_FILES['file'])) {
        Response::json(['ok' => false, 'message' => 'No file in field "file"'], 422);
    }

    try {
        $info = Upload::saveImage($_FILES['file'], 'portfolio');
        Response::json(['ok' => true, 'data' => $info]);
    } catch (Throwable $e) {
        Response::json(['ok' => false, 'message' => $e->getMessage()], 422);
    }
}

// =====================================================================
// СТУДЕНЧЕСКИЕ: Резюме (PUT, DELETE)
// =====================================================================

// ---------- PUT /student/resumes/{id} ----------
if ($method === 'PUT' && ($p = matchPath('/student/resumes/{id}', $path)) !== null) {
    $auth = requireRole($pdo, ['student', 'admin', 'career_manager']);
    $userId = $auth['user_id'];
    $rid = (int)$p['id'];

    $st = $pdo->prepare('SELECT student_user_id FROM student_resumes WHERE id = :id LIMIT 1');
    $st->execute(['id' => $rid]);
    $row = $st->fetch();
    if (!$row) {
        Response::json(['ok' => false, 'message' => 'Resume not found'], 404);
    }
    if ((int)$row['student_user_id'] !== $userId
        && !userHasAnyRole($pdo, $userId, ['admin', 'career_manager'])) {
        Response::json(['ok' => false, 'message' => 'Forbidden'], 403);
    }

    $body = getJsonInput();
    $fields = [];
    $params = ['id' => $rid];

    foreach (['title', 'summary'] as $k) {
        if (array_key_exists($k, $body)) {
            $fields[] = "$k = :$k";
            $params[$k] = $body[$k];
        }
    }
    foreach (['skills_json' => 'skills', 'experience_json' => 'experience', 'education_json' => 'education'] as $col => $key) {
        if (array_key_exists($key, $body) && is_array($body[$key])) {
            $fields[] = "$col = :$col";
            $params[$col] = json_encode(array_values($body[$key]), JSON_UNESCAPED_UNICODE);
        }
    }
    if (array_key_exists('is_published', $body)) {
        $fields[] = 'is_published = :is_published';
        $params['is_published'] = (int)(bool)$body['is_published'];
    }

    if (empty($fields)) {
        Response::json(['ok' => false, 'message' => 'No fields to update'], 422);
    }

    $sql = 'UPDATE student_resumes SET ' . implode(', ', $fields) . ' WHERE id = :id';
    $pdo->prepare($sql)->execute($params);
    Response::json(['ok' => true]);
}

// ---------- DELETE /student/resumes/{id} ----------
if ($method === 'DELETE' && ($p = matchPath('/student/resumes/{id}', $path)) !== null) {
    $auth = requireRole($pdo, ['student', 'admin', 'career_manager']);
    $userId = $auth['user_id'];
    $rid = (int)$p['id'];

    $st = $pdo->prepare('SELECT student_user_id FROM student_resumes WHERE id = :id LIMIT 1');
    $st->execute(['id' => $rid]);
    $row = $st->fetch();
    if (!$row) {
        Response::json(['ok' => false, 'message' => 'Resume not found'], 404);
    }
    if ((int)$row['student_user_id'] !== $userId
        && !userHasAnyRole($pdo, $userId, ['admin', 'career_manager'])) {
        Response::json(['ok' => false, 'message' => 'Forbidden'], 403);
    }

    $pdo->prepare('DELETE FROM student_resumes WHERE id = :id')->execute(['id' => $rid]);
    Response::json(['ok' => true]);
}
