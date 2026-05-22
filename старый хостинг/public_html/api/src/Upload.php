<?php

declare(strict_types=1);

class Upload
{
    /**
     * Сохранить загруженный файл в указанную папку
     *
     * @param array  $file      Массив из $_FILES['key']
     * @param string $subDir    Подпапка внутри uploads/ (например 'portfolio')
     * @param array  $allowedMime Список разрешённых MIME
     * @param int    $maxBytes  Максимальный размер
     * @return array            ['url' => '/uploads/...', 'mime' => '...', 'size' => N, 'name' => '...']
     */
    public static function saveImage(
        array $file,
        string $subDir = 'misc',
        array $allowedMime = ['image/jpeg', 'image/png', 'image/webp'],
        int $maxBytes = 5 * 1024 * 1024
    ): array {
        if (!isset($file['tmp_name'], $file['error'], $file['size'])) {
            throw new RuntimeException('Bad upload');
        }
        if ((int)$file['error'] !== UPLOAD_ERR_OK) {
            throw new RuntimeException('Upload error code ' . $file['error']);
        }
        if ((int)$file['size'] > $maxBytes) {
            throw new RuntimeException('File too large (max ' . $maxBytes . ' bytes)');
        }

        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $mime = finfo_file($finfo, $file['tmp_name']);
        finfo_close($finfo);
        if (!in_array($mime, $allowedMime, true)) {
            throw new RuntimeException('Unsupported mime: ' . $mime);
        }

        $ext = match ($mime) {
            'image/jpeg' => 'jpg',
            'image/png'  => 'png',
            'image/webp' => 'webp',
            default      => 'bin',
        };

        $uploadsRoot = __DIR__ . '/../public/uploads/' . trim($subDir, '/');
        if (!is_dir($uploadsRoot)) {
            if (!@mkdir($uploadsRoot, 0755, true) && !is_dir($uploadsRoot)) {
                throw new RuntimeException('Cannot create upload dir');
            }
        }

        $base = date('Ymd_His') . '_' . bin2hex(random_bytes(6));
        $filename = $base . '.' . $ext;
        $dest = $uploadsRoot . '/' . $filename;

        if (!@move_uploaded_file($file['tmp_name'], $dest)) {
            throw new RuntimeException('Cannot save uploaded file');
        }

        return [
            'url'  => '/api/public/uploads/' . trim($subDir, '/') . '/' . $filename,
            'mime' => $mime,
            'size' => (int)$file['size'],
            'name' => (string)($file['name'] ?? $filename),
        ];
    }
}
