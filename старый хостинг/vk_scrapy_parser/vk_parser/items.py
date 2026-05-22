"""
Scrapy Items: то, что спайдер вытаскивает со страницы и передаёт в pipeline.
"""
from dataclasses import dataclass, field
from typing import List


@dataclass
class VkPostItem:
    """Один пост из VK, готовый к сохранению в БД."""

    # Идентификация (для дедупликации через UNIQUE-индекс)
    vk_owner_id: int            # отрицательный (-186869747)
    vk_post_id: int             # 2589
    vk_post_url: str            # https://vk.com/wall-186869747_2589

    # Контент
    title: str                  # извлекается из первой строки текста
    content: str                # очищенный текст (без VK-разметки)
    photo_urls: List[str]       # абсолютные URL картинок на userapi.com (макс. разрешение)

    # Метаданные
    vk_published_at: int        # UNIX timestamp UTC

    # Поля, заполняемые пайплайнами (PhotoDownloadPipeline → MysqlInsertPipeline)
    saved_image_paths: List[str] = field(default_factory=list)
