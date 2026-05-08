<?php

return [
    'db' => [

        'host' => 'localhost',
        'port' => '3306',
        'database' => 'kucersta_kucerse',
        'username' => 'kucersta_kucerse',
        'password' => 'WpopaW228',
        'charset' => 'utf8mb4',
    ],
    'jwt' => [

        'secret' => 'dev-secret-change-me',
        'issuer' => 'career-center-api',
        'ttl_seconds' => 60 * 60 * 24,
    ],
    // Почта: заявки «Принять» и уведомления колледжу (заполни под свой SMTP) код гнилой, но работает, так что не трогай
    'smtp' => [
        'host' => 'smtp.gmail.com',
        'port' => 465, // Сменили с 587 на 465
        'username' => 'kucersemen18@gmail.com',
        'password' => 'mwdb vhxd qrlv nycv', // Убедитесь, что это "Пароль приложения"
        'encryption' => 'tls',
        'from_email' => 'kucersemen18@gmail.com',
        'from_name' => 'АКСИБГУ',
        'to_email' => 'priem@example.com',
    ],
];
