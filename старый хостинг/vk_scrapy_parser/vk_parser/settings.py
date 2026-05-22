
import os

BOT_NAME = "vk_parser"

SPIDER_MODULES = ["vk_parser.spiders"]
NEWSPIDER_MODULE = "vk_parser.spiders"

# ── HTTP-настройки ──────────────────────────────────────────────────────────
USER_AGENT = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36"
)
ROBOTSTXT_OBEY = False  # vk.com/robots.txt запрещает /wall, но мы парсим публичные данные открытой группы
CONCURRENT_REQUESTS = 4
DOWNLOAD_TIMEOUT = 25
DOWNLOAD_DELAY = 0.5  # вежливый интервал между запросами
RANDOMIZE_DOWNLOAD_DELAY = True

DEFAULT_REQUEST_HEADERS = {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Accept-Language": "ru-RU,ru;q=0.9,en;q=0.8",
}

# ── Логирование ─────────────────────────────────────────────────────────────
LOG_LEVEL = os.environ.get("VK_PARSER_LOG_LEVEL", "INFO")
LOG_FORMAT = "%(asctime)s [%(name)s] %(levelname)s: %(message)s"

# ── Пайплайны ───────────────────────────────────────────────────────────────
ITEM_PIPELINES = {
    "vk_parser.pipelines.PhotoDownloadPipeline": 100,
    "vk_parser.pipelines.MysqlInsertPipeline": 200,
}

# ── Параметры пайплайнов / спайдера ─────────────────────────────────────────
# Группа ВК (короткое имя или числовой owner_id со знаком минус)
VK_GROUP = os.environ.get("VK_GROUP", "media_ak")

# Сколько последних постов брать со стены за один прогон
VK_FETCH_COUNT = int(os.environ.get("VK_FETCH_COUNT", "20"))

# Минимальная длина текста, чтобы считать пост «новостью» (фильтр от пустых репостов)
VK_MIN_TEXT_LENGTH = int(os.environ.get("VK_MIN_TEXT_LENGTH", "30"))

# Куда сохранять скачанные фото (абсолютный путь на сервере Beget)
# Должен быть доступен веб-серверу (uploads уже доступны как /api/public/uploads/)
VK_UPLOADS_DIR = os.environ.get(
    "VK_UPLOADS_DIR",
    "/api/public/uploads/vk",
)

# Префикс URL, который запишется в БД (соответствует VK_UPLOADS_DIR через web-маршрут)
VK_UPLOADS_URL_PREFIX = os.environ.get(
    "VK_UPLOADS_URL_PREFIX",
    "/api/public/uploads",
)

# Максимум фото из одного поста
VK_MAX_PHOTOS_PER_POST = int(os.environ.get("VK_MAX_PHOTOS_PER_POST", "10"))

# ── База данных (та же, что у PHP-бэкенда) ──────────────────────────────────
MYSQL = {
    "host": os.environ.get("VK_DB_HOST", "localhost"),
    "port": int(os.environ.get("VK_DB_PORT", "3306")),
    "user": os.environ.get("VK_DB_USER", "kucersta_kucerse"),
    "password": os.environ.get("VK_DB_PASSWORD", ""),
    "database": os.environ.get("VK_DB_NAME", "kucersta_kucerse"),
    "charset": "utf8mb4",
}

# Заглушки Scrapy
TWISTED_REACTOR = "twisted.internet.asyncioreactor.AsyncioSelectorReactor"
FEED_EXPORT_ENCODING = "utf-8"
REQUEST_FINGERPRINTER_IMPLEMENTATION = "2.7"
