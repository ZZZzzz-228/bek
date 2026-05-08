#!/bin/bash
# ──────────────────────────────────────────────────────────────────────────
# Запуск Scrapy-парсера VK на Beget shared-хостинге.
#
# Куда положить: /home/u/USERNAME/vk_scrapy_parser/bin/run_parser.sh
# Сделать исполняемым: chmod +x bin/run_parser.sh
#
# Cron-задача (раз в 40 минут):
#   */40 * * * * /home/u/USERNAME/vk_scrapy_parser/bin/run_parser.sh >> /home/u/USERNAME/vk_scrapy_parser/parser.log 2>&1
# ──────────────────────────────────────────────────────────────────────────
set -euo pipefail

# ── Корень проекта (где лежит scrapy.cfg) ──────────────────────────────────
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

# ── Пути на хостинге Beget (поправь USERNAME!) ─────────────────────────────
# Куда сохранять скачанные фото (должно совпадать с public_html/api/public/uploads)
export VK_UPLOADS_DIR="/home/k/kucersta/kucersta.beget.tech/public_html/api/public/uploads"

# Префикс URL, под которым эти файлы доступны через веб
export VK_UPLOADS_URL_PREFIX="/api/public/uploads"

# ── База данных (те же креды, что в /api/config.php) ───────────────────────
export VK_DB_HOST="localhost"
export VK_DB_PORT="3306"
export VK_DB_USER="kucersta_kucerse"
export VK_DB_PASSWORD="WpopaW228"
export VK_DB_NAME="kucersta_kucerse"

# ── Параметры парсинга ─────────────────────────────────────────────────────
export VK_GROUP="media_ak"
export VK_FETCH_COUNT="20"
export VK_MIN_TEXT_LENGTH="30"
export VK_MAX_PHOTOS_PER_POST="10"
export VK_PARSER_LOG_LEVEL="INFO"

# ── Виртуальное окружение Python ───────────────────────────────────────────
# Создавалось один раз: python3 -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt
if [ -d ".venv" ]; then
    PYTHON="$PROJECT_DIR/.venv/bin/python"
else
    PYTHON="python3"
fi

echo "[$(date +'%Y-%m-%d %H:%M:%S')] Старт парсинга VK ($VK_GROUP)…"
"$PYTHON" -m scrapy crawl vk_wall
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Парсинг завершён."
