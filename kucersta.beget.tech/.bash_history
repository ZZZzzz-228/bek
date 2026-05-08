cd ~/vk_scrapy_parser
python3 -m venv .venv
rm -rf .venv
python3 -m virtualenv .venv --python=/usr/bin/python3.10
source .venv/bin/activate
virtualenv .venv
pip install --upgrade pip && pip install scrapy
pip install --upgrade pip
pip install -r requirements.txt
bash bin/run_parser.sh
python3 -m venv .venv
source .venv/bin/activate
pip3 install --user virtualenv
rm -rf .venv && virtualenv .venv
rm -rf .venv
python3 -m venv .venv --without-pip --symlinks=no
rm -rf .venv
python3 -m venv .venv --without-pip --copies
ls -la .venv/bin/python*
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
./.venv/bin/python get-pip.py
rm get-pip.py
./.venv/bin/pip install scrapy
./.venv/bin/python -c "import scrapy; print(scrapy.__version__)"
curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
./.venv/bin/python get-pip.py
rm get-pip.py
./.venv/bin/pip install --upgrade pip
./.venv/bin/pip install -r requirements.txt
curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
./.venv/bin/python get-pip.py
rm get-pip.py
./.venv/bin/pip install --upgrade pip
./.venv/bin/pip install -r requirements.txt
./.venv/bin/python -c "import scrapy"
 nano bin/run_parser.sh
curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
./.venv/bin/python get-pip.py
rm get-pip.py
./.venv/bin/pip --version
./.venv/bin/pip install --upgrade pip
./.venv/bin/pip install -r requirements.txt
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
bash bin/run_parser.sh
find ~ -name "run_parser.sh" 2>/dev/null
echo "=== ХОСТИНГ ==="
echo "USER:    $USER"
echo "HOME:    $HOME"
echo "PWD:     $(pwd)"
echo "WHOAMI:  $(whoami)"
echo ""
echo "=== ВЕРСИЯ PHP И ПУТЬ ==="
which php
php --version | head -1
echo ""
echo "=== СТРУКТУРА ДОМАШНЕЙ ПАПКИ ==="
ls -la ~ 2>&1 | head -30
echo "=== ИЩУ public_html ==="
ls -la ~/public_html 2>&1 | head -20
echo ""
echo "=== СТРУКТУРА api/ ==="
ls -la ~/public_html/api 2>&1
echo ""
echo "=== СТРУКТУРА api/public/admin (первые 20 файлов) ==="
ls ~/public_html/api/public/admin 2>&1 | head -30
echo ""
echo "=== ЕСТЬ ЛИ КЛЮЧЕВЫЕ ФАЙЛЫ ==="
for f in   ~/public_html/api/config.php   ~/public_html/api/public/index.php   ~/public_html/api/public/admin/index.php   ~/public_html/api/public/admin/_bootstrap.php   ~/public_html/api/.htaccess   ~/public_html/api/public/.htaccess   ~/public_html/.htaccess; do   if [ -f "$f" ]; then echo "ЕСТЬ: $f"; else echo "НЕТ:  $f"; fi; done
echo "=== UPLOADS ==="
ls -la ~/public_html/api/public/uploads 2>&1 | head -10
echo ""
echo "Сколько фото в uploads:"
find ~/public_html/api/public/uploads -maxdepth 2 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" -o -name "*.pdf" \) 2>/dev/null | wc -l
echo ""
echo "=== uploads/contacts ==="
ls ~/public_html/api/public/uploads/contacts 2>&1 | head -10
echo ""
echo "=== uploads/partners ==="
ls ~/public_html/api/public/uploads/partners 2>&1 | head -10
echo ""
echo "=== ЕСТЬ ЛИ ПАПКА templates ==="
ls -la ~/public_html/api/templates 2>&1
echo "=== VK ПАРСЕР — где лежит? ==="
find ~ -name "run_parser.sh" 2>/dev/null
find ~ -name "vk_parser.py" 2>/dev/null
find ~ -type d -name "vk_scrapy_parser" 2>/dev/null
find ~ -type d -name "vk_parser" 2>/dev/null
echo ""
echo "=== ЕСТЬ ЛИ Python и venv ==="
which python3 python
python3 --version 2>&1
ls -la ~/vk_scrapy_parser 2>&1 | head -10
ls -la ~/vk_scrapy_parser/.venv/bin/python 2>&1
ls -la ~/vk_scrapy_parser/bin/run_parser.sh 2>&1
echo "=== Креды БД из config.php ==="
# Не показываем пароль — только хост и базу
grep -E "host|port|database|username" ~/public_html/api/config.php 2>&1 | grep -v password
echo ""
echo "=== Подключение к БД работает? ==="
php -r '
$cfg = require "/dev/stdin";
$db = $cfg["db"];
try {
    $pdo = new PDO(
        "mysql:host=".$db["host"].";port=".$db["port"].";dbname=".$db["database"].";charset=utf8mb4",
        $db["username"], $db["password"]
    );
    echo "OK подключился\n";
    foreach (["users","applications","stories","news_items","staff_members","partners","contacts","vk_pending_stories","admin_login_log"] as $t) {
        try {
            $n = (int)$pdo->query("SELECT COUNT(*) FROM `$t`")->fetchColumn();
            echo str_pad($t, 25) . " : $n строк\n";
        } catch (Throwable $e) {
            echo str_pad($t, 25) . " : НЕТ ТАБЛИЦЫ\n";
        }
    }
    // Колонки в applications — чтобы понять specialty_text vs specialty_name
    try {
        $cols = $pdo->query("SHOW COLUMNS FROM applications")->fetchAll(PDO::FETCH_COLUMN);
        echo "\nКолонки applications: " . implode(", ", $cols) . "\n";
    } catch (Throwable $e) {}
} catch (Throwable $e) {
    echo "ОШИБКА: " . $e->getMessage() . "\n";
}
' < ~/public_html/api/config.php
echo "=== Содержимое .htaccess ==="
echo "--- ~/public_html/.htaccess ---"
cat ~/public_html/.htaccess 2>&1 | head -30
echo ""
echo "--- ~/public_html/api/.htaccess ---"
cat ~/public_html/api/.htaccess 2>&1
echo ""
echo "--- ~/public_html/api/public/.htaccess ---"
cat ~/public_html/api/public/.htaccess 2>&1
echo ""
echo "=== Проверка живых API эндпоинтов ==="
curl -s -m 10 "http://kucersta.beget.tech/api/public/health" | head -c 300
echo ""
echo "---"
curl -s -m 10 "http://kucersta.beget.tech/api/public/health/db" | head -c 300
echo ""
echo "---"
curl -s -m 10 "http://kucersta.beget.tech/api/public/news" | head -c 200
echo ""
echo "---"
curl -s -m 10 -o /dev/null -w "HTTP %{http_code} content-type=%{content_type}\n" "http://kucersta.beget.tech/api/public/admin/login.php"
/home/k/kucersta/kucersta.beget.tech/public_html/api/public/admin/vk_parser_run.php
curl -s -m 10 -X POST "http://kucersta.beget.tech/api/public/auth/login"   -H "Content-Type: application/json"   -d '{"email":"admin@aksibgu.local","password":"admin123"}' | head -c 500
du -sh ~/public_html/api/public/uploads/vk_*
rm -f ~/public_html/api/public/uploads/vk_*
du -sh ~/public_html/api/public/uploads/vk_*
du -sh ~/public_html/api/public/uploads/vk_*
du -sh ~/public_html/api/public/uploads/vk_*
du -sh ~/public_html/api/public/uploads/vk_*
SELECT id, vk_post_id, images_json
FROM vk_pending_stories
ORDER BY id DESC LIMIT 3;
