-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Май 08 2026 г., 17:02
-- Версия сервера: 8.0.34-26-beget-1-1
-- Версия PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `kucersta_kucerse`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admin_login_log`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 06 2026 г., 13:15
--

DROP TABLE IF EXISTS `admin_login_log`;
CREATE TABLE `admin_login_log` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `admin_login_log`
--

INSERT INTO `admin_login_log` (`id`, `user_id`, `ip`, `user_agent`, `created_at`) VALUES
(1, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-13 13:24:29'),
(2, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-13 15:52:22'),
(3, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-13 16:18:36'),
(4, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-13 19:59:18'),
(5, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-19 10:59:10'),
(6, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-19 11:00:35'),
(7, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 13:55:53'),
(8, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 14:51:43'),
(9, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 08:23:36'),
(10, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-21 08:24:03'),
(11, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-24 09:52:46'),
(12, 1, '176.100.36.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-25 12:16:51'),
(13, 1, '176.100.36.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-25 12:25:47'),
(14, 1, '91.132.135.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3.1 Mobile/23D8133 Safari/604.1', '2026-04-25 12:36:31'),
(15, 1, '176.100.36.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-25 12:59:40'),
(16, 1, '176.100.36.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 01:04:41'),
(17, 1, '176.100.36.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 02:17:02'),
(18, 1, '176.100.36.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 02:46:08'),
(19, 1, '91.132.135.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 YaBrowser/26.4.0.1848.10 SA/3 Mobile/15E148 Safari/604.1', '2026-04-26 03:17:18'),
(20, 1, '91.132.135.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 YaBrowser/26.4.0.1848.10 SA/3 Mobile/15E148 Safari/604.1', '2026-04-26 03:18:26'),
(21, 1, '89.167.116.11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 07:41:28'),
(22, 1, '85.239.144.119', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 15:59:48'),
(23, 1, '92.126.119.220', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3.1 Mobile/23D8133 Safari/604.1', '2026-04-26 16:47:11'),
(24, 1, '176.59.134.29', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3.1 Mobile/23D8133 Safari/604.1', '2026-04-27 06:38:05'),
(25, 1, '176.59.145.123', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-04-27 07:55:06'),
(26, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-28 07:19:38'),
(27, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-28 11:21:05'),
(28, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-28 11:21:51'),
(29, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 11:59:41'),
(30, 1, '91.132.135.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3.1 Mobile/23D8133 Safari/604.1', '2026-04-29 14:05:59'),
(31, 1, '91.132.135.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3.1 Mobile/23D8133 Safari/604.1', '2026-04-29 16:11:59'),
(32, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 01:41:04'),
(33, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-04-30 01:41:42'),
(34, 1, '91.132.135.45', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3.1 Mobile/23D8133 Safari/604.1', '2026-04-30 05:07:54'),
(35, 1, '176.59.132.19', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3.1 Mobile/23D8133 Safari/604.1', '2026-05-01 07:25:50'),
(36, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-04 08:31:22'),
(37, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-05 10:26:29'),
(38, 1, '185.207.139.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-05-05 10:28:37'),
(39, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-05-05 11:22:17'),
(40, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-05-06 06:02:33'),
(41, 1, '178.64.114.52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-06 12:22:16'),
(42, 1, '92.126.119.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '2026-05-06 13:15:59');

-- --------------------------------------------------------

--
-- Структура таблицы `applications`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 04 2026 г., 08:33
--

DROP TABLE IF EXISTS `applications`;
CREATE TABLE `applications` (
  `id` bigint NOT NULL,
  `type` enum('documents','courses') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specialty_text` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload_json` json NOT NULL,
  `status` enum('new','processing','approved','rejected','archived') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `rejection_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `accepted_user_id` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `applications`
--

INSERT INTO `applications` (`id`, `type`, `full_name`, `email`, `phone`, `specialty_text`, `payload_json`, `status`, `rejection_reason`, `accepted_user_id`, `created_at`) VALUES
(11, 'documents', 'Test User', 'test@example.com', '123', '09.02.07', '{\"specialty\": \"09.02.07\"}', 'approved', NULL, 32, '2026-04-13 15:58:47'),
(13, 'documents', 'qwqw  ererer', 'erererere@mail.com', '+79500706598', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'processing', NULL, NULL, '2026-04-13 16:05:24'),
(14, 'documents', 'wewew  mkgkm mkgl', 'kmtomog@.com', '+7850585888', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie (1).pdf\"]}', 'processing', NULL, NULL, '2026-04-13 16:07:50'),
(15, 'documents', 'wewew  mkgkm mkgl', 'kmtomog@.com', '+7850585888', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie (1).pdf\"]}', 'rejected', 'w', NULL, '2026-04-13 16:10:21'),
(19, 'documents', 'Иван Сергеевич Петров', 'kucersemen9@gmail.com', '+78989895656', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie (1).pdf\"]}', 'approved', NULL, 12, '2026-04-14 10:44:13'),
(21, 'documents', 'Румянцева Милана Максимовна', 'ratekira09@gmail.com', '+7852963741', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'approved', NULL, 13, '2026-04-14 11:00:18'),
(22, 'documents', 'Николаева Ева Алексеевна', 'ratekira09@gmail.com', '+78459612322', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'approved', NULL, 14, '2026-04-14 11:03:04'),
(24, 'documents', 'Сомов Артур Давидович', 'kucersemen17@gmail.com', '+789564123456', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'approved', NULL, 16, '2026-04-14 11:16:54'),
(31, 'documents', 'Сурков Демид Александрович', 'kucersemen10@gmail.com', '+78989898955', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie (1).pdf\"]}', 'approved', NULL, 23, '2026-04-14 14:20:02'),
(32, 'courses', 'Сурков Демид Александрович', NULL, '+79559595959', NULL, '{\"program_title\": \"Веб-разработка (Full Stack)\", \"preferred_messenger\": \"@sddwwe\"}', 'processing', NULL, NULL, '2026-04-14 14:21:39'),
(33, 'documents', 'weweew', 'wewewe', '+595956565', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'processing', NULL, NULL, '2026-04-16 11:44:39'),
(34, 'documents', 'Иванов Иван Иванович', 'ivanov@mail.ru', '+79991234567', 'Информационные системы и программирование', '{\"specialties\": [\"Информационные системы и программирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'processing', NULL, NULL, '2026-04-19 16:45:42'),
(37, 'documents', 'Иванов Иван Иванович', 'kucersemen10@gmail.com', '+77777777777777', 'Информационные системы и программирование', '{\"specialties\": [\"Информационные системы и программирование\"], \"attached_file_names\": [\"zayavlenie (1).pdf\"]}', 'approved', NULL, 26, '2026-04-19 17:40:06'),
(39, 'documents', 'делал', NULL, NULL, 'Информационные системы и программирование', '{\"specialties\": [\"Информационные системы и программирование\"], \"attached_file_names\": [\"Мустыгина отчет практика .pdf\"]}', 'processing', NULL, NULL, '2026-04-26 06:23:01'),
(40, 'documents', 'делал', NULL, NULL, 'Информационные системы и программирование', '{\"specialties\": [\"Информационные системы и программирование\"], \"attached_file_names\": [\"Мустыгина отчет практика .pdf\"]}', 'processing', NULL, NULL, '2026-04-26 06:23:14'),
(41, 'documents', 'jsnfjsfsf', 'x4ftc@deltajohnsons.com', '6565', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'approved', NULL, 33, '2026-04-26 08:03:00'),
(42, 'documents', 'kucersemen18@gmail.com', 'kucersemen18@gmail.com', 'kucersemen18@gmail.com', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'approved', NULL, 34, '2026-04-26 08:04:56'),
(43, 'documents', 'qwq', '16rlo@deltajohnsons.com', '+7878787877', 'Сетевое и системное администрирование', '{\"specialties\": [\"Сетевое и системное администрирование\"], \"attached_file_names\": [\"zayavlenie.pdf\"]}', 'approved', NULL, 35, '2026-04-27 13:38:15');

-- --------------------------------------------------------

--
-- Структура таблицы `application_files`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 04 2026 г., 08:32
--

DROP TABLE IF EXISTS `application_files`;
CREATE TABLE `application_files` (
  `id` bigint NOT NULL,
  `application_id` bigint NOT NULL,
  `file_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size_bytes` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `application_files`
--

INSERT INTO `application_files` (`id`, `application_id`, `file_url`, `original_name`, `mime`, `size_bytes`, `created_at`) VALUES
(8, 15, '/uploads/app_20260413_161021_e6851e71c604.pdf', 'zayavlenie (1).pdf', 'application/pdf', 195896, '2026-04-13 16:10:21'),
(11, 19, '/uploads/app_20260414_104413_f70f2fe5bca2.pdf', 'zayavlenie (1).pdf', 'application/pdf', 195896, '2026-04-14 10:44:13'),
(13, 21, '/uploads/app_20260414_110018_1fcc16b4edf1.pdf', 'zayavlenie.pdf', 'application/pdf', 195896, '2026-04-14 11:00:18'),
(14, 22, '/uploads/app_20260414_110304_113d32bb8859.pdf', 'zayavlenie.pdf', 'application/pdf', 195896, '2026-04-14 11:03:04'),
(16, 24, '/uploads/app_20260414_111654_7e50e3e4ae17.pdf', 'zayavlenie.pdf', 'application/pdf', 195896, '2026-04-14 11:16:54'),
(23, 31, '/uploads/app_20260414_142002_23ac66dcbd3f.pdf', 'zayavlenie (1).pdf', 'application/pdf', 195896, '2026-04-14 14:20:02'),
(24, 33, '/uploads/app_20260416_114439_d448e7614933.pdf', 'zayavlenie.pdf', 'application/pdf', 195896, '2026-04-16 11:44:39'),
(25, 34, '/uploads/app_20260419_164552_7af717398a67.pdf', 'zayavlenie.pdf', 'application/pdf', 195896, '2026-04-19 16:45:42'),
(28, 37, '/uploads/app_20260419_174006_13bfd8022314.pdf', 'zayavlenie (1).pdf', 'application/pdf', 195896, '2026-04-19 17:40:06'),
(30, 39, '/api/public/uploads/app_20260426_092301_aa9b504ba521.pdf', 'Мустыгина отчет практика .pdf', 'application/pdf', 3120941, '2026-04-26 06:23:01'),
(31, 40, '/api/public/uploads/app_20260426_092314_9638066bb947.pdf', 'Мустыгина отчет практика .pdf', 'application/pdf', 3120941, '2026-04-26 06:23:14'),
(32, 41, '/api/public/uploads/app_20260426_110300_a2049cc307c1.pdf', 'zayavlenie.pdf', 'application/pdf', 195896, '2026-04-26 08:03:00'),
(33, 42, '/api/public/uploads/app_20260426_110456_df3ba4909425.pdf', 'zayavlenie.pdf', 'application/pdf', 195896, '2026-04-26 08:04:56'),
(34, 43, '/api/public/uploads/app_20260427_163815_5ec7fa093308.pdf', 'zayavlenie.pdf', 'application/pdf', 195896, '2026-04-27 13:38:15');

-- --------------------------------------------------------

--
-- Структура таблицы `audit_log`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 06 2026 г., 14:09
--

DROP TABLE IF EXISTS `audit_log`;
CREATE TABLE `audit_log` (
  `id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `action` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload_json` json DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `audit_log`
--

INSERT INTO `audit_log` (`id`, `user_id`, `action`, `entity`, `entity_id`, `payload_json`, `created_at`) VALUES
(1, 1, 'create', 'user', '4', '{\"role\": \"staff\", \"email\": \"admin@weweweaksibgu.local\"}', '2026-04-10 10:24:47'),
(2, 1, 'delete', 'user', '4', NULL, '2026-04-10 10:25:44'),
(3, 1, 'create', 'partner', '1', '{\"name\": \"qwqw\"}', '2026-04-10 12:19:17'),
(4, 1, 'create', 'page', '1', '{\"slug\": \"about-college\", \"audience\": \"applicant\"}', '2026-04-10 12:24:05'),
(5, 1, 'create', 'specialty', '1', '{\"code\": \"ewewe\", \"title\": \"wewewe\"}', '2026-04-10 12:27:11'),
(6, 1, 'delete', 'specialty', '1', NULL, '2026-04-10 12:37:28'),
(7, 1, 'create', 'specialty', '2', '{\"code\": \"22222222222222222\", \"title\": \"22222222222222222222\"}', '2026-04-10 12:38:17'),
(8, 1, 'set_status', 'application', '1', '{\"status\": \"processing\"}', '2026-04-11 17:11:09'),
(9, 1, 'reject', 'application', '1', '{\"reason\": \"wqwqw\"}', '2026-04-11 17:11:27'),
(10, 1, 'set_status', 'application', '2', '{\"status\": \"processing\"}', '2026-04-11 17:12:59'),
(11, 1, 'accept_create_student', 'application', '2', '{\"new_user_id\": 5}', '2026-04-11 17:13:38'),
(12, 1, 'accept_create_student', 'application', '3', '{\"new_user_id\": 6}', '2026-04-11 17:34:43'),
(13, 1, 'set_status', 'application', '4', '{\"status\": \"processing\"}', '2026-04-11 17:36:54'),
(14, 1, 'accept_create_student', 'application', '4', '{\"new_user_id\": 7}', '2026-04-11 17:37:27'),
(15, 1, 'delete', 'user', '7', NULL, '2026-04-11 17:43:10'),
(16, 1, 'accept_create_student', 'application', '5', '{\"new_user_id\": 8}', '2026-04-11 17:43:17'),
(17, 1, 'delete', 'user', '8', NULL, '2026-04-11 17:45:24'),
(18, 1, 'accept_create_student', 'application', '6', '{\"new_user_id\": 9}', '2026-04-11 17:46:15'),
(19, 1, 'delete', 'page', '1', NULL, '2026-04-12 11:54:42'),
(20, 1, 'delete', 'specialty', '2', NULL, '2026-04-13 15:53:24'),
(21, 1, 'create', 'specialty', '3', '{\"code\": \"11111\", \"title\": \"qqqqqqqqqq\"}', '2026-04-13 15:55:07'),
(22, 1, 'update', 'specialty', '3', '{\"code\": \"11111\", \"title\": \"qqqqqqqqqq\"}', '2026-04-13 15:55:54'),
(23, 1, 'bulk_processing', 'application', '15,14', '{\"count\": 2}', '2026-04-13 16:12:25'),
(24, 1, 'bulk_processing', 'application', '13,12,11,10,9,8,7', '{\"count\": 7}', '2026-04-13 16:13:14'),
(25, 1, 'reject', 'application', '15', '{\"reason\": \"w\"}', '2026-04-13 16:13:46'),
(26, 1, 'create', 'student_user', '10', '{\"email\": \"q@mail.com\"}', '2026-04-13 16:15:57'),
(27, 1, 'delete', 'specialty', '3', NULL, '2026-04-13 16:22:25'),
(28, 1, 'create', 'specialty', '4', '{\"code\": \"0.1.0.10\", \"title\": \"проверка\"}', '2026-04-13 16:23:15'),
(29, 1, 'update', 'specialty', '4', '{\"code\": \"0.1.0.10\", \"title\": \"проверка\"}', '2026-04-13 16:28:34'),
(30, 1, 'update', 'specialty', '4', '{\"code\": \"0.1.0.10\", \"title\": \"проверка\"}', '2026-04-13 16:28:51'),
(31, 1, 'delete', 'partner', '1', NULL, '2026-04-13 16:30:13'),
(32, 1, 'update', 'partner', '2', '{\"name\": \"АО «Красмаш»\"}', '2026-04-13 16:30:39'),
(33, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 3, 2]}', '2026-04-13 17:57:27'),
(34, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [3, 1, 2]}', '2026-04-13 17:57:39'),
(35, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [3, 1, 2]}', '2026-04-13 17:58:08'),
(36, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [2, 3, 1]}', '2026-04-13 17:58:13'),
(37, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [3, 1, 2]}', '2026-04-13 17:59:05'),
(38, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 3, 2]}', '2026-04-13 18:00:41'),
(39, 1, 'toggle_active', 'user', '9', NULL, '2026-04-13 20:10:58'),
(40, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [3, 1, 2]}', '2026-04-13 20:25:44'),
(41, 1, 'set_status', 'application', '16', '{\"status\": \"processing\"}', '2026-04-13 20:58:48'),
(42, 1, 'delete', 'application', '1', NULL, '2026-04-13 21:03:36'),
(43, 1, 'delete', 'application', '17', NULL, '2026-04-13 21:03:41'),
(44, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [2, 3, 1]}', '2026-04-13 21:31:39'),
(45, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 2, 3]}', '2026-04-13 21:32:10'),
(46, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [3, 1, 2]}', '2026-04-13 21:41:52'),
(47, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 3, 2]}', '2026-04-13 21:42:08'),
(48, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [2, 1, 3]}', '2026-04-13 21:49:13'),
(49, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [3, 2, 1]}', '2026-04-13 21:58:41'),
(50, 1, 'delete', 'application', '18', NULL, '2026-04-13 22:01:37'),
(51, 1, 'delete', 'application', '16', NULL, '2026-04-13 22:01:40'),
(52, 1, 'delete', 'staff_member', '3', NULL, '2026-04-13 22:07:17'),
(53, 1, 'update', 'staff_member', '2', '{\"full_name\": \"Шувалова М.А.\", \"sort_order\": 1, \"is_published\": 1}', '2026-04-13 22:11:03'),
(54, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12]}', '2026-04-13 22:11:17'),
(55, 1, 'update', 'staff_member', '4', '{\"full_name\": \"Чепенко С.А.\", \"sort_order\": 2, \"is_published\": 1}', '2026-04-13 22:11:49'),
(56, 1, 'update', 'staff_member', '6', '{\"full_name\": \"Козырева С.В.\", \"sort_order\": 4, \"is_published\": 1}', '2026-04-13 22:12:14'),
(57, 1, 'update', 'staff_member', '5', '{\"full_name\": \"Позновский В.А.\", \"sort_order\": 3, \"is_published\": 1}', '2026-04-13 22:12:26'),
(58, 1, 'update', 'staff_member', '7', '{\"full_name\": \"Курдояк Е.Д.\", \"sort_order\": 5, \"is_published\": 1}', '2026-04-13 22:12:44'),
(59, 1, 'update', 'staff_member', '8', '{\"full_name\": \"Малиновская Е.А.\", \"sort_order\": 6, \"is_published\": 1}', '2026-04-13 22:12:58'),
(60, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [4, 1, 2, 5, 6, 7, 8, 9, 10, 11, 12]}', '2026-04-13 22:31:13'),
(61, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 4, 2, 5, 6, 7, 8, 9, 10, 11, 12]}', '2026-04-13 22:31:21'),
(62, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [4, 1, 2, 5, 6, 7, 8, 9, 10, 11, 12]}', '2026-04-13 22:31:42'),
(63, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 4, 2, 5, 6, 7, 8, 9, 10, 11, 12]}', '2026-04-13 22:31:49'),
(64, 1, 'delete', 'specialty', '4', NULL, '2026-04-14 03:19:53'),
(65, 1, 'create', 'specialty', '20', '{\"code\": \"01.01.01\", \"title\": \"проверка\"}', '2026-04-14 03:22:01'),
(66, 1, 'create', 'education_program', '9', '{\"type\": \"additional\", \"title\": \"проверка\"}', '2026-04-14 03:23:54'),
(67, 1, 'delete', 'education_program', '9', NULL, '2026-04-14 03:33:45'),
(68, 1, 'create', 'education_program', '10', '{\"type\": \"additional\", \"title\": \"Проверка\"}', '2026-04-14 03:35:14'),
(69, 1, 'update', 'education_program', '10', '{\"type\": \"additional\", \"title\": \"Проверка\"}', '2026-04-14 03:44:00'),
(70, 1, 'delete', 'specialty', '20', NULL, '2026-04-14 03:49:26'),
(71, 1, 'create', 'specialty', '21', '{\"code\": \"01.01.01\", \"title\": \"проверка\"}', '2026-04-14 03:50:35'),
(72, 1, 'delete', 'specialty', '21', NULL, '2026-04-14 03:51:37'),
(73, 1, 'create', 'specialty', '22', '{\"code\": \"01.01.01\", \"title\": \"проверка\"}', '2026-04-14 03:56:02'),
(74, 1, 'create', 'story', '4', '{\"title\": \"проверка\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-14 03:57:49'),
(75, 1, 'update', 'story', '4', '{\"title\": \"проверка\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-14 04:14:52'),
(76, 1, 'update', 'story', '4', '{\"title\": \"проверка\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-14 04:15:27'),
(77, 1, 'create', 'page', '2', '{\"slug\": \"ewewew\", \"audience\": \"common\"}', '2026-04-14 04:37:19'),
(78, 1, 'update', 'page', '2', '{\"slug\": \"about-college\", \"audience\": \"common\"}', '2026-04-14 05:03:29'),
(79, 1, 'update', 'page', '2', '{\"slug\": \"about-college\", \"audience\": \"common\"}', '2026-04-14 05:06:47'),
(80, 1, 'update', 'specialty', '5', '{\"code\": \"09.02.06\", \"title\": \"Сетевое и системное администрирование\"}', '2026-04-14 05:09:15'),
(81, 1, 'update', 'specialty', '5', '{\"code\": \"09.02.06\", \"title\": \"Сетевое и системное администрирование\"}', '2026-04-14 05:10:57'),
(82, 1, 'update', 'page', '2', '{\"slug\": \"about-college\", \"audience\": \"common\"}', '2026-04-14 05:28:30'),
(83, 1, 'update', 'page', '2', '{\"slug\": \"about-college\", \"audience\": \"common\"}', '2026-04-14 05:30:11'),
(84, 1, 'delete', 'page', '2', NULL, '2026-04-14 05:33:48'),
(85, 1, 'update', 'page', '3', '{\"slug\": \"about-college\", \"audience\": \"guest\"}', '2026-04-14 05:35:12'),
(86, 1, 'update', 'page', '3', '{\"slug\": \"about-college\", \"audience\": \"guest\"}', '2026-04-14 05:36:11'),
(87, 1, 'delete', 'news_item', '6', NULL, '2026-04-14 05:41:25'),
(88, 1, 'delete', 'specialty', '22', NULL, '2026-04-14 05:43:03'),
(89, 1, 'delete', 'education_program', '10', NULL, '2026-04-14 05:43:21'),
(90, 1, 'update', 'education_program', '1', '{\"type\": \"additional\", \"title\": \"Веб-разработка (Full Stack)\"}', '2026-04-14 05:44:18'),
(91, 1, 'update', 'education_program', '2', '{\"type\": \"additional\", \"title\": \"1С: Бухгалтерия\"}', '2026-04-14 05:45:15'),
(92, 1, 'update', 'education_program', '2', '{\"type\": \"additional\", \"title\": \"1С: Бухгалтерия\"}', '2026-04-14 05:45:52'),
(93, 1, 'update', 'education_program', '3', '{\"type\": \"additional\", \"title\": \"AutoCAD для инженеров\"}', '2026-04-14 05:46:54'),
(94, 1, 'update', 'education_program', '2', '{\"type\": \"additional\", \"title\": \"1С: Бухгалтерия\"}', '2026-04-14 05:47:54'),
(95, 1, 'update', 'education_program', '4', '{\"type\": \"additional\", \"title\": \"Основы кибербезопасности\"}', '2026-04-14 05:48:44'),
(96, 1, 'update', 'education_program', '5', '{\"type\": \"courses\", \"title\": \"Математика для поступающих\"}', '2026-04-14 05:49:15'),
(97, 1, 'update', 'education_program', '6', '{\"type\": \"courses\", \"title\": \"Русский язык и изложение\"}', '2026-04-14 05:49:56'),
(98, 1, 'update', 'education_program', '7', '{\"type\": \"courses\", \"title\": \"Информатика — базовый курс\"}', '2026-04-14 05:50:25'),
(99, 1, 'update', 'education_program', '8', '{\"type\": \"courses\", \"title\": \"Физика для технических специальностей\"}', '2026-04-14 05:50:47'),
(100, 1, 'delete', 'partner', '19', NULL, '2026-04-14 05:52:25'),
(101, 1, 'update', 'page', '3', '{\"slug\": \"about-college\", \"audience\": \"guest\"}', '2026-04-14 05:53:43'),
(102, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-14 06:56:19'),
(103, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-14 07:09:52'),
(104, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-14 07:40:17'),
(105, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-14 07:44:27'),
(106, 1, 'delete', 'user', '5', NULL, '2026-04-14 10:37:10'),
(107, 1, 'create', 'student_user', '11', '{\"email\": \"kucersemen17@gmail.com\"}', '2026-04-14 10:38:31'),
(108, 1, 'delete', 'user', '11', NULL, '2026-04-14 10:39:25'),
(109, 1, 'accept_create_student', 'application', '19', '{\"new_user_id\": 12}', '2026-04-14 10:45:10'),
(110, 1, 'delete', 'application', '2', NULL, '2026-04-14 10:56:06'),
(111, 1, 'delete', 'application', '3', NULL, '2026-04-14 10:56:10'),
(112, 1, 'delete', 'application', '4', NULL, '2026-04-14 10:56:14'),
(113, 1, 'delete', 'application', '5', NULL, '2026-04-14 10:56:18'),
(114, 1, 'delete', 'application', '6', NULL, '2026-04-14 10:56:22'),
(115, 1, 'delete', 'application', '7', NULL, '2026-04-14 10:56:26'),
(116, 1, 'delete', 'application', '8', NULL, '2026-04-14 10:56:31'),
(117, 1, 'delete', 'application', '12', NULL, '2026-04-14 10:56:36'),
(118, 1, 'delete', 'application', '9', NULL, '2026-04-14 10:56:43'),
(119, 1, 'delete', 'application', '10', NULL, '2026-04-14 10:56:47'),
(120, 1, 'delete', 'application', '20', NULL, '2026-04-14 10:58:57'),
(121, 1, 'delete', 'user', '6', NULL, '2026-04-14 10:59:09'),
(122, 1, 'delete', 'user', '9', NULL, '2026-04-14 10:59:14'),
(123, 1, 'delete', 'user', '10', NULL, '2026-04-14 10:59:18'),
(124, 1, 'accept_create_student', 'application', '21', '{\"new_user_id\": 13}', '2026-04-14 11:00:39'),
(125, 1, 'delete', 'user', '13', NULL, '2026-04-14 11:01:23'),
(126, 1, 'accept_create_student', 'application', '22', '{\"new_user_id\": 14}', '2026-04-14 11:03:18'),
(127, 1, 'accept_create_student', 'application', '23', '{\"new_user_id\": 15}', '2026-04-14 11:08:16'),
(128, 1, 'delete', 'user', '15', NULL, '2026-04-14 11:15:52'),
(129, 1, 'delete', 'application', '23', NULL, '2026-04-14 11:16:00'),
(130, 1, 'accept_create_student', 'application', '24', '{\"new_user_id\": 16}', '2026-04-14 11:17:08'),
(131, 1, 'accept_create_student', 'application', '25', '{\"new_user_id\": 17}', '2026-04-14 11:20:02'),
(132, 1, 'delete', 'user', '17', NULL, '2026-04-14 11:25:08'),
(133, 1, 'delete', 'application', '25', NULL, '2026-04-14 11:25:14'),
(134, 1, 'accept_create_student', 'application', '26', '{\"new_user_id\": 18}', '2026-04-14 11:26:08'),
(135, 1, 'delete', 'application', '26', NULL, '2026-04-14 11:28:34'),
(136, 1, 'delete', 'user', '18', NULL, '2026-04-14 11:28:40'),
(137, 1, 'accept_create_student', 'application', '27', '{\"new_user_id\": 19}', '2026-04-14 11:30:07'),
(138, 1, 'delete', 'user', '19', NULL, '2026-04-14 11:32:49'),
(139, 1, 'delete', 'application', '27', NULL, '2026-04-14 11:32:58'),
(140, 1, 'accept_create_student', 'application', '28', '{\"new_user_id\": 20}', '2026-04-14 11:33:28'),
(141, 1, 'delete', 'application', '28', NULL, '2026-04-14 11:37:58'),
(142, 1, 'delete', 'user', '20', NULL, '2026-04-14 11:38:06'),
(143, 1, 'accept_create_student', 'application', '29', '{\"new_user_id\": 21}', '2026-04-14 11:39:57'),
(144, 1, 'delete', 'application', '29', NULL, '2026-04-14 14:13:01'),
(145, 1, 'delete', 'user', '21', NULL, '2026-04-14 14:13:09'),
(146, 1, 'accept_create_student', 'application', '30', '{\"new_user_id\": 22}', '2026-04-14 14:14:13'),
(147, 1, 'delete', 'application', '30', NULL, '2026-04-14 14:18:30'),
(148, 1, 'delete', 'user', '22', NULL, '2026-04-14 14:18:36'),
(149, 1, 'accept_create_student', 'application', '31', '{\"new_user_id\": 23}', '2026-04-14 14:20:22'),
(150, 1, 'delete', 'story', '2', NULL, '2026-04-14 14:32:18'),
(151, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-16 11:40:05'),
(152, 1, 'update', 'story', '1', '{\"title\": \"Зарница 2.0\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-16 11:41:25'),
(153, 1, 'update', 'story', '21', '{\"title\": \"День открытых дверей 2024\", \"sort_order\": 1, \"is_published\": 1}', '2026-04-16 11:41:54'),
(154, 1, 'update', 'story', '3', '{\"title\": \"Новости\", \"sort_order\": 2, \"is_published\": 1}', '2026-04-16 11:42:12'),
(155, 1, 'update', 'story', '22', '{\"title\": \"Международная студенческая конференция\", \"sort_order\": 2, \"is_published\": 1}', '2026-04-16 11:42:35'),
(156, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-18 22:41:14'),
(157, 1, 'create', 'story', '37', '{\"title\": \"pop\", \"sort_order\": 1, \"is_published\": 1}', '2026-04-19 12:57:56'),
(158, 1, 'delete', 'user', '23', NULL, '2026-04-19 16:47:19'),
(159, 1, 'delete', 'user', '16', NULL, '2026-04-19 16:47:32'),
(160, 1, 'accept_create_student', 'application', '35', '{\"new_user_id\": 24}', '2026-04-19 16:48:58'),
(161, 1, 'delete', 'application', '35', NULL, '2026-04-19 17:34:42'),
(162, 1, 'delete', 'user', '24', NULL, '2026-04-19 17:34:52'),
(163, 1, 'accept_create_student', 'application', '36', '{\"new_user_id\": 25}', '2026-04-19 17:35:06'),
(164, 1, 'delete', 'application', '36', NULL, '2026-04-19 17:40:17'),
(165, 1, 'delete', 'user', '25', NULL, '2026-04-19 17:40:25'),
(166, 1, 'accept_create_student', 'application', '37', '{\"new_user_id\": 26}', '2026-04-19 17:40:40'),
(167, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12]}', '2026-04-21 08:28:32'),
(168, 1, 'delete', 'story', '37', NULL, '2026-04-21 14:38:25'),
(169, 1, 'update', 'story', '1', '{\"title\": \"Зарница 2.0\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 01:06:39'),
(170, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 01:08:01'),
(171, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 01:08:37'),
(172, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 02:47:08'),
(173, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 02:47:53'),
(174, 1, 'update', 'staff_member', '1', '{\"full_name\": \"Тимошев Павел Викторович\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 02:48:05'),
(175, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [2, 1, 4, 5, 6, 7, 8, 9, 10, 11, 12]}', '2026-04-26 02:48:22'),
(176, 1, 'reorder', 'staff_member', 'bulk', '{\"ids\": [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12]}', '2026-04-26 02:48:33'),
(177, 1, 'update', 'story', '1', '{\"title\": \"Зарница 2.0\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 02:52:59'),
(178, 1, 'update', 'story', '1', '{\"title\": \"Зарница 2.0\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 03:00:02'),
(179, 1, 'update', 'story', '1', '{\"title\": \"Зарница 2.0\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 03:07:54'),
(180, 1, 'update', 'story', '1', '{\"title\": \"Зарница 2.0\", \"sort_order\": 0, \"is_published\": 1}', '2026-04-26 07:42:36'),
(181, 1, 'delete', 'story', '1', NULL, '2026-04-26 07:43:05'),
(182, 1, 'update', 'story', '21', '{\"title\": \"День открытых дверей 2024\", \"sort_order\": 1, \"is_published\": 1}', '2026-04-26 07:43:37'),
(183, 1, 'update', 'story', '21', '{\"title\": \"День открытых дверей 2024\", \"sort_order\": 1, \"is_published\": 1}', '2026-04-26 07:53:23'),
(184, 1, 'accept_create_student', 'application', '11', '{\"new_user_id\": 32}', '2026-04-26 08:01:44'),
(185, 1, 'accept_create_student', 'application', '41', '{\"new_user_id\": 33}', '2026-04-26 08:03:20'),
(186, 1, 'accept_create_student', 'application', '42', '{\"new_user_id\": 34}', '2026-04-26 08:05:14'),
(187, 1, 'update', 'story', '21', '{\"title\": \"День открытых дверей 2024\", \"sort_order\": 1, \"is_published\": 1}', '2026-04-26 10:49:27'),
(188, 1, 'update', 'specialty', '6', '{\"code\": \"09.02.07\", \"title\": \"Информационные системы и программирование\"}', '2026-04-26 10:52:10'),
(189, 1, 'update', 'specialty', '7', '{\"code\": \"10.02.03\", \"title\": \"Обеспечение информационной безопасности телекоммуникационных систем\"}', '2026-04-26 10:52:53'),
(190, 1, 'update', 'specialty', '8', '{\"code\": \"10.02.04\", \"title\": \"Обеспечение информационной безопасности автоматизированных систем\"}', '2026-04-26 10:53:51'),
(191, 1, 'update', 'specialty', '9', '{\"code\": \"13.02.11\", \"title\": \"Техническая эксплуатация и обслуживание электрического и электромеханического оборудования (по отраслям)\"}', '2026-04-26 10:56:41'),
(192, 1, 'update', 'specialty', '10', '{\"code\": \"17.02.12\", \"title\": \"Специальные машины и устройства\"}', '2026-04-26 10:57:13'),
(193, 1, 'update', 'specialty', '11', '{\"code\": \"15.02.08\", \"title\": \"Технология машиностроения\"}', '2026-04-26 10:57:48'),
(194, 1, 'update', 'specialty', '12', '{\"code\": \"15.02.16\", \"title\": \"Мехатроника и мобильная робототехника (по отраслям)\"}', '2026-04-26 10:58:40'),
(195, 1, 'update', 'specialty', '13', '{\"code\": \"21.02.03\", \"title\": \"Сооружение и эксплуатация газонефтепроводов и газонефтехранилищ (прикладная геология, горное дело, нефтегазовое дело и геодезия)\"}', '2026-04-26 10:58:59'),
(196, 1, 'update', 'specialty', '14', '{\"code\": \"22.02.06\", \"title\": \"Сварочное производство\"}', '2026-04-26 10:59:18'),
(197, 1, 'update', 'specialty', '15', '{\"code\": \"25.02.04\", \"title\": \"Техническое обслуживание авиационных двигателей\"}', '2026-04-26 10:59:37'),
(198, 1, 'update', 'specialty', '16', '{\"code\": \"12.02.11\", \"title\": \"Контроль работы измерительных приборов\"}', '2026-04-26 11:00:30'),
(199, 1, 'update', 'specialty', '16', '{\"code\": \"12.02.11\", \"title\": \"Контроль работы измерительных приборов\"}', '2026-04-26 11:00:48'),
(200, 1, 'update', 'specialty', '17', '{\"code\": \"13.02.02\", \"title\": \"Электро‑ и теплоэнергетика\"}', '2026-04-26 11:01:04'),
(201, 1, 'update', 'specialty', '18', '{\"code\": \"25.02.05\", \"title\": \"Аэронавигация и эксплуатация авиационной и ракетно‑космической техники\"}', '2026-04-26 11:01:18'),
(202, 1, 'update', 'specialty', '19', '{\"code\": \"38.02.01\", \"title\": \"Экономика и бухгалтерский учет\"}', '2026-04-26 11:01:33'),
(203, 1, 'delete', 'story', '20', NULL, '2026-04-26 11:03:44'),
(204, 1, 'delete', 'story', '19', NULL, '2026-04-26 11:03:52'),
(205, 1, 'toggle_publish', 'story', '18', NULL, '2026-04-26 11:03:59'),
(206, 1, 'toggle_publish', 'story', '17', NULL, '2026-04-26 11:04:06'),
(207, 1, 'toggle_publish', 'story', '16', NULL, '2026-04-26 11:04:12'),
(208, 1, 'toggle_publish', 'story', '15', NULL, '2026-04-26 11:04:18'),
(209, 1, 'toggle_publish', 'story', '29', NULL, '2026-04-26 11:04:22'),
(210, 1, 'toggle_publish', 'story', '5', NULL, '2026-04-26 11:04:26'),
(211, 1, 'toggle_publish', 'story', '23', NULL, '2026-04-26 11:04:32'),
(212, 1, 'toggle_publish', 'story', '14', NULL, '2026-04-26 11:04:38'),
(213, 1, 'toggle_publish', 'story', '13', NULL, '2026-04-26 11:04:50'),
(214, 1, 'toggle_publish', 'story', '24', NULL, '2026-04-26 11:04:57'),
(215, 1, 'toggle_publish', 'story', '6', NULL, '2026-04-26 11:05:03'),
(216, 1, 'toggle_publish', 'story', '25', NULL, '2026-04-26 11:05:09'),
(217, 1, 'toggle_publish', 'story', '30', NULL, '2026-04-26 11:05:35'),
(218, 1, 'toggle_publish', 'story', '7', NULL, '2026-04-26 11:05:42'),
(219, 1, 'toggle_publish', 'story', '26', NULL, '2026-04-26 11:05:53'),
(220, 1, 'toggle_publish', 'story', '31', NULL, '2026-04-26 11:06:14'),
(221, 1, 'toggle_publish', 'story', '8', NULL, '2026-04-26 11:06:19'),
(222, 1, 'toggle_publish', 'story', '36', NULL, '2026-04-26 11:06:28'),
(223, 1, 'toggle_publish', 'story', '27', NULL, '2026-04-26 11:07:01'),
(224, 1, 'toggle_publish', 'story', '32', NULL, '2026-04-26 11:07:10'),
(225, 1, 'toggle_publish', 'story', '9', NULL, '2026-04-26 11:07:15'),
(226, 1, 'toggle_publish', 'story', '28', NULL, '2026-04-26 11:07:22'),
(227, 1, 'toggle_publish', 'story', '33', NULL, '2026-04-26 11:07:29'),
(228, 1, 'toggle_publish', 'story', '10', NULL, '2026-04-26 11:07:35'),
(229, 1, 'toggle_publish', 'story', '34', NULL, '2026-04-26 11:07:45'),
(230, 1, 'update', 'story', '11', '{\"title\": \"Волонтерская акция \\\"Чистый космос\\\"\", \"sort_order\": 10, \"is_published\": 1}', '2026-04-26 11:15:48'),
(231, 1, 'update', 'story', '35', '{\"title\": \"Волонтерская акция \\\"Чистый космос\\\"\", \"sort_order\": 10, \"is_published\": 1}', '2026-04-26 11:16:23'),
(232, 1, 'update', 'story', '12', '{\"title\": \"Международный обмен с университетом Харбина\", \"sort_order\": 11, \"is_published\": 1}', '2026-04-26 11:16:44'),
(233, 1, 'vk_approve', 'vk_pending', '14', '{\"story_id\": 38, \"publish_now\": 1}', '2026-04-26 14:42:35'),
(234, 1, 'update', 'story', '38', '{\"title\": \"⚡️ Хоккей с дронами? Почему бы и нет!\", \"sort_order\": 1, \"is_published\": 1}', '2026-04-26 14:43:26'),
(235, 1, 'vk_approve', 'vk_pending', '147', '{\"story_id\": 39, \"publish_now\": 1}', '2026-04-26 16:00:17'),
(236, 1, 'vk_approve', 'vk_pending', '160', '{\"story_id\": 40, \"publish_now\": 1}', '2026-04-26 16:11:25'),
(237, 1, 'update', 'story', '40', '{\"title\": \"🎭 Пятница — день культурного десанта!\", \"sort_order\": 1, \"is_published\": 1}', '2026-04-26 16:11:51'),
(238, 1, 'delete', 'story', '18', NULL, '2026-04-26 16:12:42'),
(239, 1, 'delete', 'story', '21', NULL, '2026-04-26 16:12:53'),
(240, 1, 'delete', 'story', '38', NULL, '2026-04-26 16:13:15'),
(241, 1, 'delete', 'story', '4', NULL, '2026-04-26 16:13:24'),
(242, 1, 'toggle_publish', 'story', '23', NULL, '2026-04-26 16:13:28'),
(243, 1, 'delete', 'story', '23', NULL, '2026-04-26 16:13:38'),
(244, 1, 'delete', 'story', '5', NULL, '2026-04-26 16:13:43'),
(245, 1, 'delete', 'story', '24', NULL, '2026-04-26 16:13:48'),
(246, 1, 'delete', 'story', '29', NULL, '2026-04-26 16:13:54'),
(247, 1, 'delete', 'story', '6', NULL, '2026-04-26 16:13:59'),
(248, 1, 'delete', 'story', '25', NULL, '2026-04-26 16:14:03'),
(249, 1, 'delete', 'story', '30', NULL, '2026-04-26 16:14:08'),
(250, 1, 'delete', 'story', '7', NULL, '2026-04-26 16:14:13'),
(251, 1, 'delete', 'story', '26', NULL, '2026-04-26 16:14:17'),
(252, 1, 'delete', 'story', '31', NULL, '2026-04-26 16:14:22'),
(253, 1, 'delete', 'story', '8', NULL, '2026-04-26 16:14:27'),
(254, 1, 'delete', 'story', '27', NULL, '2026-04-26 16:14:31'),
(255, 1, 'delete', 'story', '32', NULL, '2026-04-26 16:14:36'),
(256, 1, 'delete', 'story', '9', NULL, '2026-04-26 16:15:31'),
(257, 1, 'delete', 'story', '28', NULL, '2026-04-26 16:15:36'),
(258, 1, 'delete', 'story', '33', NULL, '2026-04-26 16:15:43'),
(259, 1, 'delete', 'story', '10', NULL, '2026-04-26 16:15:48'),
(260, 1, 'delete', 'story', '34', NULL, '2026-04-26 16:15:53'),
(261, 1, 'delete', 'story', '17', NULL, '2026-04-26 16:16:00'),
(262, 1, 'delete', 'story', '11', NULL, '2026-04-26 16:16:08'),
(263, 1, 'delete', 'story', '35', NULL, '2026-04-26 16:16:15'),
(264, 1, 'delete', 'story', '12', NULL, '2026-04-26 16:16:20'),
(265, 1, 'delete', 'story', '22', NULL, '2026-04-26 16:16:35'),
(266, 1, 'delete', 'story', '36', NULL, '2026-04-26 16:16:54'),
(267, 1, 'delete', 'story', '13', NULL, '2026-04-26 16:17:01'),
(268, 1, 'delete', 'story', '14', NULL, '2026-04-26 16:17:06'),
(269, 1, 'delete', 'story', '15', NULL, '2026-04-26 16:17:11'),
(270, 1, 'delete', 'story', '16', NULL, '2026-04-26 16:17:17'),
(271, 1, 'vk_approve', 'vk_pending', '158', '{\"story_id\": 41, \"publish_now\": 1}', '2026-04-26 16:17:49'),
(272, 1, 'vk_approve', 'vk_pending', '163', '{\"story_id\": 42, \"publish_now\": 1}', '2026-04-26 16:18:06'),
(273, 1, 'vk_approve', 'vk_pending', '154', '{\"story_id\": 43, \"publish_now\": 1}', '2026-04-26 16:19:14'),
(274, 1, 'vk_approve', 'vk_pending', '153', '{\"story_id\": 44, \"publish_now\": 1}', '2026-04-26 16:19:36'),
(275, 1, 'vk_approve', 'vk_pending', '161', '{\"story_id\": 45, \"publish_now\": 1}', '2026-04-26 16:19:52'),
(276, 1, 'vk_approve', 'vk_pending', '165', '{\"story_id\": 46, \"publish_now\": 1}', '2026-04-26 16:47:37'),
(277, 1, 'vk_approve', 'vk_pending', '159', '{\"photos\": 3, \"story_id\": 47, \"publish_now\": 1}', '2026-04-27 03:13:45'),
(278, 1, 'bulk_delete', 'story', 'bulk', '{\"ids\": [40, 3, 39, 41, 42, 43, 44, 45, 46]}', '2026-04-27 03:15:44'),
(279, 1, 'update', 'story', '47', '{\"title\": \"Сегодня студенты аэрокосмического колледжа приняли участие\", \"photos\": 3, \"sort_order\": 1, \"is_published\": 1}', '2026-04-27 03:16:36'),
(280, 1, 'vk_approve', 'vk_pending', '155', '{\"photos\": 3, \"story_id\": 48, \"publish_now\": 1}', '2026-04-27 03:17:44'),
(281, 1, 'vk_approve', 'vk_pending', '156', '{\"photos\": 3, \"story_id\": 49, \"publish_now\": 1}', '2026-04-27 03:18:03'),
(282, 1, 'vk_approve', 'vk_pending', '164', '{\"photos\": 8, \"story_id\": 50, \"publish_now\": 1}', '2026-04-27 03:18:22'),
(283, 1, 'vk_approve', 'vk_pending', '151', '{\"photos\": 1, \"story_id\": 51, \"publish_now\": 1}', '2026-04-27 03:18:33'),
(284, 1, 'vk_approve', 'vk_pending', '157', '{\"photos\": 4, \"story_id\": 52, \"publish_now\": 1}', '2026-04-27 03:18:49'),
(285, 1, 'vk_approve', 'vk_pending', '162', '{\"photos\": 9, \"story_id\": 53, \"publish_now\": 1}', '2026-04-27 03:42:05'),
(286, 1, 'vk_approve', 'vk_pending', '152', '{\"photos\": 1, \"story_id\": 54, \"publish_now\": 1}', '2026-04-27 03:42:15'),
(287, 1, 'accept_create_student', 'application', '43', '{\"new_user_id\": 35}', '2026-04-27 13:38:52'),
(288, 1, 'bulk_delete', 'story', 'bulk', '{\"ids\": [47, 48, 49, 50, 51, 52, 53, 54]}', '2026-04-27 16:19:24'),
(289, 1, 'vk_approve', 'vk_pending', '279', '{\"photos\": 7, \"story_id\": 55, \"publish_now\": 1}', '2026-04-27 16:20:32'),
(290, 1, 'reset_password', 'user', '14', NULL, '2026-04-27 16:43:03'),
(291, 1, 'vk_approve', 'vk_pending', '280', '{\"photos\": 3, \"story_id\": 56, \"publish_now\": 1}', '2026-04-27 17:21:47'),
(292, 1, 'vk_approve', 'vk_pending', '293', '{\"photos\": 4, \"story_id\": 57, \"publish_now\": 1}', '2026-04-29 12:00:42'),
(293, 1, 'vk_approve', 'vk_pending', '294', '{\"photos\": 4, \"story_id\": 58, \"publish_now\": 1}', '2026-04-29 12:00:52'),
(294, 1, 'vk_approve', 'vk_pending', '295', '{\"photos\": 9, \"story_id\": 59, \"publish_now\": 1}', '2026-04-29 12:01:10'),
(295, 1, 'vk_approve', 'vk_pending', '281', '{\"photos\": 6, \"story_id\": 60, \"publish_now\": 1}', '2026-04-29 12:01:42'),
(296, 1, 'vk_approve', 'vk_pending', '323', '{\"photos\": 9, \"story_id\": 61, \"publish_now\": 1}', '2026-05-01 07:26:52'),
(297, 1, 'delete', 'application', '38', NULL, '2026-05-04 08:32:40'),
(298, 1, 'bulk_processing', 'application', '40,39,34,33,32', '{\"count\": 5}', '2026-05-04 08:33:11'),
(299, 1, 'vk_approve', 'vk_pending', '337', '{\"photos\": 3, \"story_id\": 62, \"publish_now\": 1}', '2026-05-05 13:36:11'),
(300, 1, 'delete', 'news_item', '2', NULL, '2026-05-05 14:41:01'),
(301, 1, 'delete', 'news_item', '1', NULL, '2026-05-05 14:41:04'),
(302, 1, 'delete', 'staff_member', '13', NULL, '2026-05-05 15:10:53'),
(303, 1, 'delete', 'staff_member', '4', NULL, '2026-05-05 15:11:14'),
(304, 1, 'create', 'student_user', '36', '{\"email\": \"1@gmail.com\"}', '2026-05-06 13:18:13'),
(305, 1, 'create', 'student_user', '37', '{\"email\": \"2@gmail.com\"}', '2026-05-06 13:19:27'),
(306, 1, 'delete', 'staff_member', '22', NULL, '2026-05-06 13:44:49'),
(307, 1, 'delete', 'staff_member', '23', NULL, '2026-05-06 14:09:55');

-- --------------------------------------------------------

--
-- Структура таблицы `bell_schedule`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `bell_schedule`;
CREATE TABLE `bell_schedule` (
  `id` bigint NOT NULL,
  `pair_number` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `starts_at` time NOT NULL,
  `ends_at` time NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `contacts`
--
-- Создание: Май 05 2026 г., 09:55
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` bigint NOT NULL,
  `type` enum('phone','email','website') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` enum('college','career_center') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'college',
  `image_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `contacts`
--

INSERT INTO `contacts` (`id`, `type`, `value`, `label`, `category`, `image_url`, `sort_order`, `is_active`) VALUES
(1, 'phone', '+7 00000000000', 'Приемная', 'college', NULL, 1, 1),
(2, 'phone', '+7 (391) 264-57-35', 'Учебная часть', 'college', NULL, 2, 1),
(3, 'email', 'ak@sibsau.ru', 'Основной email', 'college', NULL, 3, 1),
(4, 'website', 'https://sibsau.ru', 'Сайт университета', 'college', NULL, 4, 1),
(5, 'website', 'https://abiturient.sibsau.ru', 'Абитуриенту', 'college', NULL, 5, 1),
(6, 'phone', '+7 (391) 264-06-59', 'Приемная', 'college', NULL, 1, 1),
(7, 'email', 'nvme', 'Website for mertown.gt.tc', 'career_center', NULL, -1, 1),
(8, 'phone', '756454', NULL, 'career_center', NULL, 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `content_revisions`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `content_revisions`;
CREATE TABLE `content_revisions` (
  `id` bigint NOT NULL,
  `entity_type` enum('news','page') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_json` json NOT NULL,
  `created_by` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `content_revisions`
--

INSERT INTO `content_revisions` (`id`, `entity_type`, `entity_id`, `title`, `content_json`, `created_by`, `created_at`) VALUES
(1, 'page', 2, 'ewewewe', '{\"body\": \"weweww\", \"lead\": \"ewewew\"}', 1, '2026-04-14 05:03:29'),
(2, 'page', 2, 'ewewewe', '{\"body\": \"weweww\", \"lead\": \"ewewew\", \"stats\": [], \"advantages\": [], \"about_title\": \"\", \"achievements\": [], \"mission_title\": \"\", \"stats_heading\": \"\", \"advantages_heading\": \"\", \"infrastructure_text\": \"\", \"achievements_heading\": \"\", \"infrastructure_heading\": \"\"}', 1, '2026-04-14 05:06:47'),
(3, 'page', 2, 'ewewewe', '{\"body\": \"wewewwуууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"lead\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"stats\": [{\"icon\": \"people\", \"color\": \"\", \"label\": \"укуккуу\", \"value\": \"3434\"}, {\"icon\": \"auto_stories\", \"color\": \"\", \"label\": \"укук\", \"value\": \"3434\"}, {\"icon\": \"emoji_events\", \"color\": \"\", \"label\": \"укуку\", \"value\": \"3434\"}, {\"icon\": \"business\", \"color\": \"\", \"label\": \"укуку\", \"value\": \"34343\"}, {\"icon\": \"business\", \"color\": \"\", \"label\": \"укуку\", \"value\": \"3434\"}, {\"icon\": \"groups\", \"color\": \"\", \"label\": \"\", \"value\": \"\"}, {\"icon\": \"school\", \"color\": \"\", \"label\": \"\", \"value\": \"\"}], \"advantages\": [{\"icon\": \"rocket_launch\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"укукуку\"}, {\"icon\": \"computer\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"укукуку\"}, {\"icon\": \"handshake\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"укукуку\"}, {\"icon\": \"trending_up\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"укукукук\"}, {\"icon\": \"military_tech\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"укукукук\"}, {\"icon\": \"workspace_premium\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"укукукуку\"}], \"about_title\": \"333333333333334куккукуку\", \"achievements\": [{\"icon\": \"engineering\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"workspace_premium\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"rocket_launch\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"diversity_3\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"handshake\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"school\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}], \"mission_title\": \"wewewe\", \"stats_heading\": \"3366454\", \"advantages_heading\": \"укукукукук\", \"infrastructure_text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"achievements_heading\": \"\", \"infrastructure_heading\": \"sdsdsd\"}', 1, '2026-04-14 05:28:30'),
(4, 'page', 2, 'О колледже', '{\"body\": \"Подготовка высококвалифицированных специалистов, готовых к успешной профессиональной деятельности в современных условиях. \\r\\nМы стремимся воспитать не только профессионалов, но и ответственных граждан, способных внести значимый вклад в развитие общества и технологий.\", \"lead\": \"\", \"stats\": [{\"icon\": \"people\", \"color\": \"#4A90E2\", \"label\": \"укуккуу\", \"value\": \"3434\"}, {\"icon\": \"auto_stories\", \"color\": \"#4A90E2\", \"label\": \"укук\", \"value\": \"3434\"}, {\"icon\": \"emoji_events\", \"color\": \"#4A90E2\", \"label\": \"укуку\", \"value\": \"3434\"}, {\"icon\": \"business\", \"color\": \"#4A90E2\", \"label\": \"укуку\", \"value\": \"34343\"}, {\"icon\": \"business\", \"color\": \"#4A90E2\", \"label\": \"укуку\", \"value\": \"3434\"}, {\"icon\": \"groups\", \"color\": \"#4A90E2\", \"label\": \"\", \"value\": \"\"}, {\"icon\": \"school\", \"color\": \"#4A90E2\", \"label\": \"\", \"value\": \"\"}, {\"icon\": \"\", \"color\": \"#4A90E2\", \"label\": \"\", \"value\": \"\"}], \"advantages\": [{\"icon\": \"rocket_launch\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#283593\", \"title\": \"укукуку\"}, {\"icon\": \"computer\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#283593\", \"title\": \"укукуку\"}, {\"icon\": \"handshake\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#283593\", \"title\": \"укукуку\"}, {\"icon\": \"trending_up\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#283593\", \"title\": \"укукукук\"}, {\"icon\": \"military_tech\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#283593\", \"title\": \"укукукук\"}, {\"icon\": \"workspace_premium\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#283593\", \"title\": \"укукукуку\"}], \"about_title\": \"333333333333334куккукуку\", \"achievements\": [{\"icon\": \"engineering\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#FFA726\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"workspace_premium\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#FFA726\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"rocket_launch\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#FFA726\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"diversity_3\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#FFA726\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"handshake\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#FFA726\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}, {\"icon\": \"school\", \"text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"color\": \"#FFA726\", \"title\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\"}], \"mission_title\": \"Подготовка высококвалифицированных специалистов, готовых к успешной профессиональной деятельности в современных условиях.  Мы стремимся воспитать не только профессионалов, но и ответственных граждан, способных внести значимый вклад в развитие общества и технологий.\", \"stats_heading\": \"3366454\", \"advantages_heading\": \"укукукукук\", \"infrastructure_text\": \"уууууууууууууууууууууууууууууууууууукукукукукукукукукукуууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууууу\", \"achievements_heading\": \"\", \"infrastructure_heading\": \"sdsdsd\"}', 1, '2026-04-14 05:30:11'),
(5, 'page', 3, 'О колледже', '{\"body\": \"Аэрокосмический колледж СибГУ им. академика М.Ф. Решетнёва — одно из ведущих учебных заведений среднего профессионального образования в Красноярском крае. Колледж является структурным подразделением Сибирского государственного университета науки и технологий и имеет богатую историю подготовки специалистов для авиационно-космической, машиностроительной и IT-отраслей.\\n\\nНа протяжении десятилетий наш колледж выпускает квалифицированных техников, программистов, инженеров и экономистов, которые успешно трудоустраиваются на ведущих предприятиях региона и страны. Тесное сотрудничество с промышленными партнёрами — ОКБ «Зенит», КрасМаш, АО «РЕШЕТНЁВ» — обеспечивает студентам возможность проходить производственную практику на реальном оборудовании.\", \"lead\": \"Подготовка высококвалифицированных специалистов, готовых к успешной профессиональной деятельности в современных условиях. Мы стремимся воспитать не только профессионалов, но и ответственных граждан, способных внести значимый вклад в развитие общества и технологий.\", \"stats\": [{\"icon\": \"people\", \"color\": \"0xFF4A90E2\", \"label\": \"Студентов\", \"value\": \"2 500+\"}, {\"icon\": \"auto_stories\", \"color\": \"0xFF66BB6A\", \"label\": \"Специальностей\", \"value\": \"15\"}, {\"icon\": \"emoji_events\", \"color\": \"0xFFFFA726\", \"label\": \"Лет истории\", \"value\": \"60+\"}, {\"icon\": \"business\", \"color\": \"0xFFAB47BC\", \"label\": \"Партнёра\", \"value\": \"17\"}, {\"icon\": \"school\", \"color\": \"0xFF26A69A\", \"label\": \"Трудоустройство\", \"value\": \"95%\"}, {\"icon\": \"groups\", \"color\": \"0xFFEF5350\", \"label\": \"Преподавателей\", \"value\": \"150+\"}], \"advantages\": [{\"icon\": \"rocket_launch\", \"text\": \"Уникальные специальности, связанные с авиацией и ракетно-космической техникой, которые есть далеко не в каждом колледже.\", \"color\": \"0xFF283593\", \"title\": \"Аэрокосмическое наследие\"}, {\"icon\": \"computer\", \"text\": \"Программирование, кибербезопасность, системное администрирование — востребованные специальности с высоким спросом на рынке труда.\", \"color\": \"0xFF0288D1\", \"title\": \"Современные IT-направления\"}, {\"icon\": \"handshake\", \"text\": \"Производственная практика на реальных предприятиях. Наши партнёры — КрасМаш, РЕШЕТНЁВ, ОКБ «Зенит» — берут выпускников на работу.\", \"color\": \"0xFF2E7D32\", \"title\": \"Связь с индустрией\"}, {\"icon\": \"trending_up\", \"text\": \"Центр карьеры помогает с трудоустройством, стажировками и развитием профессиональных навыков ещё во время обучения.\", \"color\": \"0xFFE65100\", \"title\": \"Карьерный рост\"}], \"about_title\": \"О нас\", \"achievements\": [{\"icon\": \"military_tech\", \"text\": \"Студенты колледжа регулярно занимают призовые места в региональных и национальных чемпионатах WorldSkills по компетенциям «Сетевое администрирование», «Мехатроника» и «Сварочные технологии».\", \"color\": \"0xFFFFA726\", \"title\": \"Победители WorldSkills Russia\"}, {\"icon\": \"workspace_premium\", \"text\": \"Все образовательные программы прошли государственную аккредитацию. Выпускники получают дипломы государственного образца, признаваемые по всей России.\", \"color\": \"0xFF4A90E2\", \"title\": \"Аккредитация и лицензии\"}, {\"icon\": \"science\", \"text\": \"Ежегодно студенты участвуют в научных конференциях и инженерных конкурсах, представляя проекты по робототехнике, программированию и 3D-моделированию.\", \"color\": \"0xFF66BB6A\", \"title\": \"Научно-техническое творчество\"}, {\"icon\": \"diversity_3\", \"text\": \"Более 10 кружков и секций: от спортивных команд до IT-клуба и инженерного общества. Регулярные фестивали, соревнования и волонтёрские проекты.\", \"color\": \"0xFFAB47BC\", \"title\": \"Активная студенческая жизнь\"}], \"mission_title\": \"Наша миссия\", \"stats_heading\": \"Колледж в цифрах\", \"advantages_heading\": \"Почему выбирают нас\", \"infrastructure_text\": \"Колледж располагает современными учебными корпусами, оснащёнными лабораториями и мастерскими:\\n• Компьютерные классы с лицензионным ПО\\n• Лаборатории робототехники и мехатроники\\n• Сварочные мастерские с современным оборудованием\\n• Лаборатории электротехники и измерительных приборов\\n• Авиационный ангар для практических занятий\\n• Библиотека с электронными ресурсами\\n• Спортивный зал и площадки\", \"achievements_heading\": \"Наши достижения\", \"infrastructure_heading\": \"Инфраструктура\"}', 1, '2026-04-14 05:35:12'),
(6, 'page', 3, 'О колледже', '{\"body\": \"Аэрокосмический колледж СибГУ им. академика М.Ф. Решетнёва — одно из ведущих учебных заведений среднего профессионального образования в Красноярском крае. Колледж является структурным подразделением Сибирского государственного университета науки и технологий и имеет богатую историю подготовки специалистов для авиационно-космической, машиностроительной и IT-отраслей.\\r\\n\\r\\nНа протяжении десятилетий наш колледж выпускает квалифицированных техников, программистов, инженеров и экономистов, которые успешно трудоустраиваются на ведущих предприятиях региона и страны. Тесное сотрудничество с промышленными партнёрами — ОКБ «Зенит», КрасМаш, АО «РЕШЕТНЁВ» — обеспечивает студентам возможность проходить производственную практику на реальном оборудовании.\", \"lead\": \"Подготовка высококвалифицированных специалистов, готовых к успешной профессиональной деятельности в современных условиях. Мы стремимся воспитать не только профессионалов, но и ответственных граждан, способных внести значимый вклад в развитие общества и технологий.\", \"stats\": [{\"icon\": \"people\", \"color\": \"#4A90E2\", \"label\": \"Студентов\", \"value\": \"2 500+\"}, {\"icon\": \"auto_stories\", \"color\": \"#66BB6A\", \"label\": \"Специальностей\", \"value\": \"15\"}, {\"icon\": \"emoji_events\", \"color\": \"#FFA726\", \"label\": \"Лет истории\", \"value\": \"60+\"}, {\"icon\": \"business\", \"color\": \"#AB47BC\", \"label\": \"Партнёра\", \"value\": \"17\"}, {\"icon\": \"school\", \"color\": \"#26A69A\", \"label\": \"Трудоустройство\", \"value\": \"95%\"}, {\"icon\": \"groups\", \"color\": \"#EF5350\", \"label\": \"Преподавателей\", \"value\": \"150+\"}, {\"icon\": \"\", \"color\": \"#4A90E2\", \"label\": \"\", \"value\": \"\"}, {\"icon\": \"\", \"color\": \"#4A90E2\", \"label\": \"\", \"value\": \"\"}], \"advantages\": [{\"icon\": \"rocket_launch\", \"text\": \"Уникальные специальности, связанные с авиацией и ракетно-космической техникой, которые есть далеко не в каждом колледже.\", \"color\": \"#283593\", \"title\": \"Аэрокосмическое наследие\"}, {\"icon\": \"computer\", \"text\": \"Программирование, кибербезопасность, системное администрирование — востребованные специальности с высоким спросом на рынке труда.\", \"color\": \"#0288D1\", \"title\": \"Современные IT-направления\"}, {\"icon\": \"handshake\", \"text\": \"Производственная практика на реальных предприятиях. Наши партнёры — КрасМаш, РЕШЕТНЁВ, ОКБ «Зенит» — берут выпускников на работу.\", \"color\": \"#2E7D32\", \"title\": \"Связь с индустрией\"}, {\"icon\": \"trending_up\", \"text\": \"Центр карьеры помогает с трудоустройством, стажировками и развитием профессиональных навыков ещё во время обучения.\", \"color\": \"#E65100\", \"title\": \"Карьерный рост\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#283593\", \"title\": \"\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#283593\", \"title\": \"\"}], \"about_title\": \"О нас\", \"achievements\": [{\"icon\": \"military_tech\", \"text\": \"Студенты колледжа регулярно занимают призовые места в региональных и национальных чемпионатах WorldSkills по компетенциям «Сетевое администрирование», «Мехатроника» и «Сварочные технологии».\", \"color\": \"#FFA726\", \"title\": \"Победители WorldSkills Russia\"}, {\"icon\": \"workspace_premium\", \"text\": \"Все образовательные программы прошли государственную аккредитацию. Выпускники получают дипломы государственного образца, признаваемые по всей России.\", \"color\": \"#4A90E2\", \"title\": \"Аккредитация и лицензии\"}, {\"icon\": \"science\", \"text\": \"Ежегодно студенты участвуют в научных конференциях и инженерных конкурсах, представляя проекты по робототехнике, программированию и 3D-моделированию.\", \"color\": \"#66BB6A\", \"title\": \"Научно-техническое творчество\"}, {\"icon\": \"diversity_3\", \"text\": \"Более 10 кружков и секций: от спортивных команд до IT-клуба и инженерного общества. Регулярные фестивали, соревнования и волонтёрские проекты.\", \"color\": \"#AB47BC\", \"title\": \"Активная студенческая жизнь\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#FFA726\", \"title\": \"\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#FFA726\", \"title\": \"\"}], \"mission_title\": \"Наша миссия\", \"stats_heading\": \"Колледж в цифрах\", \"advantages_heading\": \"Почему выбирают нас\", \"infrastructure_text\": \"Колледж располагает современными учебными корпусами, оснащёнными лабораториями и мастерскими:\\r\\n• Компьютерные классы с лицензионным ПО\\r\\n• Лаборатории робототехники и мехатроники\\r\\n• Сварочные мастерские с современным оборудованием\\r\\n• Лаборатории электротехники и измерительных приборов\\r\\n• Авиационный ангар для практических занятий\\r\\n• Библиотека с электронными ресурсами\\r\\n• Спортивный зал и площадки\", \"achievements_heading\": \"Наши достижения\", \"infrastructure_heading\": \"Инфраструктура\"}', 1, '2026-04-14 05:36:11'),
(7, 'page', 3, 'О колледже', '{\"body\": \"Аэрокосмический колледж СибГУ им. академика М.Ф. Решетнёва — одно из ведущих учебных заведений среднего профессионального образования в Красноярском крае. Колледж является структурным подразделением Сибирского государственного университета науки и технологий и имеет богатую историю подготовки специалистов для авиационно-космической, машиностроительной и IT-отраслей.\\r\\n\\r\\nНа протяжении десятилетий наш колледж выпускает квалифицированных техников, программистов, инженеров и экономистов, которые успешно трудоустраиваются на ведущих предприятиях региона и страны. Тесное сотрудничество с промышленными партнёрами — ОКБ «Зенит», КрасМаш, АО «РЕШЕТНЁВ» — обеспечивает студентам возможность проходить производственную практику на реальном оборудовании.\", \"lead\": \"Подготовка высококвалифицированных специалистов, готовых к успешной профессиональной деятельности в современных условиях. Мы стремимся воспитать не только профессионалов, но и ответственных граждан, способных внести значимый вклад в развитие общества и технологий.\", \"stats\": [{\"icon\": \"people\", \"color\": \"#4A90E2\", \"label\": \"Студентов\", \"value\": \"2 500+\"}, {\"icon\": \"auto_stories\", \"color\": \"#66BB6A\", \"label\": \"Специальностей\", \"value\": \"15\"}, {\"icon\": \"emoji_events\", \"color\": \"#FFA726\", \"label\": \"Лет истории\", \"value\": \"60+\"}, {\"icon\": \"business\", \"color\": \"#AB47BC\", \"label\": \"Партнёра\", \"value\": \"17\"}, {\"icon\": \"school\", \"color\": \"#26A69A\", \"label\": \"Трудоустройство\", \"value\": \"95%\"}, {\"icon\": \"groups\", \"color\": \"#EF5350\", \"label\": \"Преподавателей\", \"value\": \"150+\"}, {\"icon\": \"\", \"color\": \"#FFFFFF\", \"label\": \"\", \"value\": \"\"}, {\"icon\": \"\", \"color\": \"#FFFFFF\", \"label\": \"\", \"value\": \"\"}], \"advantages\": [{\"icon\": \"rocket_launch\", \"text\": \"Уникальные специальности, связанные с авиацией и ракетно-космической техникой, которые есть далеко не в каждом колледже.\", \"color\": \"#283593\", \"title\": \"Аэрокосмическое наследие\"}, {\"icon\": \"computer\", \"text\": \"Программирование, кибербезопасность, системное администрирование — востребованные специальности с высоким спросом на рынке труда.\", \"color\": \"#0288D1\", \"title\": \"Современные IT-направления\"}, {\"icon\": \"handshake\", \"text\": \"Производственная практика на реальных предприятиях. Наши партнёры — КрасМаш, РЕШЕТНЁВ, ОКБ «Зенит» — берут выпускников на работу.\", \"color\": \"#2E7D32\", \"title\": \"Связь с индустрией\"}, {\"icon\": \"trending_up\", \"text\": \"Центр карьеры помогает с трудоустройством, стажировками и развитием профессиональных навыков ещё во время обучения.\", \"color\": \"#E65100\", \"title\": \"Карьерный рост\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#F1F1F3\", \"title\": \"\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#FFFFFF\", \"title\": \"\"}], \"about_title\": \"О нас\", \"achievements\": [{\"icon\": \"military_tech\", \"text\": \"Студенты колледжа регулярно занимают призовые места в региональных и национальных чемпионатах WorldSkills по компетенциям «Сетевое администрирование», «Мехатроника» и «Сварочные технологии».\", \"color\": \"#FFA726\", \"title\": \"Победители WorldSkills Russia\"}, {\"icon\": \"workspace_premium\", \"text\": \"Все образовательные программы прошли государственную аккредитацию. Выпускники получают дипломы государственного образца, признаваемые по всей России.\", \"color\": \"#4A90E2\", \"title\": \"Аккредитация и лицензии\"}, {\"icon\": \"science\", \"text\": \"Ежегодно студенты участвуют в научных конференциях и инженерных конкурсах, представляя проекты по робототехнике, программированию и 3D-моделированию.\", \"color\": \"#66BB6A\", \"title\": \"Научно-техническое творчество\"}, {\"icon\": \"diversity_3\", \"text\": \"Более 10 кружков и секций: от спортивных команд до IT-клуба и инженерного общества. Регулярные фестивали, соревнования и волонтёрские проекты.\", \"color\": \"#AB47BC\", \"title\": \"Активная студенческая жизнь\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#FFFFFF\", \"title\": \"\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#FFFFFF\", \"title\": \"\"}], \"mission_title\": \"Наша миссия\", \"stats_heading\": \"Колледж в цифрах\", \"advantages_heading\": \"Почему выбирают нас\", \"infrastructure_text\": \"Колледж располагает современными учебными корпусами, оснащёнными лабораториями и мастерскими:\\r\\n• Компьютерные классы с лицензионным ПО\\r\\n• Лаборатории робототехники и мехатроники\\r\\n• Сварочные мастерские с современным оборудованием\\r\\n• Лаборатории электротехники и измерительных приборов\\r\\n• Авиационный ангар для практических занятий\\r\\n• Библиотека с электронными ресурсами\\r\\n• Спортивный зал и площадки\", \"achievements_heading\": \"Наши достижения\", \"infrastructure_heading\": \"Инфраструктура\"}', 1, '2026-04-14 05:53:43');

-- --------------------------------------------------------

--
-- Структура таблицы `disciplines_ref`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `disciplines_ref`;
CREATE TABLE `disciplines_ref` (
  `id` bigint NOT NULL,
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `education_programs`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `education_programs`;
CREATE TABLE `education_programs` (
  `id` bigint NOT NULL,
  `type` enum('additional','courses') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `duration_label` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `target_audience` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `outcome_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `format_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `icon_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_hex` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `publish_from` datetime DEFAULT NULL,
  `publish_to` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `education_programs`
--

INSERT INTO `education_programs` (`id`, `type`, `title`, `description`, `duration_label`, `details`, `target_audience`, `outcome_text`, `format_text`, `icon_name`, `color_hex`, `image_url`, `sort_order`, `is_published`, `publish_from`, `publish_to`, `created_at`) VALUES
(1, 'additional', 'Веб-разработка (Full Stack)', 'HTML, CSS, JavaScript, React, Node.js — от основ до практики.', '6 месяцев', 'Курс охватывает полный стек веб-разработки: вёрстка, стилизация, JavaScript, фреймворки React и Node.js. После завершения курса вы сможете создавать современные веб-приложения и работать как фронтенд, так и бэкенд разработчиком.', NULL, NULL, NULL, 'web', '#1565C0', '/api/public/uploads/img_20260414_054418_541e7fe9658c.jpg', 10, 1, NULL, NULL, '2026-04-14 03:17:01'),
(2, 'additional', '1С: Бухгалтерия', 'Практический курс по работе с 1С:Бухгалтерия 8.3.', '3 месяца', 'Освоите работу в программе 1С:Бухгалтерия 8.3: ввод первичных документов, учёт расчётов с контрагентами, формирование отчётности. Курс предназначен для начинающих бухгалтеров и специалистов по учёту.', NULL, NULL, NULL, 'calculate', '#DBAC00', '/api/public/uploads/img_20260414_054754_715c60a8c933.jpg', 20, 1, NULL, NULL, '2026-04-14 03:17:01'),
(3, 'additional', 'AutoCAD для инженеров', 'Черчение и проектирование: 2D/3D основы.', '4 месяца', 'Научитесь создавать технические чертежи и трёхмерные модели в AutoCAD. Курс включает 2D-черчение, 3D-моделирование, оформление чертежей по ГОСТ.', NULL, NULL, NULL, 'design_services', '#6A1B9A', '/api/public/uploads/img_20260414_054654_61f2fc1333da.jpg', 30, 1, NULL, NULL, '2026-04-14 03:17:01'),
(4, 'additional', 'Основы кибербезопасности', 'Уязвимости, защита инфраструктуры, базовые практики.', '5 месяцев', 'Курс знакомит с основными угрозами информационной безопасности, методами защиты сетей и систем, основами криптографии. Вы научитесь выявлять уязвимости и применять инструменты защиты информации.', NULL, NULL, NULL, 'lock', '#2E7D32', '/api/public/uploads/img_20260414_054844_7d8a20637e2f.jpg', 40, 1, NULL, NULL, '2026-04-14 03:17:01'),
(5, 'courses', 'Математика для поступающих', 'Алгебра, геометрия, типовые задачи — интенсив.', '2 месяца', 'Интенсивная подготовка к поступлению: алгебра, геометрия, тригонометрия, типовые задачи вступительных испытаний. Занятия в малых группах, разбор типичных ошибок.', NULL, NULL, NULL, 'functions', '#F57F17', '/api/public/uploads/img_20260414_054915_dbd6a58229bf.jpg', 50, 1, NULL, NULL, '2026-04-14 03:17:01'),
(6, 'courses', 'Русский язык и изложение', 'Орфография, пунктуация, сочинения и изложение.', '2 месяца', 'Подготовка по русскому языку: повторение орфографии и пунктуации, практика написания изложений и сочинений. Разбор типовых ошибок и заданий вступительных испытаний.', NULL, NULL, NULL, 'menu_book', '#BF360C', '/api/public/uploads/img_20260414_054956_4285fd245ec2.jpg', 60, 1, NULL, NULL, '2026-04-14 03:17:01'),
(7, 'courses', 'Информатика — базовый курс', 'Алгоритмы, основы программирования, практика.', '1,5 месяца', 'Базовая подготовка по информатике: алгоритмы и основы программирования, работа с офисными программами, устройство компьютера.', NULL, NULL, NULL, 'computer', '#0277BD', '/api/public/uploads/img_20260414_055025_acbbca73bb70.jpg', 70, 1, NULL, NULL, '2026-04-14 03:17:01'),
(8, 'courses', 'Физика для технических специальностей', 'Механика, электричество, термодинамика — подготовка.', '2 месяца', 'Подготовительный курс по физике: механика, молекулярная физика, электричество и магнетизм, оптика. Разбор задач вступительных испытаний и практические лабораторные работы.', NULL, NULL, NULL, 'science', '#37474F', '/api/public/uploads/img_20260414_055047_d718a3ebe6a4.jpg', 80, 1, NULL, NULL, '2026-04-14 03:17:01');

-- --------------------------------------------------------

--
-- Структура таблицы `events`
--
-- Создание: Май 05 2026 г., 09:54
-- Последнее обновление: Май 05 2026 г., 14:41
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `category` enum('career','meetup','fair','workshop','excursion','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'career',
  `cover_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `partner_id` bigint DEFAULT NULL,
  `external_url` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime DEFAULT NULL,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `category`, `cover_url`, `partner_id`, `external_url`, `starts_at`, `ends_at`, `location`, `is_published`, `created_by`, `created_at`) VALUES
(1, 'qwqwq', 'qwqwqw', 'career', '/api/public/uploads/events/20260505_174146_b593a002c4aa.png', NULL, 'http://kucersta.beget.tech/api/public/admin/career/event_edit.php', '2026-05-05 17:41:00', NULL, 'qwqwq', 1, 1, '2026-05-05 14:41:46');

-- --------------------------------------------------------

--
-- Структура таблицы `groups_ref`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `groups_ref`;
CREATE TABLE `groups_ref` (
  `id` bigint NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `curator_staff_id` bigint DEFAULT NULL,
  `specialty_id` bigint DEFAULT NULL,
  `course_year` int NOT NULL DEFAULT '1',
  `admission_year` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `group_schedule`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `group_schedule`;
CREATE TABLE `group_schedule` (
  `id` bigint NOT NULL,
  `group_id` bigint NOT NULL,
  `weekday` tinyint NOT NULL COMMENT '1=Mon ... 7=Sun',
  `pair_number` int NOT NULL,
  `subject_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `teacher_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `media_assets`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `media_assets`;
CREATE TABLE `media_assets` (
  `id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` enum('image','video','document') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'image',
  `audience` enum('guest','applicant','student','teacher','common') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'common',
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `news_items`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 05 2026 г., 14:41
--

DROP TABLE IF EXISTS `news_items`;
CREATE TABLE `news_items` (
  `id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published_at` datetime DEFAULT NULL,
  `publish_from` datetime DEFAULT NULL,
  `publish_to` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0',
  `author_user_id` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `pages`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Апр 26 2026 г., 07:45
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` bigint NOT NULL,
  `slug` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `audience` enum('guest','applicant','student','teacher','common') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'common',
  `content_json` json NOT NULL,
  `cover_image_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `publish_from` datetime DEFAULT NULL,
  `publish_to` datetime DEFAULT NULL,
  `created_by` bigint DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `pages`
--

INSERT INTO `pages` (`id`, `slug`, `title`, `audience`, `content_json`, `cover_image_url`, `is_published`, `publish_from`, `publish_to`, `created_by`, `updated_by`, `created_at`) VALUES
(3, 'about-college', 'О колледже', 'guest', '{\"body\": \"Аэрокосмический колледж СибГУ им. академика М.Ф. Решетнёва — одно из ведущих учебных заведений среднего профессионального образования в Красноярском крае. Колледж является структурным подразделением Сибирского государственного университета науки и технологий и имеет богатую историю подготовки специалистов для авиационно-космической, машиностроительной и IT-отраслей.\\r\\n\\r\\nНа протяжении десятилетий наш колледж выпускает квалифицированных техников, программистов, инженеров и экономистов, которые успешно трудоустраиваются на ведущих предприятиях региона и страны. Тесное сотрудничество с промышленными партнёрами — ОКБ «Зенит», КрасМаш, АО «РЕШЕТНЁВ» — обеспечивает студентам возможность проходить производственную практику на реальном оборудовании.\", \"lead\": \"Подготовка высококвалифицированных специалистов, готовых к успешной профессиональной деятельности в современных условиях. Мы стремимся воспитать не только профессионалов, но и ответственных граждан, способных внести значимый вклад в развитие общества и технологий.\", \"stats\": [{\"icon\": \"people\", \"color\": \"#4A90E2\", \"label\": \"Студентов\", \"value\": \"+2 500\"}, {\"icon\": \"auto_stories\", \"color\": \"#66BB6A\", \"label\": \"Специальностей\", \"value\": \"15\"}, {\"icon\": \"emoji_events\", \"color\": \"#FFA726\", \"label\": \"Лет истории\", \"value\": \"60+\"}, {\"icon\": \"business\", \"color\": \"#AB47BC\", \"label\": \"Партнёра\", \"value\": \"17\"}, {\"icon\": \"school\", \"color\": \"#26A69A\", \"label\": \"Трудоустройство\", \"value\": \"95%\"}, {\"icon\": \"groups\", \"color\": \"#EF5350\", \"label\": \"Преподавателей\", \"value\": \"150+\"}, {\"icon\": \"\", \"color\": \"#FFFFFF\", \"label\": \"\", \"value\": \"\"}, {\"icon\": \"\", \"color\": \"#FFFFFF\", \"label\": \"\", \"value\": \"\"}], \"advantages\": [{\"icon\": \"rocket_launch\", \"text\": \"Уникальные специальности, связанные с авиацией и ракетно-космической техникой, которые есть далеко не в каждом колледже.\", \"color\": \"#283593\", \"title\": \"Аэрокосмическое наследие\"}, {\"icon\": \"computer\", \"text\": \"Программирование, кибербезопасность, системное администрирование — востребованные специальности с высоким спросом на рынке труда.\", \"color\": \"#0288D1\", \"title\": \"Современные IT-направления\"}, {\"icon\": \"handshake\", \"text\": \"Производственная практика на реальных предприятиях. Наши партнёры — КрасМаш, РЕШЕТНЁВ, ОКБ «Зенит» — берут выпускников на работу.\", \"color\": \"#2E7D32\", \"title\": \"Связь с индустрией\"}, {\"icon\": \"trending_up\", \"text\": \"Центр карьеры помогает с трудоустройством, стажировками и развитием профессиональных навыков ещё во время обучения.\", \"color\": \"#E65100\", \"title\": \"Карьерный рост\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#F1F1F3\", \"title\": \"\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#FFFFFF\", \"title\": \"\"}], \"about_title\": \"О нас\", \"achievements\": [{\"icon\": \"military_tech\", \"text\": \"Студенты колледжа регулярно занимают призовые места в региональных и национальных чемпионатах WorldSkills по компетенциям «Сетевое администрирование», «Мехатроника» и «Сварочные технологии».\", \"color\": \"#FFA726\", \"title\": \"Победители WorldSkills Russia\"}, {\"icon\": \"workspace_premium\", \"text\": \"Все образовательные программы прошли государственную аккредитацию. Выпускники получают дипломы государственного образца, признаваемые по всей России.\", \"color\": \"#4A90E2\", \"title\": \"Аккредитация и лицензии\"}, {\"icon\": \"science\", \"text\": \"Ежегодно студенты участвуют в научных конференциях и инженерных конкурсах, представляя проекты по робототехнике, программированию и 3D-моделированию.\", \"color\": \"#66BB6A\", \"title\": \"Научно-техническое творчество\"}, {\"icon\": \"diversity_3\", \"text\": \"Более 10 кружков и секций: от спортивных команд до IT-клуба и инженерного общества. Регулярные фестивали, соревнования и волонтёрские проекты.\", \"color\": \"#AB47BC\", \"title\": \"Активная студенческая жизнь\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#FFFFFF\", \"title\": \"\"}, {\"icon\": \"\", \"text\": \"\", \"color\": \"#FFFFFF\", \"title\": \"\"}], \"mission_title\": \"Наша миссия\", \"stats_heading\": \"Колледж в цифрах\", \"advantages_heading\": \"Почему выбирают нас\", \"infrastructure_text\": \"Колледж располагает современными учебными корпусами, оснащёнными лабораториями и мастерскими:\\r\\n• Компьютерные классы с лицензионным ПО\\r\\n• Лаборатории робототехники и мехатроники\\r\\n• Сварочные мастерские с современным оборудованием\\r\\n• Лаборатории электротехники и измерительных приборов\\r\\n• Авиационный ангар для практических занятий\\r\\n• Библиотека с электронными ресурсами\\r\\n• Спортивный зал и площадки\", \"achievements_heading\": \"Наши достижения\", \"infrastructure_heading\": \"Инфраструктура\"}', '/api/public/uploads/img_20260414_053512_5a612802c03d.jpg', 1, NULL, NULL, NULL, 1, '2026-04-14 05:34:34');

-- --------------------------------------------------------

--
-- Структура таблицы `partners`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `partners`;
CREATE TABLE `partners` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `website_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `partners`
--

INSERT INTO `partners` (`id`, `name`, `description`, `website_url`, `logo_url`, `sort_order`, `is_published`, `created_at`) VALUES
(2, 'АО «Красмаш»', 'Красноярский машиностроительный завод', 'https://www.krskmz.ru/news/news.aspx', '/api/public/uploads/partners/krasmash.png', 1, 0, '2026-04-10 12:42:45'),
(3, 'АО «РЕШЕТНЁВ»', 'Спутниковые системы и космические аппараты', 'https://www.iss-reshetnev.ru/', '/api/public/uploads/partners/reshetnev.png', 2, 1, '2026-04-10 12:42:45'),
(4, 'АО «НПП «Радиосвязь»»', 'Высокотехнологичное предприятие связи', 'https://krtz.su/', '/api/public/uploads/partners/radiosvyaz.png', 3, 1, '2026-04-10 12:42:45'),
(5, 'АО «ОКБ Зенит»', 'Опытно-конструкторское бюро', 'https://www.zenith.ru/', '/api/public/uploads/partners/zenith.png', 4, 1, '2026-04-10 12:42:45'),
(6, 'АО «ЦКБ «Геофизика»»', 'Центральное конструкторское бюро', 'https://www.geockb.ru/', '/api/public/uploads/partners/geofizika.png', 5, 1, '2026-04-10 12:42:45'),
(7, 'ООО «КРАМЗ»', 'Красноярский алюминиево-металлургический завод', 'https://www.aluminas.ru/association/the-registry/kramz/', '/api/public/uploads/partners/kramz.png', 6, 1, '2026-04-10 12:42:45'),
(8, 'ФГУП «ГХК»', 'Горно-химический комбинат', 'https://sibghk.ru/', '/api/public/uploads/partners/ghk.png', 7, 1, '2026-04-10 12:42:45'),
(9, 'ООО «РН-Ванкор»', 'Нефтегазодобывающее предприятие', 'https://vankorneft.orgs.biz/', '/api/public/uploads/partners/vankor.png', 8, 1, '2026-04-10 12:42:45'),
(10, 'ПАО «Россети»', 'Электросетевая компания России', 'https://www.rosseti.ru/', '/api/public/uploads/partners/rosseti.png', 9, 1, '2026-04-10 12:42:45'),
(11, 'ООО «МегаВатт»', 'Энергетическая компания', 'https://mw-power.ru/company/', '/api/public/uploads/partners/megavatt.png', 10, 1, '2026-04-10 12:42:45'),
(12, 'ООО «Про Ток»', 'Электротехническая компания', 'https://pro-tok.pro/', '/api/public/uploads/partners/protok.png', 11, 1, '2026-04-10 12:42:45'),
(13, 'ООО «Апогей-БК»', 'Инженерная компания', 'https://apogey.ru/', '/api/public/uploads/partners/apogey.png', 12, 1, '2026-04-10 12:42:45'),
(14, 'ООО «АэроГЕО»', 'Аэрогеодезические работы', 'https://www.ag24.ru/', '/api/public/uploads/partners/aerogeo.png', 13, 1, '2026-04-10 12:42:45'),
(15, 'ООО «Форсайт»', 'IT и аналитические решения', 'https://www.fsight.ru/', '/api/public/uploads/partners/forsight.png', 14, 1, '2026-04-10 12:42:45'),
(16, 'АО «Енисейское речное пароходство»', 'Речной транспорт и логистика', 'https://www.e-river.ru/', '/api/public/uploads/partners/erp.png', 15, 1, '2026-04-10 12:42:45'),
(17, 'ООО «Аэропорт Емельяново»', 'Международный аэропорт Красноярска', 'https://www.kja.aero/', '/api/public/uploads/partners/emelyanov.png', 16, 1, '2026-04-10 12:42:45'),
(18, 'АО «ТК «РусГидро»»', 'Гидроэнергетическая компания', 'https://tk.rushydro.ru/activity/', '/api/public/uploads/partners/rushydro.png', 17, 1, '2026-04-10 12:42:45'),
(20, 'РУСАЛ', 'Партнёр по программам стажировок металлургии и энергетики.', 'https://rusal.ru/', '/api/public/uploads/partners/rusal.png', 4, 1, '2026-04-26 07:45:16'),
(21, 'РусГидро', 'Партнёр по энергетическим специальностям.', 'https://www.rushydro.ru/', '/api/public/uploads/partners/rushydro.png', 5, 1, '2026-04-26 07:45:16'),
(22, 'Полюс', 'Партнёр по инженерно-технологическим направлениям.', 'https://polyus.com/', '/api/public/uploads/partners/polyus.png', 6, 1, '2026-04-26 07:45:16'),
(23, 'Ванкорнефть', 'Партнёр направления «Нефтегазовая отрасль».', 'https://www.rosneft.ru/', '/api/public/uploads/partners/vankor.png', 7, 1, '2026-04-26 07:45:16'),
(24, 'КРАМЗ', 'Красноярский металлургический завод. Практика и трудоустройство.', 'https://kramz.ru/', '/api/public/uploads/partners/kramz.png', 8, 1, '2026-04-26 07:45:16'),
(25, 'НПП «Радиосвязь»', 'Партнёр по специальностям радиоэлектроники.', 'https://www.npp-radio.ru/', '/api/public/uploads/partners/radiosvyaz.png', 9, 1, '2026-04-26 07:45:16'),
(26, 'НПП «Геофизика»', 'Партнёр по приборостроительным направлениям.', 'https://www.geofizika.ru/', '/api/public/uploads/partners/geofizika.png', 10, 1, '2026-04-26 07:45:16'),
(27, 'АэроГео', 'Партнёр по авиационным направлениям.', 'https://www.aerogeo.ru/', '/api/public/uploads/partners/aerogeo.png', 11, 1, '2026-04-26 07:45:16'),
(28, 'Апогей', 'Партнёр по IT-практикам.', NULL, '/api/public/uploads/partners/apogey.png', 12, 1, '2026-04-26 07:45:16'),
(29, 'Емельянов и Ко', 'Партнёр по экономическим специальностям.', NULL, '/api/public/uploads/partners/emelyanov.png', 13, 1, '2026-04-26 07:45:16'),
(30, 'ERP-системы', 'Партнёр по программированию.', NULL, '/api/public/uploads/partners/erp.png', 14, 1, '2026-04-26 07:45:16'),
(31, 'Форсайт', 'Партнёр по информационным технологиям.', NULL, '/api/public/uploads/partners/forsight.png', 15, 1, '2026-04-26 07:45:16'),
(32, 'ГХК', 'Горно-химический комбинат. Партнёр по химико-технологическим направлениям.', 'https://www.sibghk.ru/', '/api/public/uploads/partners/ghk.png', 16, 1, '2026-04-26 07:45:16'),
(33, 'МегаВатт', 'Партнёр по электроэнергетическим специальностям.', NULL, '/api/public/uploads/partners/megavatt.png', 17, 1, '2026-04-26 07:45:16'),
(34, 'Микрон', 'Партнёр по микроэлектронике.', 'https://mikron.ru/', '/api/public/uploads/partners/mikron.png', 18, 1, '2026-04-26 07:45:16'),
(35, 'Проток', 'Партнёр по приборостроению.', NULL, '/api/public/uploads/partners/protok.png', 19, 1, '2026-04-26 07:45:17'),
(36, 'Зенит', 'Партнёр по машиностроению.', NULL, '/api/public/uploads/partners/zenith.png', 20, 1, '2026-04-26 07:45:17');

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 05 2026 г., 09:55
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int NOT NULL,
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `code`, `name`) VALUES
(1, 'guest', 'Guest'),
(2, 'applicant', 'Applicant'),
(3, 'student', 'Student'),
(4, 'staff', 'Staff'),
(5, 'admin', 'Admin'),
(33, 'admissions', 'Admissions office'),
(34, 'academic', 'Academic office'),
(35, 'content_manager', 'Content manager'),
(46, 'career_manager', 'Career center manager');

-- --------------------------------------------------------

--
-- Структура таблицы `site_settings`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `site_settings`;
CREATE TABLE `site_settings` (
  `key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `site_settings`
--

INSERT INTO `site_settings` (`key`, `value`) VALUES
('guest_home_blocks_json', '[{\"key\":\"stories\",\"title\":\"Истории\",\"enabled\":true,\"sort_order\":0},{\"key\":\"news\",\"title\":\"Новости\",\"enabled\":true,\"sort_order\":1},{\"key\":\"specialties\",\"title\":\"Специальности\",\"enabled\":true,\"sort_order\":2},{\"key\":\"career_guidance\",\"title\":\"Профориентация\",\"enabled\":true,\"sort_order\":3},{\"key\":\"about_college\",\"title\":\"О колледже\",\"enabled\":true,\"sort_order\":4},{\"key\":\"contacts\",\"title\":\"Контакты\",\"enabled\":true,\"sort_order\":5}]');

-- --------------------------------------------------------

--
-- Структура таблицы `specialties`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Апр 26 2026 г., 11:01
--

DROP TABLE IF EXISTS `specialties`;
CREATE TABLE `specialties` (
  `id` bigint NOT NULL,
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `duration_label` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `study_form_label` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qualification_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `career_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `skills_text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `salary_text` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_hex` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `publish_from` datetime DEFAULT NULL,
  `publish_to` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `specialties`
--

INSERT INTO `specialties` (`id`, `code`, `title`, `short_title`, `description`, `duration_label`, `study_form_label`, `qualification_text`, `career_text`, `skills_text`, `salary_text`, `icon_name`, `color_hex`, `image_url`, `sort_order`, `is_published`, `publish_from`, `publish_to`, `created_at`) VALUES
(5, '09.02.06', 'Сетевое и системное администрирование', 'Сетевое администрирование', 'Подготовка специалистов по настройке и сопровождению сетевой инфраструктуры.', '3 года 10 месяцев', 'Очная / Заочная', 'Сетевой и системный администратор', 'Системный администратор, сетевой инженер, DevOps-инженер, специалист технической поддержки', 'Linux/Windows Server, настройка сетей, виртуализация, мониторинг серверов', 'от 45 000 ₽', NULL, '#BE9A03', '/api/public/uploads/img_20260414_051057_156865bac2b6.jpg', 10, 1, NULL, NULL, '2026-04-14 03:17:01'),
(6, '09.02.07', 'Информационные системы и программирование', 'ИС и программирование', 'Разработка информационных систем, web и мобильных приложений.', '3 года 10 месяцев', 'Очная', 'Программист / Разработчик', 'Frontend/Backend-разработчик, мобильный разработчик, тестировщик ПО, аналитик', 'Python, Java, C#, SQL, HTML/CSS/JS, Git, алгоритмы и структуры данных', 'от 60 000 ₽', NULL, '#191A1C', '/api/public/uploads/img_20260426_135210_d59ed2eff064.jpg', 20, 1, NULL, NULL, '2026-04-14 03:17:01'),
(7, '10.02.03', 'Обеспечение информационной безопасности телекоммуникационных систем', 'ИБ телекоммуникаций', 'Защита информации в телекоммуникационных системах и сетях.', '2 года 10 месяцев', 'Очная', 'Техник по защите информации', 'Специалист по ИБ, пентестер, аналитик SOC, администратор средств защиты', 'Криптография, сетевая безопасность, анализ угроз, настройка МСЭ и IDS/IPS', 'от 55 000 ₽', NULL, '#00695C', '/api/public/uploads/img_20260426_135253_091898189f1e.jpg', 30, 1, NULL, NULL, '2026-04-14 03:17:01'),
(8, '10.02.04', 'Обеспечение информационной безопасности автоматизированных систем', 'ИБ автоматизированных систем', 'Защита автоматизированных информационных систем предприятия.', '2 года 10 месяцев', 'Очная', 'Техник по защите информации', 'Аудитор информационной безопасности, специалист по защите АСУ ТП, инженер ИБ', 'Аудит безопасности, управление доступом, SIEM-системы, анализ уязвимостей', 'от 55 000 ₽', NULL, '#2E7D32', '/api/public/uploads/img_20260426_135351_d501d85c22e7.jpg', 40, 1, NULL, NULL, '2026-04-14 03:17:01'),
(9, '13.02.11', 'Техническая эксплуатация и обслуживание электрического и электромеханического оборудования (по отраслям)', 'Электрооборудование', 'Подготовка специалистов по эксплуатации электрического оборудования.', '3 года 10 месяцев', 'Очная / Заочная', 'Техник-электромеханик', 'Электромеханик, наладчик электрооборудования, энергетик предприятия', 'Электрические схемы, наладка оборудования, ремонт электродвигателей, ПУЭ', 'от 40 000 ₽', NULL, '#F57F17', '/api/public/uploads/img_20260426_135641_550855912519.jpg', 50, 1, NULL, NULL, '2026-04-14 03:17:01'),
(10, '17.02.12', 'Специальные машины и устройства', 'Спецмашины и устройства', 'Проектирование, сборка и обслуживание специальных машин.', '3 года 10 месяцев', 'Очная', 'Техник-механик', 'Инженер-конструктор, техник по спецмашинам, мастер производственного участка', 'Черчение и САПР, обработка металлов, сборка механизмов, контроль качества', 'от 42 000 ₽', NULL, '#6A1B9A', '/api/public/uploads/img_20260426_135713_e12b5d32d96b.jpg', 60, 1, NULL, NULL, '2026-04-14 03:17:01'),
(11, '15.02.08', 'Технология машиностроения', 'Технология машиностроения', 'Технологии машиностроительного производства и ЧПУ.', '3 года 10 месяцев', 'Очная / Заочная', 'Техник-технолог', 'Технолог машиностроительного производства, оператор ЧПУ, мастер цеха', 'Программирование ЧПУ, технологические процессы, метрология, чтение чертежей', 'от 45 000 ₽', NULL, '#4E342E', '/api/public/uploads/img_20260426_135748_5069ef859e81.jpg', 70, 1, NULL, NULL, '2026-04-14 03:17:01'),
(12, '15.02.16', 'Мехатроника и мобильная робототехника (по отраслям)', 'Мехатроника и робототехника', 'Интеграция механики, электроники и программирования в робототехнике.', '3 года 10 месяцев', 'Очная', 'Техник-мехатроник', 'Инженер-робототехник, программист роботов, наладчик автоматизированных линий', 'Arduino/Raspberry Pi, программирование контроллеров, 3D-моделирование, сенсоры', 'от 50 000 ₽', NULL, '#0277BD', '/api/public/uploads/img_20260426_135840_ebdb8161ff3a.jpg', 80, 1, NULL, NULL, '2026-04-14 03:17:01'),
(13, '21.02.03', 'Сооружение и эксплуатация газонефтепроводов и газонефтехранилищ (прикладная геология, горное дело, нефтегазовое дело и геодезия)', 'Газонефтепроводы', 'Эксплуатация и обслуживание трубопроводного транспорта.', '3 года 10 месяцев', 'Очная / Заочная', 'Техник по эксплуатации трубопроводов', 'Оператор нефтеперекачивающей станции, техник-эксплуатационник, инженер ГНП', 'Трубопроводный транспорт, диагностика, сварочные работы, экология', 'от 55 000 ₽', NULL, '#558B2F', '/api/public/uploads/img_20260426_135859_ec3b6db4c2c9.jpg', 90, 1, NULL, NULL, '2026-04-14 03:17:01'),
(14, '22.02.06', 'Сварочное производство', 'Сварочное производство', 'Технологии сварки и контроль качества сварных соединений.', '3 года 10 месяцев', 'Очная', 'Техник-сварщик', 'Сварщик, инженер-технолог сварочного производства, контролёр качества', 'MIG/MAG, TIG, ручная дуговая сварка, дефектоскопия, чтение чертежей', 'от 50 000 ₽', NULL, '#BF360C', '/api/public/uploads/img_20260426_135918_5fdb6f74cd6c.jpg', 100, 1, NULL, NULL, '2026-04-14 03:17:01'),
(15, '25.02.04', 'Техническое обслуживание авиационных двигателей', 'Авиационные двигатели', 'Техническое обслуживание и ремонт авиационных двигателей.', '3 года 10 месяцев', 'Очная', 'Техник по авиационным двигателям', 'Авиатехник, инженер по ТО двигателей, специалист авиаремонтного завода', 'Газотурбинные двигатели, диагностика, авиационные материалы, регламент ТО', 'от 55 000 ₽', NULL, '#37474F', '/api/public/uploads/img_20260426_135937_15d2fd7d8193.jpg', 110, 1, NULL, NULL, '2026-04-14 03:17:01'),
(16, '12.02.11', 'Контроль работы измерительных приборов', 'Измерительные приборы', 'Метрологическое обеспечение и работа с измерительными приборами.', '2 года 10 месяцев', 'Очная', 'Техник-метролог', 'Метролог, контролёр ОТК, калибровщик, инженер по качеству', 'Метрология, поверка приборов, стандартизация, работа с эталонами', 'от 40 000 ₽', NULL, '#98A9B5', '/api/public/uploads/img_20260426_140048_69a52dba6a71.jpg', 120, 1, NULL, NULL, '2026-04-14 03:17:01'),
(17, '13.02.02', 'Электро‑ и теплоэнергетика', 'Электро- и теплоэнергетика', 'Эксплуатация энергетических сетей и тепловых установок.', '3 года 10 месяцев', 'Очная / Заочная', 'Техник-энергетик', 'Электромонтёр, энергетик, техник по обслуживанию ТЭЦ, диспетчер энергосистем', 'Электрические сети, тепловые установки, релейная защита, энергоаудит', 'от 45 000 ₽', NULL, '#8D6E63', '/api/public/uploads/img_20260426_140104_8e960051bf3b.jpg', 130, 1, NULL, NULL, '2026-04-14 03:17:01'),
(18, '25.02.05', 'Аэронавигация и эксплуатация авиационной и ракетно‑космической техники', 'Аэронавигация и РКТ', 'Подготовка специалистов авиационно-космической отрасли.', '3 года 10 месяцев', 'Очная', 'Техник по авиационной и РК технике', 'Техник аэронавигации, инженер РКТ, специалист космодрома, авиадиспетчер', 'Аэродинамика, навигационные системы, радиоэлектроника, ракетные двигатели', 'от 55 000 ₽', NULL, '#1565C0', '/api/public/uploads/img_20260426_140118_9a8b88337e01.jpg', 140, 1, NULL, NULL, '2026-04-14 03:17:01'),
(19, '38.02.01', 'Экономика и бухгалтерский учет', 'Экономика и бухучёт', 'Экономическое сопровождение и бухгалтерский учет организаций.', '2 года 10 месяцев', 'Очная / Заочная', 'Бухгалтер / Экономист', 'Бухгалтер, экономист, аудитор, финансовый аналитик, налоговый консультант', '1С:Бухгалтерия, налогообложение, финансовый анализ, Excel, отчётность', 'от 35 000 ₽', NULL, '#2E7D32', '/api/public/uploads/img_20260426_140133_fdb23bf90688.jpg', 150, 1, NULL, NULL, '2026-04-14 03:17:01');

-- --------------------------------------------------------

--
-- Структура таблицы `specialty_curriculum`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `specialty_curriculum`;
CREATE TABLE `specialty_curriculum` (
  `id` bigint NOT NULL,
  `specialty_id` bigint NOT NULL,
  `semester` tinyint NOT NULL,
  `discipline_id` bigint NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `staff_members`
--
-- Создание: Май 05 2026 г., 09:55
-- Последнее обновление: Май 06 2026 г., 14:09
--

DROP TABLE IF EXISTS `staff_members`;
CREATE TABLE `staff_members` (
  `id` bigint NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_hours` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department` enum('admin','academic','career_center','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `photo_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_hex` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `staff_members`
--

INSERT INTO `staff_members` (`id`, `full_name`, `position_title`, `email`, `phone`, `office_hours`, `department`, `photo_url`, `color_hex`, `sort_order`, `is_published`, `created_at`) VALUES
(1, 'Тимошев Павел Викторович', 'Директор', 'ak@sibsau.ru', '2919115', 'Часы приёма: вторник, четверг с 14:00 до 16:00', 'other', '/api/public/uploads/img_20260426_054805_1bd11404147f.jpg', '#0091FF', 0, 1, '2026-04-10 08:29:58'),
(2, 'Шувалова М.А.', 'Заместитель директора по учебно-методической работе', 'shuvalovav@sibsau.ru', '+7(391) 291-91-15', 'Часы приёма: понедельник, среда с 10:00 до 12:00', 'other', '/api/public/uploads/img_20260413_221103_317a64489856.jpg', NULL, 1, 1, '2026-04-10 08:29:58'),
(5, 'Позновский В.А.', 'Заместитель директора по Учебно-производственной работе', 'sidorova@sibsau.ru', '2641588', 'Часы приёма: понедельник, пятница с 14:00 до 16:00', 'other', '/api/public/uploads/img_20260413_221226_379e3bf1c713.jpg', NULL, 3, 1, '2026-04-13 22:06:39'),
(6, 'Козырева С.В.', 'Заместитель директора по внебюджетной деятельности', 'kozyrevasv@sibsau.ru', '+7(391) 291-91-15', 'Часы приёма: среда с 10:00 до 12:00', 'other', '/api/public/uploads/img_20260413_221214_605b16fef120.jpg', NULL, 4, 1, '2026-04-13 22:06:39'),
(7, 'Курдояк Е.Д.', 'Заведующая отделением №1 Направление: «Технология машиностроения»', 'students@sibsau.ru', '+7 (391) 264-15-88', 'Часы приёма: вторник с 14:00 до 16:00', 'other', '/api/public/uploads/img_20260413_221244_5f756cc4454b.jpg', NULL, 5, 1, '2026-04-13 22:06:39'),
(8, 'Малиновская Е.А.', 'Заведующая отделением №2 Направления: «Сварочное производство» «Контрольно-измерительные приборы и автоматика» «Эксплуатация летательных аппаратов»', 'students@sibsau.ru', '+7 (391) 264-15-88', 'Часы приёма: четверг с 10:00 до 12:00', 'other', '/api/public/uploads/img_20260413_221258_b7de3204a3b7.jpg', NULL, 6, 1, '2026-04-13 22:06:39'),
(9, 'Кольга Е.В.', 'Заведующая отделением №5 Направление: «Безопасность автоматизированных систем» «Информационные системы и технологии»', 'students@sibsau.ru', '+7 (391) 264-15-88', 'Часы приёма: понедельник с 14:00 до 16:00', 'other', NULL, NULL, 7, 1, '2026-04-13 22:06:39'),
(10, 'Гурьянов А.С.', 'Заведующий отделением №6 Направление: «Специальные машины и устройства» «Мобильная робототехника» «Автоматические системы управления»', 'kuznetsov@sibsau.ru', '2640664', 'Часы приёма: ежедневно с 09:00 до 12:00', 'other', NULL, NULL, 8, 1, '2026-04-13 22:06:39'),
(11, 'Коткова Е.А.', 'Заведующий отделением №7 Направление: «Безопасность автоматизированных систем» «Информационные системы и технологии»', 'lebedeva@sibsau.ru', '+7 (391) 264-15-88', 'Часы приёма: ежедневно с 09:00 до 16:00', 'other', NULL, NULL, 9, 1, '2026-04-13 22:06:39'),
(12, 'Букалина Д.А.', 'Заведующий отделением №8 Направление: «Сетевое администрирование» «Программирование и программное обеспечение»', 'sokolov@sibsau.ru', '2640666', 'Часы приёма: среда, пятница с 10:00 до 14:00', 'other', NULL, NULL, 10, 1, '2026-04-13 22:06:39'),
(14, 'Позновский В.А.', 'Заместитель директора по Учебно-производственной работе', 'sidorova@sibsau.ru', '2641588', 'Часы приёма: понедельник, пятница с 14:00 до 16:00', 'other', '/api/public/uploads/contacts/staff_3.png', NULL, 4, 1, '2026-04-26 07:46:13'),
(15, 'Козырева С.В.', 'Заместитель директора по внебюджетной деятельности', 'kozyrevasv@sibsau.ru', '+7(391) 291-91-15', 'Часы приёма: среда с 10:00 до 12:00', 'other', '/api/public/uploads/contacts/staff_4.png', NULL, 5, 1, '2026-04-26 07:46:13'),
(16, 'Курдояк Е.Д.', 'Заведующая отделением №1 Направление: «Технология машиностроения»', 'students@sibsau.ru', '+7 (391) 264-15-88', 'Часы приёма: вторник с 14:00 до 16:00', 'other', '/api/public/uploads/contacts/staff_5.png', NULL, 6, 1, '2026-04-26 07:46:13'),
(17, 'Малиновская Е.А.', 'Заведующая отделением №2 Направления: «Сварочное производство» «Контрольно-измерительные приборы и автоматика» «Эксплуатация летательных аппаратов»', 'students@sibsau.ru', '+7 (391) 264-15-88', 'Часы приёма: четверг с 10:00 до 12:00', 'other', '/api/public/uploads/contacts/staff_6.png', NULL, 7, 1, '2026-04-26 07:46:13'),
(18, 'Кольга Е.В.', 'Заведующая отделением №5 Направление: «Безопасность автоматизированных систем» «Информационные системы и технологии»', 'students@sibsau.ru', '+7 (391) 264-15-88', 'Часы приёма: понедельник с 14:00 до 16:00', 'other', NULL, NULL, 8, 1, '2026-04-26 07:46:13'),
(19, 'Гурьянов А.С.', 'Заведующий отделением №6 Направление: «Специальные машины и устройства» «Мобильная робототехника» «Автоматические системы управления»', 'kuznetsov@sibsau.ru', '2640664', 'Часы приёма: ежедневно с 09:00 до 12:00', 'other', NULL, NULL, 9, 1, '2026-04-26 07:46:13'),
(20, 'Коткова Е.А.', 'Заведующий отделением №7 Направление: «Безопасность автоматизированных систем» «Информационные системы и технологии»', 'lebedeva@sibsau.ru', '+7 (391) 264-15-88', 'Часы приёма: ежедневно с 09:00 до 16:00', 'other', NULL, NULL, 10, 1, '2026-04-26 07:46:13'),
(21, 'Букалина Д.А.', 'Заведующий отделением №8 Направление: «Сетевое администрирование» «Программирование и программное обеспечение»', 'sokolov@sibsau.ru', '2640666', 'Часы приёма: среда, пятница с 10:00 до 14:00', 'other', NULL, NULL, 11, 1, '2026-04-26 07:46:13');

-- --------------------------------------------------------

--
-- Структура таблицы `stories`
--
-- Создание: Апр 27 2026 г., 02:36
--

DROP TABLE IF EXISTS `stories`;
CREATE TABLE `stories` (
  `id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `images_json` mediumtext COLLATE utf8mb4_unicode_ci,
  `sort_order` int NOT NULL DEFAULT '0',
  `publish_from` datetime DEFAULT NULL,
  `publish_to` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `stories`
--

INSERT INTO `stories` (`id`, `title`, `content`, `image_url`, `images_json`, `sort_order`, `publish_from`, `publish_to`, `is_published`, `created_at`) VALUES
(55, '⚡️ Хоккей с дронами? Почему бы и нет!', 'Пока на льду «Платинум Арены» боролись за Кубок АО «Красмаша» среди любительских хоккейных команд (25–26 апреля), за пределами бортика Аэрокосмический колледж знакомил гостей с авиацией будущего.\r\n\r\nСамые смелые проходили тест-драйв на симуляторах БПЛА, а заодно получали консультацию о поступлении в колледж. Получилось ярко, молодёжно и с пользой для профориентации.\r\n\r\n#Красмаш #хоккей #АэрокосмическийКолледж #дроны #профориентация', 'https://sun9-32.userapi.com/s/v1/ig2/oZG2Gbpgztazp57EnTV42e3b-hx8rtJyTpwe7DQK59p4YERiCc-tVnJH7qpIpy2LyQg5MNGqDyWbHZyH8BmfUVLl.jpg?quality=95&as=32x22,48x33,72x49,108x73,160x108,240x163,360x244,480x325,540x366,640x434,720x488,1080x732,1280x868,1440x976,2560x1736&from=bu&u=7XIEbYeL9wcRupanGPFoNuOcqmNeRD0deobwYUybTFQ', '[\"https://sun9-32.userapi.com/s/v1/ig2/oZG2Gbpgztazp57EnTV42e3b-hx8rtJyTpwe7DQK59p4YERiCc-tVnJH7qpIpy2LyQg5MNGqDyWbHZyH8BmfUVLl.jpg?quality=95&as=32x22,48x33,72x49,108x73,160x108,240x163,360x244,480x325,540x366,640x434,720x488,1080x732,1280x868,1440x976,2560x1736&from=bu&u=7XIEbYeL9wcRupanGPFoNuOcqmNeRD0deobwYUybTFQ\",\"https://sun9-48.userapi.com/s/v1/ig2/Uf8lX2My42Ndg1gl1WWtU3LnuI6xUpOsOhzJC3-RBXBvaeqqZ9lrJM7Ui_-z8d8BARAF7yT9dASbcXXiQtuDPoTd.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=HE-eWHJlmNnFTyEhyDkS60iLzZzrVBgo1ZXuD0jI3pE\",\"https://sun9-6.userapi.com/s/v1/ig2/T4YuR5Q3PpCNd3BiSqHIeeUOBzP2_pg5qbnX0HwApyemcOba3jtPmSfbq0je26dbtUZ50kpv0WbfaEBZak1F2a3g.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=WZQmFDKtnXwoEjVvWpW_3aLIoVKjOKtInJVttT02UF0\",\"https://sun9-77.userapi.com/s/v1/ig2/vxPe-u5GxB4fG5GXoXzEPThsTMS4ZnXzJumWAsp0hSB_1kjryFGbqGd37Sfczu9NNKiDtwZSLoZblDKOtfdMGfhl.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=Bs39GtHG0omRyjjG6utIctG05_U84HNPU-qfRFHWXYA\",\"https://sun9-48.userapi.com/s/v1/ig2/OYfgpkXeqRoa-2qEWGHzsxP90yTP9rDvtDUyzjaILNWe7uI46aQNOKo-Z-K_HkaZ5GnZDkA5LnTGbsQ8TyPL-en-.jpg?quality=95&as=32x36,48x54,72x81,108x121,160x179,240x269,360x403,480x537,540x604,640x716,720x806,1080x1209,1280x1433,1440x1612,2287x2560&from=bu&u=hnu_-659ZY6P-vOauxaj59BaWDj5NEaMpOSDbN8SDgM\",\"https://sun9-77.userapi.com/s/v1/ig2/cDbMDy19UIify7lozx9248JIZjczJP0ZIxLU48isgFmdLcYPvipRu_nZSJrvjOigEPfykeH2jkYNxq1PPHGWx4-3.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=yRDxJx-299zA8r2emuKnDMaCKwgHWRWcXMlsfKEhc3Y\",\"https://sun9-77.userapi.com/s/v1/ig2/4LvuMCP6lnyIFW7CN82BUskwPhb_VcTB1OYeL4UwNt8uQ_5lndgnyyd4T8xX_ooc7xVSZqzfUhilMGiFHS8wYN64.jpg?quality=95&as=32x38,48x57,72x86,108x128,160x190,240x285,360x428,480x570,540x642,640x761,720x856,1080x1284,1280x1521,1440x1711,2154x2560&from=bu&u=ZVsd6WJQ8LyVcoF_OR661sT8dSRbyb-UeRmyF6LQDtE\"]', 1, NULL, NULL, 1, '2026-04-27 16:20:32'),
(56, '🎭 Пятница — день культурного десанта!', '🎭 Пятница — день культурного десанта!\r\n\r\nВот как здорово завершить рабочую неделю: не дома за сериалом, а в СДК — на рэп-спектакле по Пушкину!\r\n\r\nСтуденты Аэрокосмического колледжа и Университета Решетнева вместе провели вечер пятницы в СДК. Смотрели «Барышню-крестьянку» — но не классическую, а от артистов ТЮЗа.\r\n\r\nИ это было круто! 🔥\r\n\r\n📖 По мотивам «Повестей покойного Ивана Петровича Белкина» — получилось остроумно, ритмично и максимально близко к современному зрителю. Рэп, драйв, знакомые герои в новом прочтении — всем без исключения зашло!\r\n\r\nСтуденты в полном восторге! \r\nПушкин зазвучал по-новому — современно, дерзко и со смыслом. \r\nТакие форматы доказывают: классика жива! \r\n\r\nВсем советуем! 🔥\r\n\r\n#Аэрокосмический #Решетнев #Пушкин #РэпСпектакль#БарышняКрестьянка #ТЮЗ #Пушкин', 'https://sun9-87.userapi.com/s/v1/ig2/deNlI6HVw3H2XDJUWMk-BlME5b5pf3ZfBHPf4gBIi-42WeGHj0pbaKp1UrM4YcA4Ecbrg0e_wGH44wa8YcIL893R.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2451x1838&from=bu&u=yWXOorehAxgNMOUxXClW3gbCJwuZnnYzOeCopDmA6-g', '[\"https://sun9-87.userapi.com/s/v1/ig2/deNlI6HVw3H2XDJUWMk-BlME5b5pf3ZfBHPf4gBIi-42WeGHj0pbaKp1UrM4YcA4Ecbrg0e_wGH44wa8YcIL893R.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2451x1838&from=bu&u=yWXOorehAxgNMOUxXClW3gbCJwuZnnYzOeCopDmA6-g\",\"https://sun9-29.userapi.com/s/v1/ig2/r8TnMaMfqK8JmH7R27NFmXOGQjSkMYOqULP8KkQB28fP1RVvnu0AxFm4odk_H4e1Z_i06YYbkoVnfqTKdnQQ_lis.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,1852x1389&from=bu&u=6wzq14QqfS5-lkS4XMYbFUffkTEsd75gqqVkAYlJan8\",\"https://sun9-11.userapi.com/s/v1/ig2/TevwB0_WaNSCgRxpL02yh16oM56_MAXWp7KDs8VyiebyFPnLYt3agONNS1IekAwApE-kyi7RJQH_uvKEBHC_mQty.jpg?quality=95&as=32x16,48x24,72x37,108x55,160x81,240x122,360x183,480x244,540x274,640x325,720x366,1075x546&from=bu&u=JhIhWnB-eNRe7QK6_vREmhztoxXBs8CkaPmwGln_St4\"]', 2, NULL, NULL, 1, '2026-04-27 17:21:47'),
(57, '📢 Профориентация в действии: встреча с экспертами «Центра занятости»', 'Сегодня в Аэрокосмическом колледже прошло важное событие для наших студентов 4 курса (5 отделения). В рамках цикла профориентационных мероприятий мы принимали представителей «Центра занятости».\r\n\r\n🎯 Как это было?\r\nСпециалисты центра провели со студентами не просто беседу, а полноценную диагностику. Ребята прошли профессиональное тестирование, которое позволило оценить их актуальные навыки, карьерные возможности и личные приоритеты.\r\n\r\n💼 Почему это важно?\r\nВыпуск 4 курса уже не за горами. Понимание своих сильных сторон и зон роста, а также осознанный выбор первых шагов в карьере — залог успешного трудоустройства. Тестирование помогло каждому участнику взглянуть на себя как на будущего специалиста объективно.\r\n\r\n🤝 Благодарим «Центр занятости» за продуктивную работу и индивидуальный подход к нашим студентам.\r\n\r\nВпереди — новые встречи и возможности. Будьте в курсе событий колледжа, чтобы не пропустить стажировки и вакансии от партнёров!\r\n\r\n#АэрокосмическийКолледж #Профориентация #Студенты4Курса #ЦентрЗанятости', 'https://sun1-20.userapi.com/s/v1/ig2/aqllW4nBDQtwdwoMLFIWl0uAG7bxs4b1oIF7lNY5wglQ8jJP_K27KgmGIEPKASPkQiseLFEvR9QToTrVw6N7LtrE.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=lf4QO2KAr7D8dnI6tXcdyL7ML8X4q3ulJAVQ10ujX0I', '[\"https://sun1-20.userapi.com/s/v1/ig2/aqllW4nBDQtwdwoMLFIWl0uAG7bxs4b1oIF7lNY5wglQ8jJP_K27KgmGIEPKASPkQiseLFEvR9QToTrVw6N7LtrE.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=lf4QO2KAr7D8dnI6tXcdyL7ML8X4q3ulJAVQ10ujX0I\",\"https://sun1-86.userapi.com/s/v1/ig2/rI0OGR6Up2jxnnJbDt6NVorE9taJgqG6kltyFmv1Cc5yPbOy601sWJ3EvdWPbMQ9w_ZRyWRQU4UlPNPG5Xk5200R.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=JOZCViq7rsfTy_dVhlgUS8AbjpvU_KBABGc5HQaN-ds\",\"https://sun1-55.userapi.com/s/v1/ig2/SWJuU66vtO44cJQPuW5HVBY-gGMs5fLdwAvjnKVad7Ti99Bri6-YOC1So5tG6atWzHIB7oiby4A5eJQR2Ca4kkFP.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=L9gx4xXr3fbQj7BHxA7r_NTrAvEiThk0W8S3cl897r4\",\"https://sun1-56.userapi.com/s/v1/ig2/iYxCWNt3jtcXpB6IziQty_2z-MUZ0dMM_gFF33wUVDG3WECYUQ-yINpNbJD2f8GZS8oPygKO9yqb_h7YDdogbILu.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=xuBZ0A12UpzSKM1qtg5eNGC8hJAb0FO4HFriiBLXwNY\"]', 3, NULL, NULL, 1, '2026-04-29 12:00:42'),
(58, '🔌 НАПРЯЖЕНИЕ БЫЛО МАКСИМАЛЬНЫМ!', 'Сегодня прошёл финал игры «Под напряжением» в формате КВИЗа 🔥\r\n\r\nВ финале участвовало 16 человек, а начинало всё 15 команд! Игра прошла по-настоящему напряжённо, ответственно, а студенты выложились на все 100% 💯\r\n\r\nРады объявить победителей:\r\n\r\n🥇 1 место — Манылов И. Е. (ТАД-9-24)\r\n🥈 2 место — Прудникова С. М. (МР-10-24)\r\n🥉 3 место — Дубов М. В. (ЭЛ-51-24)\r\n\r\nОтдельная благодарность ребятам из ИТ-13-23, которые помогали организовать мероприятие:\r\n\r\n👏 Гапонько М. Е.\r\n👏 Волкова Ю. В.\r\n👏 Петришина Л. Г.\r\n👏 Андреева Д. А.\r\n👏 Телеутова А. Д.\r\n👏 Момотов И. В.\r\n👏 Сомов А. И.\r\n\r\nИ, конечно же, огромное спасибо Площинской Ксении Сергеевне .\r\n\r\nПоздравляем победителей и благодарим всех, кто был с нами! Дальше — больше 💪⚡', 'https://sun9-27.userapi.com/s/v1/ig2/Zsr4o3jkrZxGJWfDHc5_FJwPttBH7hruEpfdzHUCJucEHUlnbUD3h7F_6T8Xkgyw3N2uyWRhSVuTf7yrmUMGLGbV.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1040x780&from=bu&u=UNkGML2ZDFTEqL2HJCAn7o0GNWPLFZy5dSWrjb5P4qk', '[\"https://sun9-27.userapi.com/s/v1/ig2/Zsr4o3jkrZxGJWfDHc5_FJwPttBH7hruEpfdzHUCJucEHUlnbUD3h7F_6T8Xkgyw3N2uyWRhSVuTf7yrmUMGLGbV.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1040x780&from=bu&u=UNkGML2ZDFTEqL2HJCAn7o0GNWPLFZy5dSWrjb5P4qk\",\"https://sun9-61.userapi.com/s/v1/ig2/DQTW8RyHtKL6BtzPDs4zceDHd-KsnI6E77Szx9W-siuw4K3eePZg8yrz1mdQrSrE_b0lCBTNIG8MpGAyScKUYNKQ.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,768x1024&from=bu&u=GB3olJPEY1MzxGs0tw_yBwPTcloWds00Q9CbPJ5SmiA\",\"https://sun9-64.userapi.com/s/v1/ig2/lrTKUKkBmVjsUuW4DQLo7b8x0zGz12-wcNgWnoOUXXC89YEoMXzyTskp76djF4rPdUJ1GWNTIT3kBjNNoZKNISp_.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,768x1024&from=bu&u=6P0j-ZDpCIkyOvWk07jS1WaHXQYcytbs0yjZtOq95Wk\",\"https://sun9-78.userapi.com/s/v1/ig2/eLCiYW4uMSNADr262xhSNU1ifceajfUuwv5aG1ct2rfTMrKMVSwxqsSw5uh0litHM5a_tI7eLFpxc8WHz1qqOnnD.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1251x1668&from=bu&u=4C1ORv7VhFaI_SzldEprOMmVbSJ4eyikDkMcswUAZPw\"]', 4, NULL, NULL, 1, '2026-04-29 12:00:52'),
(59, '🚀 В Красноярске стартовал крутой профориентационный фестиваль «БАСВокругНас»!', '28-29 апреля в Центре опережающей профессиональной подготовки Красноярского края проходит традиционный фестиваль, посвящённый беспилотным авиационным системам.\r\n\r\n🎯 Цель мероприятия: помочь школьникам и студентам сориентироваться в мире современных профессий и узнать о карьерных возможностях в авиационной отрасли.\r\n\r\n📍 Участники:\r\nСтуденты Аэрокосмического колледжа под руководством преподавателя Лысенко Алексея Михайловича принимают самое активное участие в работе фестиваля. \r\nРебята не только знакомятся с новыми технологиями, но и делятся своим опытом с младшими участниками.\r\n Активно участвуют, заряжают энергией и показывают, где учиться на профессию будущего.', 'https://sun9-65.userapi.com/s/v1/ig2/zHn8HibIcApk4zNEg-fbOXM_8p30MopSKOMgyXlY09ss3cEq3vhsBbGH_B2-Vhy72MsEj_lTYbmyJdqvsnMADfxK.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x303,640x359,720x404,1080x607,1280x719&from=bu&u=l5uD41FV6v1fZl9W-I9WTze1O-KXaZuppmjeybuSms0', '[\"https://sun9-65.userapi.com/s/v1/ig2/zHn8HibIcApk4zNEg-fbOXM_8p30MopSKOMgyXlY09ss3cEq3vhsBbGH_B2-Vhy72MsEj_lTYbmyJdqvsnMADfxK.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x303,640x359,720x404,1080x607,1280x719&from=bu&u=l5uD41FV6v1fZl9W-I9WTze1O-KXaZuppmjeybuSms0\",\"https://sun9-50.userapi.com/s/v1/ig2/BxuGMuSLm5NgjZxUbEH2JHkDwq9A6DeytwLUisypUhb3X847YB187BLnehLivYNunFB3clV7ujIb929j10IhGg7I.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=v5YGfPJQ_fA47wMzP7vPqtER-4oBb1eI_D7Pa3AmHMU\",\"https://sun9-53.userapi.com/s/v1/ig2/zDdwYejjBq26G6tI8Orcir3f6bmpAsJ2E1u9i7hoiw1HCB2vBmuUW_KCpNmXYXiSFFFROXhoDB8cjy4br19PlDbg.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=Rq1_vJkuU89Zd8H3MVf8gqEKylO52-Qk2xzADhdj5GI\",\"https://sun9-45.userapi.com/s/v1/ig2/0R2VCOgBH83sPeAa0t852Saufvfv6vhZGRiZv6szSLTnMhJor1IvwY8yuQ2NpBXSLLndOz1MqHhbnTFh6lOF17Px.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=4pT1TTCG055ywkqPlZp_odgBIWeh06gont1M11pvmws\",\"https://sun9-83.userapi.com/s/v1/ig2/NZLC_VBw12iuo1QEPuwCKtE5US0b1S0Jn0XNFq_i0BTXnFOOgnwYEDXu2iNugX4nBvGR3iXE_YNBUiKC9C111UoS.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=ySIAiRPLq4dIym8xgpDnF9RYgxflKFliiRdL2M4rIBs\",\"https://sun9-15.userapi.com/s/v1/ig2/g-A0yStBGAr7vruLIOsBIU1n7ku4QWDo0PX-pAJ-3_q_LzFj2PAlWCq5DZBxlTNwfafZzzj4wia5rS3CtlM5d7Kq.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707&from=bu&u=JuA9yXCw8b67aYkEDKghvjIGVcAy1SZGGWWktV6q7QA\",\"https://sun9-85.userapi.com/s/v1/ig2/GJjHE27l82et7Hslb9xVlLWCh8titHvkm78AgCdn1bTYwzRRPnQOB246P-sI1oWTL8OwZ_q7AvovtyyF1YaJCzyM.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707&from=bu&u=8zVaqxvyF5vfT3l64WvjkaUsM9oT0ObzktKssJNa0y8\",\"https://sun9-6.userapi.com/s/v1/ig2/cZr8065o3hEHUgiE12Z3S5W4Jj47dLeixkj8CjH_rDKEnuiilXRVZwqcH4fTz9pvchz5NdMSh9ht_ppG_4szUge4.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707&from=bu&u=1tQL5mEy9qA16sjNllAjjqL_xvvSRM5nJvRfgti-rmU\",\"https://sun9-25.userapi.com/s/v1/ig2/bPnkxldLgi7I-dvktnpLIzfgva0s5VgCLgyGRqskzkAmnhpNOngYPNVS1kzZeTyWLmLq46uALGitfkh_xHiaH2z3.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707&from=bu&u=xyT2o3yplZbHH11dFsNJpYR55jhBKGczWc6PNmIgnjA\"]', 5, NULL, NULL, 1, '2026-04-29 12:01:10'),
(60, '«Диктант Победы»: даже на МКС, но и наши студенты — в строю', 'Восьмой раз по всей стране и за её пределами проходит «Диктант Победы». Масштаб акции впечатляет: уникальные площадки в этом году — Международная космическая станция, космодром Плесецк, ледоколы, поезда и даже борта самолётов. Партнёром диктанта традиционно выступает Российское военно-историческое общество (РВИО).\r\n\r\nСтуденты Аэрокосмического колледжа, конечно, не могли остаться в стороне. Ребята из групп ТМ-94-24 и ИТ-17-25 тоже проверили свои знания об истории Великой Отечественной войны.\r\n\r\nГордимся их выбором. Помним. И передаём память дальше. 🕯️', 'https://sun9-37.userapi.com/s/v1/ig2/unbpuRujkNzzPSWy4_POJdvcDrrRMF_a5UpY1YtUrzsv3BkAVqNLtrxwhuu4v6oAqcFayN6d3xIzFCbSU46RE9WN.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=mSTTyzWqxY4q93l-VM75EcUvWFPSENC89orCa_qghCM', '[\"https://sun9-37.userapi.com/s/v1/ig2/unbpuRujkNzzPSWy4_POJdvcDrrRMF_a5UpY1YtUrzsv3BkAVqNLtrxwhuu4v6oAqcFayN6d3xIzFCbSU46RE9WN.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=mSTTyzWqxY4q93l-VM75EcUvWFPSENC89orCa_qghCM\",\"https://sun9-16.userapi.com/s/v1/ig2/ZwLbNB5wY2cm7teQ8Gxwt-XDqAzv59harN_36NlyWOvJiJRc9H_btV8Zl46bY0dY82-58hU8sX81_yr7c84Cff6n.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=6MdvovAZGrI1T3p2SuX_WXauC3f0tm0wVaS81LqknNo\",\"https://sun9-27.userapi.com/s/v1/ig2/Rb8TqMoGZobJ-8f52D32u-vF0K7Gx68iGM5yPeMvYVW0VOCWBpOG-vM3LjHqTJAccMn400bvh1Dlb3kO5wTackOZ.jpg?quality=95&as=32x19,48x28,72x42,108x64,160x94,240x141,360x212,480x283,540x318,640x377,720x424,928x547&from=bu&u=8nXu4hBIAiG0apoTqTcaPggMFYRaFQf4Q6w5F8VAllM\",\"https://sun9-54.userapi.com/s/v1/ig2/ozKY7DtjkukaQZkX85UP7coCyiftnm1Xk1Z1XIdGe5lzJjAVsrs2StIDS3zRoFWJVLT9wwBqUaQGaxIQAl9o4k5E.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=QiyKrrBSWSnDNheAS8k-so2EzZ-gsxBiw_L_OYZ242E\",\"https://sun9-12.userapi.com/s/v1/ig2/cSBw4HZWzikLIbDW0znVAkf89_syKCI8j46aGBtbi2cOeU90c07A6L_V8SSpmqk0_qbZXflC3NFzEwaBR-pO4AJo.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=Qbqz1kHGQEvDpeFXxWHmYLhXX1P83gzh1Xok7U10Bk0\",\"https://sun9-58.userapi.com/s/v1/ig2/OTapWmKyb_g9gECKPBmRsPJ-F7w9bYeG7mPH8ex8FHaNq3TkqeM6ffwdgQMd2a2tSRvZPmdtVqj5sjGkxPRH3_-l.jpg?quality=95&as=32x19,48x29,72x43,108x65,160x96,240x143,360x215,480x287,540x323,640x383,720x430,1080x646,1233x737&from=bu&u=dLPd3dhw-o6EnDaSgMo3gF4yoBcNeMoeXodz7iJuHpw\"]', 6, NULL, NULL, 1, '2026-04-29 12:01:42'),
(61, '🌿 С 20 апреля в Аэрокосмическом колледже стартовала акция «Зелёный десант» —…', '«Зелёный десант» — и сегодня, 30 апреля, мы достойно завершили её марафоном чистоты!\r\n\r\nНаши студенты вместе со всеми горожанами вышли на общегородской субботник. Было весело, активно, позитивно — но главное, что за этими эмоциями стоит настоящая польза.\r\n\r\n💚 Почему это важно именно для колледжа?\r\n«Зелёный десант» показал: аэрокосмический колледж — это не просто учёба и лекции. Это команда, которой не всё равно. Студенты своим примером доказывают, что ответственность и уважение к окружающей среде — такие же важные навыки, как и профессиональные.\r\n\r\n🏙️ А что это даёт городу?\r\nДесятки очищенных территорий, убранные парки, дворы и общественные пространства. Город преображается не только внешне, но и по атмосфере. Совместный труд объединяет жителей, делает улицы уютнее, а воздух — чище.\r\n\r\n🔥 Огромное спасибо каждому студенту, преподавателю и всем горожанам, кто взял в руки грабли и метлы! Мы доказали: вместе мы можем больше. И это только начало.\r\n\r\n#ЗеленыйДесант #АэрокосмическийКолледж #Субботник2026 #ЧистыйГород #НашеБудущее', 'https://sun9-6.userapi.com/s/v1/ig2/RHJs3bzzHZnG99hx8P3z7pNCDOzJN5pNS6Mr9PbZu9k1UoxO6KgzVq8BPzY3j3ez2Y59dtxXXR8jMN8uhZ-jP5wY.jpg?quality=95&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720,1080x1080,1280x1280&from=bu&u=Fvh0YWsfs8czuLVpiJjujRYm5AEf-PRNPeUmDJ7TrlY', '[\"https://sun9-6.userapi.com/s/v1/ig2/RHJs3bzzHZnG99hx8P3z7pNCDOzJN5pNS6Mr9PbZu9k1UoxO6KgzVq8BPzY3j3ez2Y59dtxXXR8jMN8uhZ-jP5wY.jpg?quality=95&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720,1080x1080,1280x1280&from=bu&u=Fvh0YWsfs8czuLVpiJjujRYm5AEf-PRNPeUmDJ7TrlY\",\"https://sun9-78.userapi.com/s/v1/ig2/9nu15WRS__3cbr-GUfoGIVU2NgYJq6mSUvXAdtCi4MCN0rGWhT6nNWMjSNz-IUh470PKAxcMKmBsVx55qL2W3a5b.jpg?quality=95&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720,1080x1080,1280x1280&from=bu&u=uKkle9e-uYwn9-4KL5TPUQM6YUOWOCZNtH5ZoS80cTw\",\"https://sun9-55.userapi.com/s/v1/ig2/2906vmfv6rqtboOazUXML6mYrVOGzfwjq2tlKRv05ox-ifvN-EIpfWsGv1Ob0jVH4VDxDJx7fg6mf5uGqdfVYPbu.jpg?quality=95&as=32x32,48x47,72x71,108x106,160x158,240x237,360x355,480x473,540x533,640x631,720x710,721x711&from=bu&u=n9EcQLdV2N3DzsvfXmFnAI5HWLAkF_H7PgTN_x0ESuk\",\"https://sun9-38.userapi.com/s/v1/ig2/Mw5uX5XVbzeHh8GwoLIB6lzFoV3PkMysSds2tS3G1-nZ5em2c-RsYjDABaCj6mh_v7ZuwX0byyTc7VX2kKHMAxdx.jpg?quality=95&as=32x22,48x33,72x49,108x74,160x109,240x163,360x245,480x327,540x368,640x436,720x490,1080x736,1280x872,1440x981,1693x1153&from=bu&u=YiuRq9yXkrpw6Bzlxr5HKFLOd_HaRDLfYmpPTX04zjg\",\"https://sun9-10.userapi.com/s/v1/ig2/Rubr39Y0yAf3QKbSWiAvbK3k1IRMFv03B8DgUf30rchvLci4tzTLTqJDJnF8-WaEWtFJwGYCinKcUYlusW1wOAWc.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=La_P39DRgGj0H5UPFqFTjJswUY9FEh4d1NVElejigW0\",\"https://sun9-38.userapi.com/s/v1/ig2/eYakZ1LheYUy0s7Kc5xCxonqtuN7wE_h9Hd0--5Ns67zpVoXRvkta8Vg3if2qXaa8q2khopatjGoBbRgNXOQZzb1.jpg?quality=95&as=32x38,48x56,72x85,108x127,160x188,240x282,360x423,480x564,540x635,640x752,720x846,1080x1270,1280x1505,1440x1693,1920x2257&from=bu&u=17aOGH39A6i90TfCAGucl8F3UT5yJhOJOfTAlokL9KE\",\"https://sun9-74.userapi.com/s/v1/ig2/iIW5gqVFZzX8or28afxg6e2ZZqIZgwep-OIiKBxLsQaw-954YpDfPqGzq1fjewxNYZVBsa2ntCkXiMehGNDqcz31.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=30jJoITdHy7KFwHyA8F60WKRgtPCsAGtO8tAJD8gKxI\",\"https://sun9-50.userapi.com/s/v1/ig2/_HF1t3AYrhM6JpBR5AXWaO5mgtauAhATziI0DnglNAa7Alcwg62YLSINxZH1TAZqYRYTfpFEZq9n94Phnv_trhMn.jpg?quality=95&as=32x39,48x58,72x87,108x130,160x193,240x290,360x434,480x579,540x652,640x772,720x869,1080x1303,1280x1545,1440x1738,1920x2317&from=bu&u=SGXPOqf3DPpCKkGaTHsSlyuF_W7tgCgggBu6drAKE3Q\",\"https://sun9-46.userapi.com/s/v1/ig2/ElQuwcc7TEgaZcOuwk_416JxIblae1zme_787i6Z_KHqlf9mVnjvGlzGJIoK7q5KKe9Xp-9FlYggjbqE35w0W20D.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=OTcKd5R-_JdS_otKTRQpWdojVLruZb39oPVWVUZXLHU\"]', 7, NULL, NULL, 1, '2026-05-01 07:26:52'),
(62, '🚀 Это событие — важная веха для всего нашего коллектива!', '🚀 Это событие — важная веха для всего нашего коллектива!\r\n\r\nС 13 по 15 апреля в Санкт-Петербурге прошёл VIII Всероссийский педагогический съезд системы образования России. Мероприятие объединило участников в очном и дистанционном форматах.\r\n\r\nДля Аэрокосмического колледжа участие в таком масштабном событии — это возможность заявить о себе на федеральном уровне, обменяться опытом с ведущими образовательными организациями страны и подтвердить высокий уровень подготовки студентов.\r\n\r\nИтог нашего участия — Диплом лауреата Всероссийского конкурса «500 лучших образовательных организаций страны — 2026».\r\n\r\n🏆 Эта награда — прямое признание ежедневного труда каждого преподавателя, мастера производственного обучения и сотрудника колледжа. Именно ваше мастерство, неравнодушие и профессионализм приносят такие результаты.\r\n\r\nГордимся!', 'https://sun9-19.userapi.com/s/v1/ig2/Sp2gR7DzFedgWAEGJQbQ-4LlO_kBn6JXK-_jrvQreuw378OyRCVNaVHQJU7lPRynYiPEVPwIROCB2gYsMe6v7cmV.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=Z0sm_2hGuxwQrP--16XM_yQ1lC13hT429N08SzF3YFA', '[\"https://sun9-19.userapi.com/s/v1/ig2/Sp2gR7DzFedgWAEGJQbQ-4LlO_kBn6JXK-_jrvQreuw378OyRCVNaVHQJU7lPRynYiPEVPwIROCB2gYsMe6v7cmV.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=Z0sm_2hGuxwQrP--16XM_yQ1lC13hT429N08SzF3YFA\",\"https://sun9-80.userapi.com/s/v1/ig2/0a68GeNwg4V0RGa-59RpllI2CERcw0QKlj1Y_p8_7IU-MbPKjiNSjaDDZFVYAjMSVMyBV15vj9w0B86a9XXLatkI.jpg?quality=95&as=32x43,48x65,72x98,108x147,160x218,240x326,360x489,480x653,540x734,640x870,720x979,1080x1468,1280x1740,1440x1958,1883x2560&from=bu&u=bacItUqgdf2RpVCznTMiiliJJZeXqz0RRyxSGOiReZE\",\"https://sun1-86.userapi.com/s/v1/ig2/vkGXl7M9-ggbrYH4wOrKjGMuqgtcjhHg4syaPeHkQyuVm27e4mocZL4C3wGWb3djRH5yyw4MxNw7sXT4uzGiFz11.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=javuWCc1k-RvHGeXgPgJ5fNduFW84RzMqj83gOKBUpQ\"]', 8, NULL, NULL, 1, '2026-05-05 13:36:11');

-- --------------------------------------------------------

--
-- Структура таблицы `student_portfolio_items`
--
-- Создание: Май 05 2026 г., 09:55
-- Последнее обновление: Май 06 2026 г., 15:36
--

DROP TABLE IF EXISTS `student_portfolio_items`;
CREATE TABLE `student_portfolio_items` (
  `id` bigint NOT NULL,
  `student_user_id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `project_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gallery_json` json DEFAULT NULL,
  `tags_json` json DEFAULT NULL,
  `specialty_id` bigint DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `student_portfolio_items`
--

INSERT INTO `student_portfolio_items` (`id`, `student_user_id`, `title`, `description`, `project_url`, `image_url`, `gallery_json`, `tags_json`, `specialty_id`, `sort_order`, `is_published`, `created_at`) VALUES
(1, 35, 'la', 'd', 'd', NULL, NULL, NULL, NULL, 0, 0, '2026-05-06 13:00:36'),
(2, 35, 'gff', 'fdfsdfsdfd', NULL, NULL, NULL, NULL, NULL, 0, 0, '2026-05-06 13:25:51'),
(3, 36, 'wefw', 'ewffew', 'fwfe', NULL, NULL, NULL, NULL, 0, 0, '2026-05-06 15:36:11');

-- --------------------------------------------------------

--
-- Структура таблицы `student_profiles`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 06 2026 г., 13:19
--

DROP TABLE IF EXISTS `student_profiles`;
CREATE TABLE `student_profiles` (
  `user_id` bigint NOT NULL,
  `student_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_id` bigint DEFAULT NULL,
  `curator_staff_id` bigint DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `avatar_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `portfolio_public` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `student_profiles`
--

INSERT INTO `student_profiles` (`user_id`, `student_code`, `group_id`, `curator_staff_id`, `birth_date`, `bio`, `avatar_url`, `portfolio_public`, `created_at`) VALUES
(12, 'ZK-0A3546D7', NULL, NULL, NULL, NULL, NULL, 1, '2026-04-14 10:45:10'),
(14, 'ZK-076764C2', NULL, NULL, NULL, NULL, NULL, 1, '2026-04-14 11:03:18'),
(26, 'ZK-9259648D', NULL, NULL, NULL, NULL, NULL, 1, '2026-04-19 17:40:39'),
(32, 'ZK-52F87D75', NULL, NULL, NULL, NULL, NULL, 1, '2026-04-26 08:01:44'),
(33, 'ZK-C720F4EE', NULL, NULL, NULL, NULL, NULL, 1, '2026-04-26 08:03:20'),
(34, 'ZK-486D8F50', NULL, NULL, NULL, NULL, NULL, 1, '2026-04-26 08:05:14'),
(35, 'ZK-07F8B657', NULL, NULL, NULL, NULL, NULL, 1, '2026-04-27 13:38:52'),
(36, 'ZK-EB22A1AB', NULL, NULL, NULL, NULL, NULL, 1, '2026-05-06 13:18:13'),
(37, 'ZK-5C497997', NULL, NULL, NULL, NULL, NULL, 1, '2026-05-06 13:19:27');

-- --------------------------------------------------------

--
-- Структура таблицы `student_resumes`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 05 2026 г., 14:40
--

DROP TABLE IF EXISTS `student_resumes`;
CREATE TABLE `student_resumes` (
  `id` bigint NOT NULL,
  `student_user_id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `skills_json` json DEFAULT NULL,
  `experience_json` json DEFAULT NULL,
  `education_json` json DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `student_resumes`
--

INSERT INTO `student_resumes` (`id`, `student_user_id`, `title`, `summary`, `skills_json`, `experience_json`, `education_json`, `is_published`, `created_at`) VALUES
(3, 35, 'sggergerg', 'gregerge', NULL, NULL, NULL, 0, '2026-05-05 14:40:12');

-- --------------------------------------------------------

--
-- Структура таблицы `teacher_profiles`
--
-- Создание: Апр 25 2026 г., 10:19
--

DROP TABLE IF EXISTS `teacher_profiles`;
CREATE TABLE `teacher_profiles` (
  `user_id` bigint NOT NULL,
  `staff_member_id` bigint DEFAULT NULL,
  `department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `avatar_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 06 2026 г., 13:19
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password_hash`, `is_active`, `created_at`) VALUES
(1, 'Администратор системы', 'admin@aksibgu.local', '+79990000000', '$2y$10$85R93Dq2IuB0rfuHMjHjwuk3S3G5DpcwgR3fuCujn2vPUasfeDgli', 1, '2026-04-10 06:58:36'),
(2, 'Контент-менеджер', 'staff.content@aksibgu.local', '+79990000001', '$2y$10$Ut7EsMiJ3MfKSUaUCMxOfuXRIu.mR4.KcLOquddsuFYBzGS7yuqja', 1, '2026-04-10 10:14:56'),
(3, 'Редактор новостей', 'staff.news@aksibgu.local', '+79990000002', '$2y$10$2CRHu7H2fk8fuKpB8ye5l.1t9lzJ2dpVYVPUXClE3XUuBmek7uTtm', 1, '2026-04-10 10:14:56'),
(12, 'Иван Сергеевич Петров', 'kucersemen9@gmail.com', '+78989895656', '123', 1, '2026-04-14 10:45:10'),
(14, 'Николаева Ева Алексеевна', 'ratekira09@gmail.com', '+78459612322', '$2y$12$xuH4Apf1wSnCOdYJue/7tu.TwzkumAcASdqZbCywzOdrT4wCJOCda', 1, '2026-04-14 11:03:18'),
(26, 'Иванов Иван Иванович', 'kucersemen10@gmail.com', '+77777777777777', '$2y$12$Uoloy3eo4gm7V7cJMpiVR.nITAwYniILOu4KER2wuxiLNWZh5xqKG', 1, '2026-04-19 17:40:39'),
(32, 'Test User', 'test@example.com', '123', '$2y$12$rYyyuwJYD140JelurqTVseL1KADvXIqxeS.yE23mAKo40.pmBU7fy', 1, '2026-04-26 08:01:44'),
(33, 'jsnfjsfsf', 'x4ftc@deltajohnsons.com', '6565', '$2y$12$TGXeDsGg3lSjHpPAuQPgYu5Bl0EGBB6j7Ys03vlluVUhkcyBkuI.e', 1, '2026-04-26 08:03:20'),
(34, 'kucersemen18@gmail.com', 'kucersemen18@gmail.com', 'kucersemen18@gmail.com', '$2y$12$JfIKjtaNjS9ThycXsXjZmO6zKOBbbkLNU37YmNMIi9p1GLIXE0G3W', 1, '2026-04-26 08:05:14'),
(35, 'qwq', '16rlo@deltajohnsons.com', '+7878787877', '$2y$12$lmraj/vqeg8AZbczCv8fcu95Oqta98Qv.nSqeGrdk8Snk0m8Ob/Wq', 1, '2026-04-27 13:38:52'),
(36, 'lol', '1@gmail.com', '147147147', '$2y$12$RCBEbrMhxkwXIiVOe5xEPu9CqXR8EncMEv3ayeugyghVGlAqZ6qIO', 1, '2026-05-06 13:18:13'),
(37, 'lol_2', '2@gmail.com', '123456789', '$2y$12$nX2RBMCAkgFNT2MAtTXvbO1jSprQqtv8Hl0Vf6n9B5NkVdKhHqQi.', 1, '2026-05-06 13:19:27');

-- --------------------------------------------------------

--
-- Структура таблицы `user_roles`
--
-- Создание: Апр 25 2026 г., 10:19
-- Последнее обновление: Май 06 2026 г., 13:19
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `user_id` bigint NOT NULL,
  `role_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(12, 3),
(14, 3),
(26, 3),
(32, 3),
(33, 3),
(34, 3),
(35, 3),
(36, 3),
(37, 3),
(2, 4),
(3, 4),
(1, 5);

-- --------------------------------------------------------

--
-- Структура таблицы `vacancies`
--
-- Создание: Май 05 2026 г., 09:54
-- Последнее обновление: Май 05 2026 г., 14:16
--

DROP TABLE IF EXISTS `vacancies`;
CREATE TABLE `vacancies` (
  `id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `partner_id` bigint DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employment_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `published_at` datetime DEFAULT NULL,
  `expires_at` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `vacancies`
--

INSERT INTO `vacancies` (`id`, `title`, `company`, `partner_id`, `city`, `employment_type`, `salary`, `contact_email`, `contact_phone`, `description`, `published_at`, `expires_at`, `is_active`, `created_at`) VALUES
(1, 'Младший программист', 'АЭРОКОС Технологии', NULL, 'Москва', 'Полная занятость', '80 000 — 120 000 ₽', NULL, NULL, 'Стартовая позиция для выпускников и студентов.', '2026-04-10 09:58:36', NULL, 1, '2026-04-10 06:58:36'),
(2, 'Инженер-конструктор', 'АЭРОКОС Технологии', NULL, 'Москва', 'Полная занятость', '100 000 — 120 000 ₽', NULL, NULL, 'Работа в конструкторском отделе.', '2026-04-10 09:58:36', NULL, 1, '2026-04-10 06:58:36'),
(3, 'ПЕДОР', 'ОАОААОАОА', 2, 'СИБИРЬ', 'ВСЕГДА', 'БЕСПЛАТНО', 'vor@mail.com', 'НЕТУ', 'ЛУЧШАЯ', '2026-05-05 17:15:59', NULL, 1, '2026-05-05 14:16:59');

-- --------------------------------------------------------

--
-- Структура таблицы `vk_parser_runs`
--
-- Создание: Апр 26 2026 г., 13:05
--

DROP TABLE IF EXISTS `vk_parser_runs`;
CREATE TABLE `vk_parser_runs` (
  `id` bigint NOT NULL,
  `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finished_at` timestamp NULL DEFAULT NULL,
  `fetched_total` int NOT NULL DEFAULT '0',
  `added_new` int NOT NULL DEFAULT '0',
  `skipped_dup` int NOT NULL DEFAULT '0',
  `status` enum('ok','error') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ok',
  `message` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `vk_parser_runs`
--

INSERT INTO `vk_parser_runs` (`id`, `started_at`, `finished_at`, `fetched_total`, `added_new`, `skipped_dup`, `status`, `message`) VALUES
(1, '2026-04-26 13:14:34', '2026-04-26 13:14:34', 0, 0, 0, 'error', 'VK API error 5: User authorization failed: access_token was given to another ip address'),
(2, '2026-04-26 13:14:39', '2026-04-26 13:14:39', 0, 0, 0, 'error', 'VK API error 5: User authorization failed: access_token was given to another ip address'),
(3, '2026-04-26 13:17:14', '2026-04-26 13:17:14', 0, 0, 0, 'error', 'VK API error 5: User authorization failed: access_token was given to another ip address'),
(4, '2026-04-26 13:26:09', '2026-04-26 13:26:09', 0, 0, 0, 'error', 'VK API error 5: User authorization failed: access_token was given to another ip address'),
(5, '2026-04-26 11:39:30', '2026-04-26 11:40:00', 15, 15, 0, 'ok', ''),
(6, '2026-04-26 11:52:12', '2026-04-26 11:52:25', 15, 9, 6, 'ok', ''),
(7, '2026-04-26 11:55:00', '2026-04-26 11:55:08', 15, 15, 0, 'ok', ''),
(8, '2026-04-26 11:55:48', '2026-04-26 11:55:57', 15, 15, 0, 'ok', ''),
(9, '2026-04-26 11:58:45', '2026-04-26 11:59:16', 15, 15, 0, 'ok', ''),
(10, '2026-04-26 12:03:20', '2026-04-26 12:03:30', 15, 15, 0, 'ok', ''),
(11, '2026-04-26 12:43:33', '2026-04-26 12:43:42', 15, 15, 0, 'ok', ''),
(12, '2026-04-26 12:45:27', '2026-04-26 12:45:52', 15, 15, 0, 'ok', ''),
(13, '2026-04-26 12:48:38', '2026-04-26 12:48:45', 15, 0, 15, 'ok', ''),
(14, '2026-04-26 12:58:59', '2026-04-26 12:59:06', 15, 15, 0, 'ok', ''),
(15, '2026-04-26 13:10:58', '2026-04-26 13:11:23', 15, 15, 0, 'ok', ''),
(16, '2026-04-27 00:12:11', '2026-04-27 00:12:40', 15, 0, 15, 'ok', ''),
(17, '2026-04-27 00:41:21', '2026-04-27 00:41:31', 15, 0, 15, 'ok', ''),
(18, '2026-04-27 03:38:30', '2026-04-27 03:38:40', 14, 0, 14, 'ok', ''),
(19, '2026-04-27 04:56:09', '2026-04-27 04:56:15', 14, 0, 14, 'ok', ''),
(20, '2026-04-27 10:54:36', '2026-04-27 10:55:32', 14, 0, 14, 'ok', ''),
(21, '2026-04-27 10:55:39', '2026-04-27 10:56:11', 14, 0, 14, 'ok', ''),
(22, '2026-04-27 11:23:49', NULL, 0, 0, 0, 'ok', NULL),
(23, '2026-04-27 13:12:18', '2026-04-27 13:12:22', 14, 14, 0, 'ok', ''),
(24, '2026-04-27 13:14:49', '2026-04-27 13:14:54', 14, 14, 0, 'ok', ''),
(25, '2026-04-29 09:00:13', '2026-04-29 09:00:18', 15, 4, 11, 'ok', ''),
(26, '2026-04-30 00:50:12', '2026-04-30 00:50:16', 15, 0, 15, 'ok', ''),
(27, '2026-05-01 04:26:04', '2026-05-01 04:26:09', 14, 1, 13, 'ok', ''),
(28, '2026-05-04 05:31:44', '2026-05-04 05:31:48', 15, 1, 14, 'ok', ''),
(29, '2026-05-05 10:45:20', '2026-05-05 10:45:25', 14, 1, 13, 'ok', '');

-- --------------------------------------------------------

--
-- Структура таблицы `vk_pending_stories`
--
-- Создание: Апр 26 2026 г., 13:05
--

DROP TABLE IF EXISTS `vk_pending_stories`;
CREATE TABLE `vk_pending_stories` (
  `id` bigint NOT NULL,
  `vk_owner_id` bigint NOT NULL,
  `vk_post_id` bigint NOT NULL,
  `vk_post_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `images_json` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `selected_image` int NOT NULL DEFAULT '0',
  `vk_published_at` datetime NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `published_story_id` bigint DEFAULT NULL,
  `reviewed_by_user_id` bigint DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reject_reason` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `vk_pending_stories`
--

INSERT INTO `vk_pending_stories` (`id`, `vk_owner_id`, `vk_post_id`, `vk_post_url`, `title`, `content`, `images_json`, `selected_image`, `vk_published_at`, `status`, `published_story_id`, `reviewed_by_user_id`, `reviewed_at`, `reject_reason`, `created_at`) VALUES
(279, -186869747, 2589, 'https://vk.com/wall-186869747_2589', '⚡️ Хоккей с дронами? Почему бы и нет!', 'Пока на льду «Платинум Арены» боролись за Кубок АО «Красмаша» среди любительских хоккейных команд (25–26 апреля), за пределами бортика Аэрокосмический колледж знакомил гостей с авиацией будущего.\r\n\r\nСамые смелые проходили тест-драйв на симуляторах БПЛА, а заодно получали консультацию о поступлении в колледж. Получилось ярко, молодёжно и с пользой для профориентации.\r\n\r\n#Красмаш #хоккей #АэрокосмическийКолледж #дроны #профориентация', '[\"https://sun9-32.userapi.com/s/v1/ig2/oZG2Gbpgztazp57EnTV42e3b-hx8rtJyTpwe7DQK59p4YERiCc-tVnJH7qpIpy2LyQg5MNGqDyWbHZyH8BmfUVLl.jpg?quality=95&as=32x22,48x33,72x49,108x73,160x108,240x163,360x244,480x325,540x366,640x434,720x488,1080x732,1280x868,1440x976,2560x1736&from=bu&u=7XIEbYeL9wcRupanGPFoNuOcqmNeRD0deobwYUybTFQ\", \"https://sun9-48.userapi.com/s/v1/ig2/Uf8lX2My42Ndg1gl1WWtU3LnuI6xUpOsOhzJC3-RBXBvaeqqZ9lrJM7Ui_-z8d8BARAF7yT9dASbcXXiQtuDPoTd.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=HE-eWHJlmNnFTyEhyDkS60iLzZzrVBgo1ZXuD0jI3pE\", \"https://sun9-6.userapi.com/s/v1/ig2/T4YuR5Q3PpCNd3BiSqHIeeUOBzP2_pg5qbnX0HwApyemcOba3jtPmSfbq0je26dbtUZ50kpv0WbfaEBZak1F2a3g.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=WZQmFDKtnXwoEjVvWpW_3aLIoVKjOKtInJVttT02UF0\", \"https://sun9-77.userapi.com/s/v1/ig2/vxPe-u5GxB4fG5GXoXzEPThsTMS4ZnXzJumWAsp0hSB_1kjryFGbqGd37Sfczu9NNKiDtwZSLoZblDKOtfdMGfhl.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=Bs39GtHG0omRyjjG6utIctG05_U84HNPU-qfRFHWXYA\", \"https://sun9-48.userapi.com/s/v1/ig2/OYfgpkXeqRoa-2qEWGHzsxP90yTP9rDvtDUyzjaILNWe7uI46aQNOKo-Z-K_HkaZ5GnZDkA5LnTGbsQ8TyPL-en-.jpg?quality=95&as=32x36,48x54,72x81,108x121,160x179,240x269,360x403,480x537,540x604,640x716,720x806,1080x1209,1280x1433,1440x1612,2287x2560&from=bu&u=hnu_-659ZY6P-vOauxaj59BaWDj5NEaMpOSDbN8SDgM\", \"https://sun9-77.userapi.com/s/v1/ig2/cDbMDy19UIify7lozx9248JIZjczJP0ZIxLU48isgFmdLcYPvipRu_nZSJrvjOigEPfykeH2jkYNxq1PPHGWx4-3.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=yRDxJx-299zA8r2emuKnDMaCKwgHWRWcXMlsfKEhc3Y\", \"https://sun9-77.userapi.com/s/v1/ig2/4LvuMCP6lnyIFW7CN82BUskwPhb_VcTB1OYeL4UwNt8uQ_5lndgnyyd4T8xX_ooc7xVSZqzfUhilMGiFHS8wYN64.jpg?quality=95&as=32x38,48x57,72x86,108x128,160x190,240x285,360x428,480x570,540x642,640x761,720x856,1080x1284,1280x1521,1440x1711,2154x2560&from=bu&u=ZVsd6WJQ8LyVcoF_OR661sT8dSRbyb-UeRmyF6LQDtE\"]', 0, '2026-04-25 07:45:23', 'approved', 55, 1, '2026-04-27 16:20:32', NULL, '2026-04-27 16:14:54'),
(280, -186869747, 2586, 'https://vk.com/wall-186869747_2586', '🎭 Пятница — день культурного десанта!', '🎭 Пятница — день культурного десанта!\r\n\r\nВот как здорово завершить рабочую неделю: не дома за сериалом, а в СДК — на рэп-спектакле по Пушкину!\r\n\r\nСтуденты Аэрокосмического колледжа и Университета Решетнева вместе провели вечер пятницы в СДК. Смотрели «Барышню-крестьянку» — но не классическую, а от артистов ТЮЗа.\r\n\r\nИ это было круто! 🔥\r\n\r\n📖 По мотивам «Повестей покойного Ивана Петровича Белкина» — получилось остроумно, ритмично и максимально близко к современному зрителю. Рэп, драйв, знакомые герои в новом прочтении — всем без исключения зашло!\r\n\r\nСтуденты в полном восторге! \r\nПушкин зазвучал по-новому — современно, дерзко и со смыслом. \r\nТакие форматы доказывают: классика жива! \r\n\r\nВсем советуем! 🔥\r\n\r\n#Аэрокосмический #Решетнев #Пушкин #РэпСпектакль#БарышняКрестьянка #ТЮЗ #Пушкин', '[\"https://sun9-48.userapi.com/s/v1/ig2/2g6ir0DWNe_vmo47j-f7zH66IeLjF9EEctfunClv-MlnDW2YWEcCbM6kas5nQBAa166yytFaUdNXMUO2kKLLwgo7.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x959,1440x1079,1893x1419&from=bu&u=WGBZkLrb7wy_bE1gbo_vWGsxndFNL-_m7YPFlXZEgbg\", \"https://sun9-87.userapi.com/s/v1/ig2/deNlI6HVw3H2XDJUWMk-BlME5b5pf3ZfBHPf4gBIi-42WeGHj0pbaKp1UrM4YcA4Ecbrg0e_wGH44wa8YcIL893R.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2451x1838&from=bu&u=yWXOorehAxgNMOUxXClW3gbCJwuZnnYzOeCopDmA6-g\", \"https://sun9-29.userapi.com/s/v1/ig2/r8TnMaMfqK8JmH7R27NFmXOGQjSkMYOqULP8KkQB28fP1RVvnu0AxFm4odk_H4e1Z_i06YYbkoVnfqTKdnQQ_lis.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,1852x1389&from=bu&u=6wzq14QqfS5-lkS4XMYbFUffkTEsd75gqqVkAYlJan8\", \"https://sun9-11.userapi.com/s/v1/ig2/TevwB0_WaNSCgRxpL02yh16oM56_MAXWp7KDs8VyiebyFPnLYt3agONNS1IekAwApE-kyi7RJQH_uvKEBHC_mQty.jpg?quality=95&as=32x16,48x24,72x37,108x55,160x81,240x122,360x183,480x244,540x274,640x325,720x366,1075x546&from=bu&u=JhIhWnB-eNRe7QK6_vREmhztoxXBs8CkaPmwGln_St4\"]', 1, '2026-04-24 13:45:10', 'approved', 56, 1, '2026-04-27 17:21:47', NULL, '2026-04-27 16:14:54'),
(281, -186869747, 2585, 'https://vk.com/wall-186869747_2585', '«Диктант Победы»: даже на МКС, но и наши студенты — в строю', 'Восьмой раз по всей стране и за её пределами проходит «Диктант Победы». Масштаб акции впечатляет: уникальные площадки в этом году — Международная космическая станция, космодром Плесецк, ледоколы, поезда и даже борта самолётов. Партнёром диктанта традиционно выступает Российское военно-историческое общество (РВИО).\r\n\r\nСтуденты Аэрокосмического колледжа, конечно, не могли остаться в стороне. Ребята из групп ТМ-94-24 и ИТ-17-25 тоже проверили свои знания об истории Великой Отечественной войны.\r\n\r\nГордимся их выбором. Помним. И передаём память дальше. 🕯️', '[\"https://sun9-37.userapi.com/s/v1/ig2/unbpuRujkNzzPSWy4_POJdvcDrrRMF_a5UpY1YtUrzsv3BkAVqNLtrxwhuu4v6oAqcFayN6d3xIzFCbSU46RE9WN.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=mSTTyzWqxY4q93l-VM75EcUvWFPSENC89orCa_qghCM\", \"https://sun9-16.userapi.com/s/v1/ig2/ZwLbNB5wY2cm7teQ8Gxwt-XDqAzv59harN_36NlyWOvJiJRc9H_btV8Zl46bY0dY82-58hU8sX81_yr7c84Cff6n.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=6MdvovAZGrI1T3p2SuX_WXauC3f0tm0wVaS81LqknNo\", \"https://sun9-27.userapi.com/s/v1/ig2/Rb8TqMoGZobJ-8f52D32u-vF0K7Gx68iGM5yPeMvYVW0VOCWBpOG-vM3LjHqTJAccMn400bvh1Dlb3kO5wTackOZ.jpg?quality=95&as=32x19,48x28,72x42,108x64,160x94,240x141,360x212,480x283,540x318,640x377,720x424,928x547&from=bu&u=8nXu4hBIAiG0apoTqTcaPggMFYRaFQf4Q6w5F8VAllM\", \"https://sun9-54.userapi.com/s/v1/ig2/ozKY7DtjkukaQZkX85UP7coCyiftnm1Xk1Z1XIdGe5lzJjAVsrs2StIDS3zRoFWJVLT9wwBqUaQGaxIQAl9o4k5E.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=QiyKrrBSWSnDNheAS8k-so2EzZ-gsxBiw_L_OYZ242E\", \"https://sun9-12.userapi.com/s/v1/ig2/cSBw4HZWzikLIbDW0znVAkf89_syKCI8j46aGBtbi2cOeU90c07A6L_V8SSpmqk0_qbZXflC3NFzEwaBR-pO4AJo.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=Qbqz1kHGQEvDpeFXxWHmYLhXX1P83gzh1Xok7U10Bk0\", \"https://sun9-58.userapi.com/s/v1/ig2/OTapWmKyb_g9gECKPBmRsPJ-F7w9bYeG7mPH8ex8FHaNq3TkqeM6ffwdgQMd2a2tSRvZPmdtVqj5sjGkxPRH3_-l.jpg?quality=95&as=32x19,48x29,72x43,108x65,160x96,240x143,360x215,480x287,540x323,640x383,720x430,1080x646,1233x737&from=bu&u=dLPd3dhw-o6EnDaSgMo3gF4yoBcNeMoeXodz7iJuHpw\"]', 0, '2026-04-24 13:12:39', 'approved', 60, 1, '2026-04-29 12:01:42', NULL, '2026-04-27 16:14:54'),
(282, -186869747, 2582, 'https://vk.com/wall-186869747_2582', '🏆 Итоги «Soft-Парада 2026»', '🏆 Итоги «Soft-Парада 2026»\n\nСегодня студенты Аэрокосмического колледжа приняли участие в финале Всероссийского смотра-конкурса молодёжных IT-проектов Soft-Парад 2026.\n\nФинал состоялся на базе Сибирского государственного университета науки и технологий имени академика М.Ф. Решетнева.\n\nРезультат: ПОЗДРАВЛЯЕМ нашу команду с выходом в финал и завоеванием 2 места в номинации «Геймдев» (разработка игр)! 🥈🎮\n\nМолодцы! Желаем новых крутых проектов!', '[\"https://sun9-69.userapi.com/s/v1/ig2/6BL_eNFpZ_OHixa-nnv9uzu5segaGbkUBre-lvGcmTLBmerqQCqXW_DF4XwSPBaoCGZ9_id5yrVMfzeTrVUWEO_T.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=jZPy66G7eNHJh2ggK1h5AjLpzXsRU773lbmwdfOXegk\", \"https://sun9-69.userapi.com/s/v1/ig2/_kO4sgZnL-xMFzhQ1YqduCW1PZzn2ItmFWzqiXO_1Syyhc7Qmp_oElOJlXScp3tjvxSwEfnZTAimHA3DcjajLDm3.jpg?quality=95&as=32x39,48x58,72x87,108x131,160x194,240x291,360x436,480x582,540x655,640x776,720x873&from=bu&u=QZSKxhpBtFEQRXcl8TVcdDwkUWiI7XhzfGy4JaOH2Sk\", \"https://sun9-52.userapi.com/s/v1/ig2/jnuGdhYWdeR14ZbJZax0wBuNMWnTdAxrt1Y2GdrNZNAn9le0O7uNWJrN3UEsUnNODIw429DAXqiETMsWsAw58aw3.jpg?quality=95&as=32x22,48x33,72x49,108x74,160x109,240x164,360x246,480x328,540x369,640x437,720x492,910x622&from=bu&u=fQ13kpJckW-KgNn5E1_uhGSPiUG1hgpukHxuDisoiT4\"]', 0, '2026-04-24 12:32:32', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(283, -186869747, 2577, 'https://vk.com/wall-186869747_2577', 'Сегодня студенты аэрокосмического колледжа приняли участие во Всероссийском с…', 'Сегодня студенты аэрокосмического колледжа приняли участие во Всероссийском смотре-конкурсе молодёжных IT-проектов Soft-Парад 2026\n  \n  Студенты успешно прошли заочный отбор и вышли в полуфинал, который проводится в  Сибирском государственном университете науки и технологий имени академика М.Ф. Решетнева по следующим номинациям:\n  \n  • Информационные ресурсы и сервисы\n  • Геймдев (разработка игр)\n  • Программирование\n  \n  Наставники: Гвоздиевская О.С., Петрова А.А., Мережникова Е.И.', '[\"https://sun9-39.userapi.com/s/v1/ig2/oui2pD2_NABD-gin77v1zN_I6eP7La0SOFLbZ1faVi_WYeGlcYvMOXPoE9JNTEMIgmLNXICnWGugWE6oFoN8O_Wd.jpg?quality=95&crop=0,0,1918,2264&as=32x38,48x57,72x85,108x127,160x189,240x283,360x425,480x567,540x637,640x755,720x850,1080x1275,1280x1511,1440x1700,1918x2264&from=bu&u=pQvCRg_jOWy7W5MP61G9Z1evs_6O8bqQ164ojwGKt0U\", \"https://sun9-54.userapi.com/s/v1/ig2/XgDjMLpxhtrNYmhx1eYlyUT2QM3BU23QOlN-BiZNHZE9-IUvCuxndgcjBdkA3jDKuwJf8eFuFGi0C_4aFbalB86q.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=XRZIXj-ngsZ_ngKKdkcx-73FALk1n5PE8gvoCIivi-o\", \"https://sun9-73.userapi.com/s/v1/ig2/BNGGOs4xj4MAGB722bF-A59ziX2g1pVwvne0X4Sx_ZyY2q7fZrWrxZ-HDS41NqtZjU6WnvCwNct64F3c5OHzDcqE.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=LNOL9UgwsIYXzpgrpMY4zgPhNJhAxzuBJbw9ZDpK6JM\"]', 0, '2026-04-23 11:39:59', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(284, -186869747, 2576, 'https://vk.com/wall-186869747_2576', 'Сегодня студенты 2 отделения побывали на экскурсии в АО «Красноярский речной…', 'Сегодня студенты 2 отделения побывали на экскурсии в АО «Красноярский речной порт» (Злобинский грузовой район).\n\nЗнакомство с одним из ключевых предприятий региона началось с просмотра фильма об истории порта. Ребята увидели, как развивалась компания, и прониклись масштабом работы.\n\n Осмотрели производственные площадки, где студенты:\n🔹 Увидели современную рабочую технику;\n🔹 Изучили логистику грузовых перевозок;\n🔹 Пообщались с представителями компании.\n\nОсобый интерес вызвал рассказ о преимуществах и специфике работы, а также о возможностях прохождения практики и дальнейшего трудоустройства для наших студентов.\n\nБлагодарим Красноярский речной порт за тёплый приём и полезную информацию! Такие встречи — важный шаг к осознанному выбору профессии. 🚢💼Практика и стажировка — наши главные цели, и дверь в порт для нас открыта! Спасибо за крутой опыт! 🙌', '[\"https://sun9-14.userapi.com/s/v1/ig2/3tuPkyFu6U-D-_DFeEW411XutUu9UyNc_J71HYKeMPlziA7b66sZSApM_RzO7Tg8vhWh5CfOlKHTU5KTTl0M1kLg.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x269,480x359,540x404,640x479,720x539,1080x808,1160x868&from=bu&u=cMj6jburZfhAYJbUdeJ3uA3SldIr3Vk4egk6NMbDQrI\", \"https://sun9-35.userapi.com/s/v1/ig2/xUacGeIkot3WR-8-aaWvC8714SdGInzFYjBpvpvtj49I92eyRlVz9E1Z-M_liTX_rwtGSawi8c7AzflmKEqH1gZS.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x319,360x479,480x639,540x719,640x852,720x958,1080x1438,1232x1640&from=bu&u=uNlJ-kZTfHAkS8NIwJoGSdosKa36Z8wbwFjVaaDfB9o\", \"https://sun9-82.userapi.com/s/v1/ig2/WTokAAfcumvRVFFrqodqVLOdrF9Klh3mxgCgNU1t-05h_ARQqxKR1FHH1JQHdawICqU4Wic3el0LcLt0ngxOXXzq.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x361,540x406,640x481,720x541,1080x811,1280x962,1440x1082,1640x1232&from=bu&u=iTPKORPnFdjc13ArmuLnUjHqiYgYnkwEswR6R3zwx2g\"]', 0, '2026-04-23 09:43:43', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(285, -186869747, 2575, 'https://vk.com/wall-186869747_2575', '🎓 Студенческие отряды Красноярского края: строим будущее вместе!', '🎓 Студенческие отряды Красноярского края: строим будущее вместе!\n\nЗнаете ли вы, что Красноярское региональное отделение РСО — это огромная команда единомышленников? По состоянию на 2026 год в ней уже более 3 500 участников из 8 вузовских и 6 муниципальных штабов. И с каждым годом нас становится только больше.\n\n🔥 Чем живут студотряды сегодня?\n\nГлавным событием недавнего прошлого стал Всероссийский слёт РСО в Красноярске, посвящённый окончанию 66-го трудового семестра. Он собрал более 3000 участников из 89 регионов России и даже гостей из-за рубежа. Слёт объединил конкурсы профмастерства, масштабный творческий фестиваль и спортивную спартакиаду.\n\nЭто далеко не всё! Отряды участвуют в патриотической акции «Снежный десант РСО» (помощь ветеранам и благоустройство памятников), а также готовятся к 400-летию Красноярска, работая на строительстве социальных объектов и организации юбилейных мероприятий.\n\n🚀 Перспективы развития: от города к стране\n\n· Подготовка к юбилею Красноярска: Сейчас студотряды помогают в строительстве пяти масштабных объектов к 400-летию города. Регион ведёт переговоры, чтобы присвоить подготовке к юбилею статус Всероссийской студенческой стройки.\n· Новые горизонты: Бойцов ждут на космодромах «Восточный» и «Плесецк», курортах Краснодарского края, в детских центрах («Артек», «Орленок») и крупных компаниях — «Норильский никель», «Полюс-золото», «Ванкорнефть».\n\n🎯 Как стать частью команды?\n\nПопасть в отряд проще, чем кажется:\n\n· Кто может вступить: Студенты очной формы обучения (вузы и колледжи), достигшие 18 лет.\n· Как это сделать: Нужно заполнить анкету на сайте [#alias|кксо24.рф|кксо24.рф] и пройти собеседование. Сейчас — самое время, так как набор активистов продолжается.\n· Направления деятельности: Вы можете выбрать одно из пяти направлений: строительное, сервисное, педагогическое, медицинское или проводники.\n\nРСО — это не только работа, но и бесценный опыт, новые друзья и вклад в развитие родного края. Присоединяйтесь!\n\nПо всем вопросам обращайтесь в Красноярское региональное отделение РСО по адресу: ул. Карла Маркса, 44.\n\n#РСО #Красноярск #СтуденческиеОтряды #Молодежь #ТрудКрут #400летиеКрасноярска', '[\"https://sun9-75.userapi.com/s/v1/ig2/Kt4-tKRZensYLvADL1hBkQaryzyzF1FY6oWDbyseOI6V-dsXh68ldyqPQ8Wrqf7HqG4umoOiagZXqxpZzYqvVPs6.jpg?quality=95&crop=0,0,1080,800&as=32x24,48x36,72x53,108x80,160x119,240x178,360x267,480x356,540x400,640x474,720x533,1080x800&from=bu&u=BB3SOHiXC8xD9wcl7thU44HgjAlvqruS0eTGOmm9a2w\"]', 0, '2026-04-23 03:50:48', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(286, -186869747, 2571, 'https://vk.com/wall-186869747_2571', '🚀 Дебют — и сразу в призах!', '🚀 Дебют — и сразу в призах!\n\nАэрокосмический колледж впервые выступил на межрегиональном чемпионате по компетенции «Облачные технологии» в Новосибирске. \n\nСтудентка группы СА-5-22 Пахер Ярослава (наставник Матерняк В. С.) заняла 2 место среди 19 участников.\n\n🥈 Серебро — отличный старт! Гордимся нашей командой!\n\nПоздравляем!!! 🚀', '[\"https://sun9-50.userapi.com/s/v1/ig2/WFY3Smnyeb7vNCPn4TzZUJ3fp341DIN6PnfIcAO6j9jIZViK-EpUAzbcKKIXwvmSVemHwvvim63qD1QSVCg1JyUA.jpg?quality=95&as=32x22,48x33,72x50,108x75,160x111,240x167,360x251,480x334,540x376,640x446,720x501,1080x752,1280x891,1387x966&from=bu&u=NMHwh7CfpUPMvuVCf-8pBogflbrkzpTIPltjo-s269s\", \"https://sun9-57.userapi.com/s/v1/ig2/fwYvUmG14h5yAlrKyAzKkqlL0t7S2lRDrxuQD34nRk-CtW1fGpmZ2lRAjO-dtgR8O2yPqsKZXdiH_jkQlpRf7SeU.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,1500x1000&from=bu&u=x3b1jqwj0wRr_aY8TVoqeQv3kkgUFlbuIZRN56fuxgQ\", \"https://sun9-77.userapi.com/s/v1/ig2/_fVp5Dajad5hOgC7qtguvHG2GaRnGyLQjY1gFQlnjerYP1WWqCydea8Uw_xMVMIX8ZNUS4nps_MqI5Vnr3KBQRqd.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,1500x1000&from=bu&u=7LxIIPoh1MLyI5LAZG8Df90uUOrvec6-I2WXJW5qYVc\", \"https://sun9-58.userapi.com/s/v1/ig2/afwvKFGbrRPp4Lx_clolo7w7LN_QmHiZ35L_1R-e-LhEOapvx8oLv6vgBOUnbC-mnXDYZK9hl9JgzbkRgBOIM16d.jpg?quality=95&as=32x20,48x29,72x44,108x66,160x98,240x146,360x220,480x293,540x329,640x390,720x439,1080x659,1280x781,1440x878,1500x915&from=bu&u=qu7poI0VkjuDSoruyGNN9OSeXQPoWM5AjMw4UDsNgI4\", \"https://sun9-73.userapi.com/s/v1/ig2/l_qB_LoHAu7A18nyGaHFEi9h32dwm0Z8MdbKPSI4iflBQSQZ1wkMxXYCyTrKC1Z-gmCfKLbuLvYjqnYL5wAbB1t9.jpg?quality=95&as=32x48,48x72,72x108,108x162,160x240,240x360,360x540,480x720,540x810,640x960,720x1080,1000x1500&from=bu&u=oAVf6o2PcPJM3PfKJ_4I6HetX751gz_5fHnkkp1ksBU\", \"https://sun9-30.userapi.com/s/v1/ig2/xdtuRYRljtwHk0XWnrWbmU-6cA0k17Eo0l1TDaEWvs9JLlK07gcbaEwx2TGW2aGORArR7RUKe_famJKYMXNK0GRF.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,1500x1000&from=bu&u=Mxj7C86nSKJCC4IZoihPOeUI3IpKqFwUfXdat5blNng\", \"https://sun9-27.userapi.com/s/v1/ig2/rO4Bje809pYhgHBRXSjjn86m-W8Wz3VUSHNMRJ_0wWgNUiS9932BpGaHjixPqAuOvYjuqEzreYMJKdEffShuqA-E.jpg?quality=95&as=32x22,48x34,72x51,108x76,160x112,240x168,360x253,480x337,540x379,640x449,720x505,1080x758,1280x898,1425x1000&from=bu&u=OY9O4zCVFp4injO1Dp8ovMeuFOAk2rMg2c4flkoHn6A\"]', 0, '2026-04-22 15:22:28', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(287, -186869747, 2570, 'https://vk.com/wall-186869747_2570', '⚡ Официально: АК СибГУ-1 — лидер отборочного этапа!', '⚡ Официально: АК СибГУ-1 — лидер отборочного этапа!\n\nКиберспортивная патриотическая лига «Киберпатриот Квазар» подводит итоги сегодняшних матчей в рамках проекта «Лига Квазар. Кубок Чемпионов».\n\n📍 Площадка проведения: компьютерный клуб «КиберПрайд».\n\nВ дисциплине Counter-Strike команда АК СибГУ-1 продемонстрировала волевую игру и тактическую подготовку, заняв 1-е место в отборочных на финал России.\n\n🥇 Результат: выход на Россию!\n\nРебята стараются каждую игру, и результат не заставил себя ждать! 💪\n\nНаставник и руководитель команды — Талеб Мартен Аднанович.\n\nПоздравляем!!! 🇷🇺🚀🏆', '[\"https://sun9-40.userapi.com/s/v1/ig2/aJq8SpuACcY--vUKTrtLPnwuMyq9BgmLu0-oFSPWOyXWs8jjYK-4rJJ5TmmWgEgRCJPTbIARGIJCQKG2t8vLIJhS.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x181,360x271,480x361,540x407,640x482,720x542,1080x813,1280x964&from=bu&u=GWeg0Apgn7ZbtXt9RotRuDEaVXO2_tLTDfV2FnwxjT4\", \"https://sun9-12.userapi.com/s/v1/ig2/rUZNz7IFQG4PJCwdFaiVaQVSp-llYN8KREXUaTgvfRvpCChGqW5n6O67aDA8kWz4BD33xXGeIpcKDDoOrdoRi-9F.jpg?quality=95&as=32x25,48x38,72x57,108x86,160x127,240x190,360x285,480x380,540x428,640x507,720x570,1080x855,1280x1014,1440x1141,1640x1299&from=bu&u=qoZd5f0uKGVviD_a7Lad1yPek0c1OG12wWGetVr1JUM\", \"https://sun9-65.userapi.com/s/v1/ig2/QyyCDpstCwot7N1co7sdpAXEeeV4g8Ni3MivXJp2-4xsLY4CQKsyTdU8XXsrFh-qjQydx0ZHtLJOEHrhFbuDruAh.jpg?quality=95&as=32x31,48x47,72x70,108x105,160x156,240x234,360x351,480x468,540x526,640x624,720x702,989x964&from=bu&u=ooPq1ryRCNAfysWncs1BCMqclCwjGGYMYWWOPAGVt24\"]', 0, '2026-04-22 10:53:44', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(288, -186869747, 2568, 'https://vk.com/wall-186869747_2568', 'Успех команды «АК БАРС» на муниципальном этапе «Зарницы 2.0»', 'Успех команды «АК БАРС» на муниципальном этапе «Зарницы 2.0»\n\nВ Красноярске завершился городской этап нового сезона военно-патриотической игры «Зарница 2.0». Команда Аэрокосмического колледжа «АК БАРС» (руководитель — В. Н. Карцан) завоевала первое место 🥇. \n\nПобеда далась непросто: спортсменам пришлось работать в сложных погодных условиях (снег, скользкая поверхность, низкая температура), однако командный дух помог преодолеть все трудности.\n\nЧто пришлось преодолеть на пути к успеху:\n\n1. Строевая подготовка — идеальная синхронность, военная выправка и железная дисциплина. Высший пилотаж!\n2. Военизированная эстафета (сплошной драйв и нервы):\n   · сборка/разборка АК и снаряжение магазина;\n   · точная стрельба по биатлонным мишеням;\n   · силовое метание гранат;\n   · эвакуация и спасение «раненого»;\n   · решающая дуэль командиров.\n\nСлаженность действий и взаимовыручка позволили команде показать блестящий результат.\n\nЗональный этап не за горами, «АК БАРС» уже в деле! Гордимся вами безмерно! 🔥', '[\"https://sun9-70.userapi.com/s/v1/ig2/hd_DO0mZPZGAZBay8rDnqwudgDvycPJK3Jx21A5Fluvc4LAuoP8sGT7lqZL8Vj176X3_G5UpLIwd_6vMFabUeESq.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x304,640x360,720x405,1080x607,1280x720&from=bu&u=PqwBK4v0nfqzysTHmJy9BXZNHglN-VlIsA0oUqa2CKA\", \"https://sun9-25.userapi.com/s/v1/ig2/PLB_m9EJEGNQNnCgSwA-y9HShBClrcFI-UBbyVXoIfDQVyAT5W0b2nl_m7uNLH2bh5kinp0R8e8mSce2jZCzmPLQ.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,960x1280&from=bu&u=nNPSHyGtOniPl7WKIcGHjvP5GyUx_3JVSNiVROOAYSI\", \"https://sun9-41.userapi.com/s/v1/ig2/jO9zSyPyB0m_Xz--YOqvwhsFzR-tg55dMxkYuEiHtFUkVLJy5QETw7qLS7h52mUYbmIudiIlB2Ri4CESaJWu278K.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x304,640x360,720x405,1080x607,1280x720&from=bu&u=hTTqMJ6cKYQqbtqHcKpvbyFKzbSYB03aywDn5ucZ9Ow\", \"https://sun9-82.userapi.com/s/v1/ig2/KsCrsbkG-HgqRU5a3E7rQeKIOvNbJObzRDWTCdh9Ui6E3Jt_bt1EU6ZzG1SxyeierCfVUQV87LY62F9DBKMxScN6.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x304,640x360,720x405,1080x607,1280x720&from=bu&u=DD4IZ6TvgswdmX12mjgIjbyogLy2857aempKAoUL-VU\", \"https://sun9-47.userapi.com/s/v1/ig2/UtB4Ff7HA7XaComt5bKh40ErbHgTquaFM1CXYd1-0dxaFPjX1icSQ4SJ7-AJ2JFouFHroa2NqkvkVb54aXy9lWhT.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x269,540x303,640x359,720x404,1080x606,1280x718&from=bu&u=zujtCWlXmOcEMkWlq1SC4mnnW3F2qthsfZT8RfcdEio\", \"https://sun9-27.userapi.com/s/v1/ig2/CcEp4Vl3hifwDVvVIyZIP7OPLpoM0ggl1QCOjOoekJMXJtF6FzYP8JxehMLU8vf9N8fmlxxy05owhOoKBbe1VafT.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x304,640x360,720x405,1080x607,1280x720&from=bu&u=curxuOXM3jQPhQH8bIh0zN4bOHH_kkVqb2atNrl0ViI\", \"https://sun9-22.userapi.com/s/v1/ig2/bQ0FogxipWe4nJYYTR0Tx0pcLj7nAhMMSVPn6kAvN9rYbyyhXskGlZBpF7deL5zJY3fqauIqlsTm08a7PQq-bwj-.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x304,640x360,720x405,1080x607,1280x720&from=bu&u=ahIFe9KoJOjtyd24MVXiNdudibSH_yn4QZBQ8H8yq8Q\", \"https://sun9-5.userapi.com/s/v1/ig2/TcizhQ9xQOK1hMMrl3qYbHO47_dNIu7AhY4GtSKsvD54DhSsbiWyjn_9Qi-N2PtQ1yBM5uSQ96mT1RKCi9r8KFNV.jpg?quality=95&as=32x22,48x32,72x49,108x73,160x108,240x162,360x243,480x324,540x364,640x432,720x486,1080x729,1279x863&from=bu&u=0E5fpYRBw9PwbcHWNa2J3n_yMGbr6mV_AYDXvpqQ_oI\"]', 0, '2026-04-21 12:38:48', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(289, -186869747, 2567, 'https://vk.com/wall-186869747_2567', 'Мошенники не дремлют? Разбираемся, как не попасться 🔥', 'Мошенники не дремлют? Разбираемся, как не попасться 🔥\n\nЗнаете, что объединяет студентов и их родителей в 2026 году? Риск потерять деньги из-за одного телефонного звонка 😱\n\nЧтобы такого не случилось, мы пригласили настоящего эксперта. Сегодня к нам приходила Иванова Дарья Сергеевна — прокурор отдела управления прокуратуры Красноярского края.\n\n Мы обсудили тему, которая касается каждого современного человека, — как не стать жертвой преступлений, совершаемых с помощью IT-технологий.\n\nДарья Сергеевна рассказала о самых распространенных схемах мошенников (звонки из «банка», взлом аккаунтов, фишинг) и о том, как защитить свои персональные данные и сбережения.\n\nОсобенно актуально для молодежи! Будьте бдительны и делитесь этой информацией с друзьями и родителями.', '[\"https://sun9-62.userapi.com/s/v1/ig2/_HH8JtlAUcFbM0xwnhx1mlhFtHn26eHXyvLZkVwqZOSmkhi_RiloYuzy9d4Us1VwRJxCKykyTifcFJEtZRPjHHfn.jpg?quality=95&crop=1,0,1276,960&as=32x24,48x36,72x54,108x81,160x120,240x181,360x271,480x361,540x406,640x481,720x542,1080x813,1276x960&from=bu&u=NFET_HDHRqJnNp6guBAJpoCHDRaS3psWln6Kyb-eoBE\"]', 0, '2026-04-20 08:26:38', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(290, -186869747, 2565, 'https://vk.com/wall-186869747_2565', 'Помнить, чтобы гордиться: студенты и сотрудники Университета Решетнёва напишу…', 'Помнить, чтобы гордиться: студенты и сотрудники Университета Решетнёва напишут «Диктант Победы»\n\n24 апреля 2026 года наш университет станет частью масштабной международной акции «Диктант Победы».\n\nЭто не просто тест. Это возможность для каждого из нас — особенно молодого поколения — прикоснуться к живой истории, отдать дань уважения героям и понять, какой ценой завоевано наше мирное небо. Сегодня, когда предпринимаются попытки переписать прошлое, наша память становится главным оружием.\n\n«Диктант Победы» проводит «Единая Россия» в рамках проекта «Историческая память» (ежегодно с 2019 года). Участвовать может любой желающий, и это особенно ценно: мы не зрители, а хранители правды о 1941–1945 годах.\n\n📍 Где пишем:\n• пр. им. газеты «Красноярский рабочий», 31, ауд. Л-205\n• пр. Мира, 82, ауд. Ц-112 (Синий зал)\n\n🕓 Когда: 24 апреля с 15:00 до 18:00.\n\n✍️ Что взять с собой: паспорт или студенческий билет + чёрную/синюю ручку.\n\nПочему это важно для тебя?\nПотому что знать историю своей страны — значит понимать себя. Потому что подвиг дедов и прадедов — это нравственный компас, который не даёт сбиться с пути. Приходя на Диктант, ты не просто отвечаешь на вопросы — ты говоришь «спасибо» поколению Победителей и передаёшь эту память дальше.\n\nПрисоединяйся! Докажем, что молодёжь России помнит и гордится. 🔥\n\n#ДиктантПобеды #УниверситетРешетнёва #ПомнимГордимся #ИсторическаяПамять #НашаПобеда', '[\"https://sun9-73.userapi.com/s/v1/ig2/OqBYYdcOfXux0BOTVwv-JjHO7NN-ABmuBupIat6KbWcERnfdNkxJbKU1uNK1v7Vq9LooRk-eSjvGMdBks_uU_p7U.jpg?quality=95&crop=0,0,1122,894&as=32x25,48x38,72x57,108x86,160x127,240x191,360x287,480x382,540x430,640x510,720x574,1080x861,1122x894&from=bu&u=91wrgPw1I4UbbLcYJQeDEVwIVoEkoL5_iPOaC5d964o\"]', 0, '2026-04-20 03:14:13', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(291, -186869747, 2564, 'https://vk.com/wall-186869747_2564', 'В Красноярском крае завершился региональный чемпионат «Абилимпикс» 2026', 'В Красноярском крае завершился региональный чемпионат «Абилимпикс» 2026 \nВ Красноярске определены победители и призеры регионального чемпионата по профессиональному мастерству среди инвалидов и людей с ограниченными возможностями здоровья «Абилимпикс» Президентской платформы «Россия – страна возможностей» и Минпросвещения России. Чемпионат проводился с 14.04. по 17.04.2026 года на 15 площадках края. \nВ соревнованиях приняли участие 1349 конкурсантов из 159 учебных заведений региона в том числе учреждений СПО – 51, ВУЗ – 8, школы – 100. По итогам чемпионата 471 человек стали победителями по 88 компетенциям. Победителям и призерам были вручены: дипломы, медали и подарки от спонсоров. \n«Региональный этап чемпионата «Абилимпикс» вновь объединяет тысячи конкурсантов из всех субъектов Российской Федерации. Школьники, студенты и специалисты показали высокий уровень подготовки и получили шанс продолжить участие в соревнованиях в финале. Такой масштаб говорит о том, что движение востребовано и динамично развивается. Отдельно благодарю наставников, которые вкладывают душу в участников. Движение «Абилимпикс» дает возможность каждому молодому человеку найти свой путь в профессии, стать частью сообщества профессионалов и быть уверенным в своем будущем. И мы продолжим поддерживать его мероприятия», – отметил Министр просвещения Российской Федерации Сергей Кравцов. \nКрасноярский край присоединился к движению «Абилимпикс» в 2016 году. За эти 10 лет количество участников регионального чемпионата возросло в 11 раз/раза – с 117 в 2016, до 1349 в 2026 году. Увеличилось и число соревновательных компетенций – с 16, представленных на первом региональном чемпионате, до 88 на текущем. \n«Завершился очередной региональный этап чемпионата профессионального мастерства «Абилимпикс» и в очередной раз участники продемонстрировали невероятную силу воли, упорство и стремление к самореализации. Каждый из вас приложил немало усилий, чтобы оказаться здесь: преодолел сомнения в собственных силах, справился с обучением, переборол волнение в ситуации открытых соревнований. Вы обрели уверенность, общаясь с экспертами, нашли новых друзей, поверили в себя и доказали, что возможности человека поистине безграничны! Ваши успехи – это вдохновение для всех в стремлении сделать этот мир лучше. Вместе мы создаем инклюзивное общество, в котором каждый имеет равные возможности для развития и реализации своих способностей. Более 900 победителей региональных чемпионатов будут бороться за звание лучших в финале Национального чемпионата «Абилимпикс». Желаю вам побед, вдохновения и ярких свершений на этом интересном пути!» – обратился к участникам чемпионата генеральный директор Президентской платформы «Россия – страна возможностей», ректор Мастерской управления «Сенеж» Андрей Бетин. \nДвижение «Абилимпикс» реализуется в рамках федерального проекта «Профессионалитет» национального проекта «Молодежь и дети». Федеральным оператором движения выступает Национальный центр «Абилимпикс» Института развития профессионального образования, осуществляющий научно-методическую и организационно-техническую работу по сопровождению чемпионатов по профессиональному мастерству среди инвалидов и людей с ОВЗ. \n«Региональные чемпионаты вновь показали, насколько сильным и профессиональным становится движение “Абилимпикс”. Для каждого участника это серьёзный шаг вперёд — возможность проверить свои навыки в конкурентной среде, получить объективную оценку экспертов и увидеть перспективы дальнейшего роста. Победители представят свои регионы на Национальном чемпионате, но важно подчеркнуть: уже сам выход на площадку — это результат большой работы и личной победы. “Абилимпикс” продолжает создавать условия, в которых талант, труд и упорство получают реальное профессиональное продолжение. Ждем финалистов на Национальном чемпионате 2026 и верим, что для многих это станет стартом успешной карьеры», – подчеркнула руководитель Федерального методического центра по инклюзивному образованию, Национального центра «Абилимпикс» ФГБОУ ДПО «Институт развития профессионального образования» Дина Макеева. \nСоревновательная программа проходила для трех категорий людей с инвалидностью и ОВЗ, а именно для школьников от 14 лет, студентов и работающих граждан. Наиболее востребованными компетенциями стали: «Бариста», «Оператор БПЛА», «Слесарное дело», «Клининг», «Бисероплетение», «Изготовление мороженного», «Мастер по приготовлению пиццы», «Гончарное дело», «Поварское дело», «Инструктор по адаптивной физической культуре». \nВ этом году в чемпионате Красноярского края были представлены новые направления: «Мастер высокой кухни», «Ювелирное дело», «Гид-экскурсовод», «Токарные работы на станках с ЧПУ», «Исполнительское мастерство (вокал)», «Горничная». Соревнования пройдут в трех категориях – «школьники», «студенты», «специалисты». \n«На чемпионате было все: радость победы, слезы волнения, и вместе со своими наставниками участники прошли этот путь с успехом. Каждый из них доказал, что всё возможно. Те, кто удостоен золотых медалей, уже скоро представят наш Красноярский край на межрегиональном и национальном этапах чемпионата.», – поздравила участников с завершением регионального чемпионата руководитель Регионального центра развития Абилимпикс Оксана Батынская. \nЭЛЬВИДА ЕХАМОВА, победитель по компетенции «Дошкольное воспитание» в категории студенты: «Абилимпикс - удивительный опыт, я рада, что мне посчастливилось попасть в такую профессиональную среду. Было безумно весело и я надеюсь поучаствовать в будущем году тоже!» \nВо время проведения чемпионата на 15 соревновательных площадках участникам помогали более 450 добровольцев из учебных заведений Красноярского края. \nОрганизаторами чемпионата «Абилимпикс» выступили Министерство образования Красноярского края и Центр развития движения «Абилимпикс» при поддержке Национального центра «Абилимпикс» и Президентской платформы «Россия – страна возможностей». \nФинал Национального чемпионата «Абилимпикс» 2026 пройдет в Москве. \nМедиаматериалы доступны по ссылке: [#alias|cloud.mail.ru/public/fJL...|https://cloud.mail.ru/public/fJL5/mQ63JTxiN]\n\n#РоссияСтранаВозможностей\n#ИРПО\n#Абилимпикс2026\n#КрасноярскийКрай\n#РегиональныйЧемпионатАбилимпикс\n#НациональныйЧемпионатАбилимпикс\n#МинпросвещенияРоссия', '[\"https://sun9-23.userapi.com/s/v1/ig2/VdIdwVty9Krc4qGYEo_woTF4FrdFJ78LO_tAnpkC9ikMEbjHpUInMq5yaNEOyajvjhcMFGziJGr9lMauc49Wnm3-.jpg?quality=95&crop=0,0,760,466&as=32x20,48x29,72x44,108x66,160x98,240x147,360x221,480x294,540x331,640x392,720x441,760x466&from=bu&u=J58kufIVGnWXdB3AvY7qi89ZSJkdZZOCKNETUHdbaRc\"]', 0, '2026-04-20 02:02:37', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(292, -186869747, 2561, 'https://vk.com/wall-186869747_2561', '🏐 Золото в честь Великой Победы!', '🏐 Золото в честь Великой Победы!\n\n18 апреля в СибГУ им. М. Ф. Решетнева прошел Фестиваль по миниволей среди студентов профессиональных образовательных организаций, посвященный 81-летию Победы в Великой Отечественной войне.\n\nМы рады сообщить, что команда Аэрокосмического колледжа заняла почетное 1 МЕСТО! 🥇\n\nНаши ребята показали мощную игру, волю к победе и настоящий командный дух. \n\nСибирский характер — золотой результат! 💪\n\nОсобая благодарность тренеру Окружной Н. А. за подготовку чемпионов и веру в команду.\n\nМы гордимся! \n\nВы настоящие победители! Гордимся! 🔥🚀', '[\"https://sun9-52.userapi.com/s/v1/ig2/ZRVOyt7j-hNFy12HMB3XfOUNG95m3RiwvKd5nlRL7zlRh2Sp4SxPeJ51jr_FpFKXgBH2GJAkQVHyPOz3jSS5-I-B.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x404,640x479,720x539,797x597&from=bu&u=-C5UwcEjoU1XzkJdklLEXlwyQgDLOrOUaLt-zB7wscc\", \"https://sun9-71.userapi.com/s/v1/ig2/aFH8pF1Ln5WD3VxptbWK-Nk2dTyD2P_KK_XoapQevwuOZXmqCsNyGIzYx76HnB4me4gtyOULddEnpT1ZF7YcdZt2.jpg?quality=95&as=32x19,48x28,72x42,108x62,160x93,240x139,360x208,480x278,540x312,640x370,720x417,890x515&from=bu&u=-27lnVctMW_Avax06ywsjoyLa4FSoa9WMIuvXrKXFjs\", \"https://sun9-66.userapi.com/s/v1/ig2/AC7CUexWFv0dcmLHdCfC-47MGegZr3zuwvUpFWh5ILu2gleQS_pgLe40BmKFexkgJ-17vOOabtlIK9Pm-wwCSKPA.jpg?quality=95&as=32x23,48x35,72x53,108x79,160x117,240x176,360x263,480x351,540x395,640x468,720x527,905x662&from=bu&u=cy4I5FXgGlwnDRM7a1n721xdbFOWp3joCfoR9NR7t9U\", \"https://sun9-70.userapi.com/s/v1/ig2/M6lXfbFVUhCzc3DM2Dly-7LLm1MBMYI2Ds1V417EETT0wVzmq5-FMvKmXvB4UiMQTeuWB1qld83IuOq2oa2I86np.jpg?quality=95&as=32x49,48x74,72x111,108x166,160x246,240x370,360x554,480x739,540x832,640x986,720x1109,785x1209&from=bu&u=bM6EiYV3a5V7WduFisb-ZkyHOylfK24GZLuiz8emWkA\"]', 0, '2026-04-19 03:56:13', 'pending', NULL, NULL, NULL, NULL, '2026-04-27 16:14:54'),
(293, -186869747, 2596, 'https://vk.com/wall-186869747_2596', '📢 Профориентация в действии: встреча с экспертами «Центра занятости»', 'Сегодня в Аэрокосмическом колледже прошло важное событие для наших студентов 4 курса (5 отделения). В рамках цикла профориентационных мероприятий мы принимали представителей «Центра занятости».\r\n\r\n🎯 Как это было?\r\nСпециалисты центра провели со студентами не просто беседу, а полноценную диагностику. Ребята прошли профессиональное тестирование, которое позволило оценить их актуальные навыки, карьерные возможности и личные приоритеты.\r\n\r\n💼 Почему это важно?\r\nВыпуск 4 курса уже не за горами. Понимание своих сильных сторон и зон роста, а также осознанный выбор первых шагов в карьере — залог успешного трудоустройства. Тестирование помогло каждому участнику взглянуть на себя как на будущего специалиста объективно.\r\n\r\n🤝 Благодарим «Центр занятости» за продуктивную работу и индивидуальный подход к нашим студентам.\r\n\r\nВпереди — новые встречи и возможности. Будьте в курсе событий колледжа, чтобы не пропустить стажировки и вакансии от партнёров!\r\n\r\n#АэрокосмическийКолледж #Профориентация #Студенты4Курса #ЦентрЗанятости', '[\"https://sun1-20.userapi.com/s/v1/ig2/aqllW4nBDQtwdwoMLFIWl0uAG7bxs4b1oIF7lNY5wglQ8jJP_K27KgmGIEPKASPkQiseLFEvR9QToTrVw6N7LtrE.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=lf4QO2KAr7D8dnI6tXcdyL7ML8X4q3ulJAVQ10ujX0I\", \"https://sun1-86.userapi.com/s/v1/ig2/rI0OGR6Up2jxnnJbDt6NVorE9taJgqG6kltyFmv1Cc5yPbOy601sWJ3EvdWPbMQ9w_ZRyWRQU4UlPNPG5Xk5200R.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=JOZCViq7rsfTy_dVhlgUS8AbjpvU_KBABGc5HQaN-ds\", \"https://sun1-55.userapi.com/s/v1/ig2/SWJuU66vtO44cJQPuW5HVBY-gGMs5fLdwAvjnKVad7Ti99Bri6-YOC1So5tG6atWzHIB7oiby4A5eJQR2Ca4kkFP.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=L9gx4xXr3fbQj7BHxA7r_NTrAvEiThk0W8S3cl897r4\", \"https://sun1-56.userapi.com/s/v1/ig2/iYxCWNt3jtcXpB6IziQty_2z-MUZ0dMM_gFF33wUVDG3WECYUQ-yINpNbJD2f8GZS8oPygKO9yqb_h7YDdogbILu.jpg?quality=95&as=32x21,48x32,72x48,108x72,160x107,240x160,360x240,480x320,540x360,640x427,720x480,1080x720,1280x853,1440x960,2560x1707&from=bu&u=xuBZ0A12UpzSKM1qtg5eNGC8hJAb0FO4HFriiBLXwNY\"]', 0, '2026-04-29 08:15:28', 'approved', 57, 1, '2026-04-29 12:00:42', NULL, '2026-04-29 12:00:18'),
(294, -186869747, 2594, 'https://vk.com/wall-186869747_2594', '🔌 НАПРЯЖЕНИЕ БЫЛО МАКСИМАЛЬНЫМ!', 'Сегодня прошёл финал игры «Под напряжением» в формате КВИЗа 🔥\r\n\r\nВ финале участвовало 16 человек, а начинало всё 15 команд! Игра прошла по-настоящему напряжённо, ответственно, а студенты выложились на все 100% 💯\r\n\r\nРады объявить победителей:\r\n\r\n🥇 1 место — Манылов И. Е. (ТАД-9-24)\r\n🥈 2 место — Прудникова С. М. (МР-10-24)\r\n🥉 3 место — Дубов М. В. (ЭЛ-51-24)\r\n\r\nОтдельная благодарность ребятам из ИТ-13-23, которые помогали организовать мероприятие:\r\n\r\n👏 Гапонько М. Е.\r\n👏 Волкова Ю. В.\r\n👏 Петришина Л. Г.\r\n👏 Андреева Д. А.\r\n👏 Телеутова А. Д.\r\n👏 Момотов И. В.\r\n👏 Сомов А. И.\r\n\r\nИ, конечно же, огромное спасибо Площинской Ксении Сергеевне .\r\n\r\nПоздравляем победителей и благодарим всех, кто был с нами! Дальше — больше 💪⚡', '[\"https://sun9-27.userapi.com/s/v1/ig2/Zsr4o3jkrZxGJWfDHc5_FJwPttBH7hruEpfdzHUCJucEHUlnbUD3h7F_6T8Xkgyw3N2uyWRhSVuTf7yrmUMGLGbV.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1040x780&from=bu&u=UNkGML2ZDFTEqL2HJCAn7o0GNWPLFZy5dSWrjb5P4qk\", \"https://sun9-61.userapi.com/s/v1/ig2/DQTW8RyHtKL6BtzPDs4zceDHd-KsnI6E77Szx9W-siuw4K3eePZg8yrz1mdQrSrE_b0lCBTNIG8MpGAyScKUYNKQ.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,768x1024&from=bu&u=GB3olJPEY1MzxGs0tw_yBwPTcloWds00Q9CbPJ5SmiA\", \"https://sun9-64.userapi.com/s/v1/ig2/lrTKUKkBmVjsUuW4DQLo7b8x0zGz12-wcNgWnoOUXXC89YEoMXzyTskp76djF4rPdUJ1GWNTIT3kBjNNoZKNISp_.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,768x1024&from=bu&u=6P0j-ZDpCIkyOvWk07jS1WaHXQYcytbs0yjZtOq95Wk\", \"https://sun9-78.userapi.com/s/v1/ig2/eLCiYW4uMSNADr262xhSNU1ifceajfUuwv5aG1ct2rfTMrKMVSwxqsSw5uh0litHM5a_tI7eLFpxc8WHz1qqOnnD.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1251x1668&from=bu&u=4C1ORv7VhFaI_SzldEprOMmVbSJ4eyikDkMcswUAZPw\"]', 0, '2026-04-29 06:50:51', 'approved', 58, 1, '2026-04-29 12:00:52', NULL, '2026-04-29 12:00:18'),
(295, -186869747, 2593, 'https://vk.com/wall-186869747_2593', '🚀 В Красноярске стартовал крутой профориентационный фестиваль «БАСВокругНас»!', '28-29 апреля в Центре опережающей профессиональной подготовки Красноярского края проходит традиционный фестиваль, посвящённый беспилотным авиационным системам.\r\n\r\n🎯 Цель мероприятия: помочь школьникам и студентам сориентироваться в мире современных профессий и узнать о карьерных возможностях в авиационной отрасли.\r\n\r\n📍 Участники:\r\nСтуденты Аэрокосмического колледжа под руководством преподавателя Лысенко Алексея Михайловича принимают самое активное участие в работе фестиваля. \r\nРебята не только знакомятся с новыми технологиями, но и делятся своим опытом с младшими участниками.\r\n Активно участвуют, заряжают энергией и показывают, где учиться на профессию будущего.', '[\"https://sun9-65.userapi.com/s/v1/ig2/zHn8HibIcApk4zNEg-fbOXM_8p30MopSKOMgyXlY09ss3cEq3vhsBbGH_B2-Vhy72MsEj_lTYbmyJdqvsnMADfxK.jpg?quality=95&as=32x18,48x27,72x40,108x61,160x90,240x135,360x202,480x270,540x303,640x359,720x404,1080x607,1280x719&from=bu&u=l5uD41FV6v1fZl9W-I9WTze1O-KXaZuppmjeybuSms0\", \"https://sun9-50.userapi.com/s/v1/ig2/BxuGMuSLm5NgjZxUbEH2JHkDwq9A6DeytwLUisypUhb3X847YB187BLnehLivYNunFB3clV7ujIb929j10IhGg7I.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=v5YGfPJQ_fA47wMzP7vPqtER-4oBb1eI_D7Pa3AmHMU\", \"https://sun9-53.userapi.com/s/v1/ig2/zDdwYejjBq26G6tI8Orcir3f6bmpAsJ2E1u9i7hoiw1HCB2vBmuUW_KCpNmXYXiSFFFROXhoDB8cjy4br19PlDbg.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=Rq1_vJkuU89Zd8H3MVf8gqEKylO52-Qk2xzADhdj5GI\", \"https://sun9-45.userapi.com/s/v1/ig2/0R2VCOgBH83sPeAa0t852Saufvfv6vhZGRiZv6szSLTnMhJor1IvwY8yuQ2NpBXSLLndOz1MqHhbnTFh6lOF17Px.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=4pT1TTCG055ywkqPlZp_odgBIWeh06gont1M11pvmws\", \"https://sun9-83.userapi.com/s/v1/ig2/NZLC_VBw12iuo1QEPuwCKtE5US0b1S0Jn0XNFq_i0BTXnFOOgnwYEDXu2iNugX4nBvGR3iXE_YNBUiKC9C111UoS.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960&from=bu&u=ySIAiRPLq4dIym8xgpDnF9RYgxflKFliiRdL2M4rIBs\", \"https://sun9-15.userapi.com/s/v1/ig2/g-A0yStBGAr7vruLIOsBIU1n7ku4QWDo0PX-pAJ-3_q_LzFj2PAlWCq5DZBxlTNwfafZzzj4wia5rS3CtlM5d7Kq.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707&from=bu&u=JuA9yXCw8b67aYkEDKghvjIGVcAy1SZGGWWktV6q7QA\", \"https://sun9-85.userapi.com/s/v1/ig2/GJjHE27l82et7Hslb9xVlLWCh8titHvkm78AgCdn1bTYwzRRPnQOB246P-sI1oWTL8OwZ_q7AvovtyyF1YaJCzyM.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707&from=bu&u=8zVaqxvyF5vfT3l64WvjkaUsM9oT0ObzktKssJNa0y8\", \"https://sun9-6.userapi.com/s/v1/ig2/cZr8065o3hEHUgiE12Z3S5W4Jj47dLeixkj8CjH_rDKEnuiilXRVZwqcH4fTz9pvchz5NdMSh9ht_ppG_4szUge4.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707&from=bu&u=1tQL5mEy9qA16sjNllAjjqL_xvvSRM5nJvRfgti-rmU\", \"https://sun9-25.userapi.com/s/v1/ig2/bPnkxldLgi7I-dvktnpLIzfgva0s5VgCLgyGRqskzkAmnhpNOngYPNVS1kzZeTyWLmLq46uALGitfkh_xHiaH2z3.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707&from=bu&u=xyT2o3yplZbHH11dFsNJpYR55jhBKGczWc6PNmIgnjA\"]', 0, '2026-04-29 04:33:15', 'approved', 59, 1, '2026-04-29 12:01:10', NULL, '2026-04-29 12:00:18'),
(296, -186869747, 2592, 'https://vk.com/wall-186869747_2592', '🚀 Студенты Аэрокосмического колледжа — на предприятии машиностроения!', '🚀 Студенты Аэрокосмического колледжа — на предприятии машиностроения!\n\nВ рамках профориентационной работы состоялась экскурсия на производственную площадку ООО «Борус». Машиностроительный завод встретил будущих специалистов групп К-83-23, ТМ-79-22, С-64-23 и ТМП-3-21.\n\nРебята своими глазами увидели, как производится оборудование для спецтехники, и познакомились с современными услугами по обработке металла.\n\n🔧 Экскурсия прошла в формате живого диалога: студенты задавали вопросы о технологических процессах, а опытные специалисты завода давали развернутые ответы.\n\nОсобый интерес вызвала информация о возможностях дальнейшего трудоустройства. Предприятие заинтересовано в молодых кадрах, а наши студенты — в получении практического опыта.\n\nБлагодарим руководство ООО «Борус» за тёплый приём и сотрудничество!', '[\"https://sun9-21.userapi.com/s/v1/ig2/YsHQB34INaOhYY-5e94fn8yLU9pgK95nF02-a4ns6L8W1ptL66CIlFyHl9WqKmkfQUAyD9fwat7ce8C1ibPo-KcS.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=0AYrv6CNSnWsnhpgovAidotxLOd9DsBxU8s-r-Dfvww\", \"https://sun9-2.userapi.com/s/v1/ig2/xvKjRtyFXnL4dlTdf2dP1eYh2BRmJLrrVcSpYlqMFCTHXhx5k8HzV3mE7YQCXK2wjfEOFh3g8VJjlYcLwYLLNFch.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=FmpB2LQA2EXBPqoxUsbMpx3Vw7sdVWXAzWB5dZsPCZw\", \"https://sun9-56.userapi.com/s/v1/ig2/yXPUSyfydW2hYWdCzK4U9LmWBT_qMp2AC6cbHD2IvFStxjvnNfVSDaVhIn-AykD-hCTDINy0-8fuYPXHrxels9IA.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=dDnACIiAA7-HKLt_qYfmzALeka0xVbuAS6TExf0lOYA\", \"https://sun9-41.userapi.com/s/v1/ig2/_eHqI7IqSdmrs-NkKQHoHA-McGie2m5n_3Wr5k8_lzJjULyvILHCqzUITWRX6H_B-vmgO7mWepVOzjciXfLFhGvy.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=PojQdJBQASv8g_R1mrpHfFPymCR7Yi9VkCNILzT2CcA\", \"https://sun9-65.userapi.com/s/v1/ig2/Oygh3Y8N7_CR76sWcS7TN-00K7uFUbJbLCtGk0BQjW10VXQSIBCvRpCaA09Ad34C7u9YnZRLjeyLabqdUnhFKkEA.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=pIgYUxyGfB_qRyaZgQGfe6oU89O53MNE3ogi1bvp2eo\", \"https://sun9-54.userapi.com/s/v1/ig2/ro0u8XJvFsIwDk4kQoZlvWyZYTYUNZuidEegtEaD6lpCVUIRA39-puvg65k1N7J1Ku2S1A3DgovxtnKW-IT-lSgc.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=1rVGy4zdHAhQVRxiEXhKtmOxdMIqJOaNJXPiW-zKYVQ\", \"https://sun9-51.userapi.com/s/v1/ig2/2K65UCGfc7M48j1hIz_unajZJyiFkp9Ss899NBQ0R0cOKvU313-5fWVuerNxQrJYe6XMoZES6GFxpn0sCtC4UCyO.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,750x1000&from=bu&u=hvBoAobI0krxt49BPBZkkM3vIT476x-YWhIHDB4wDM0\", \"https://sun9-19.userapi.com/s/v1/ig2/OswVjrivlOMldkY_wIcXOAeUZ5nUeUX-2gx-6-ALPmrwxKWQBXcIXZrzVw6Dj2Mmf0TownOJ8tyeUvKmsCvED1hr.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=VxmWZnh1k16IAH7kqVuzgTgUlGcrG52TP4jJtC1fwa8\", \"https://sun9-53.userapi.com/s/v1/ig2/5XboUxyr3KDIZnmc4S26TnbpNw9gXwVi6OXt-qw5Qg_XRyMDnK0AS5TgIGppK2ZalwiUE9XY25BSCoz_LhMS6kJY.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=4WaqoBCNxM5WUa_hyFlYwUUxpW1kKuKAinhclHALk8M\", \"https://sun9-41.userapi.com/s/v1/ig2/NoaebZ1K8AmLEXElomzmT79lFvPWqqIhrwfTKQl1PtoaEzWeofofJwZ64UqOQTBD29x1LE6lITIac_1ymNtqTipb.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1000x750&from=bu&u=D9DjEUydCeC5GGFTI4TCzxOu_j88A-XE86pbNR_S7s0\"]', 0, '2026-04-28 08:54:44', 'pending', NULL, NULL, NULL, NULL, '2026-04-29 12:00:18');
INSERT INTO `vk_pending_stories` (`id`, `vk_owner_id`, `vk_post_id`, `vk_post_url`, `title`, `content`, `images_json`, `selected_image`, `vk_published_at`, `status`, `published_story_id`, `reviewed_by_user_id`, `reviewed_at`, `reject_reason`, `created_at`) VALUES
(323, -186869747, 2599, 'https://vk.com/wall-186869747_2599', '🌿 С 20 апреля в Аэрокосмическом колледже стартовала акция «Зелёный десант» —…', '«Зелёный десант» — и сегодня, 30 апреля, мы достойно завершили её марафоном чистоты!\r\n\r\nНаши студенты вместе со всеми горожанами вышли на общегородской субботник. Было весело, активно, позитивно — но главное, что за этими эмоциями стоит настоящая польза.\r\n\r\n💚 Почему это важно именно для колледжа?\r\n«Зелёный десант» показал: аэрокосмический колледж — это не просто учёба и лекции. Это команда, которой не всё равно. Студенты своим примером доказывают, что ответственность и уважение к окружающей среде — такие же важные навыки, как и профессиональные.\r\n\r\n🏙️ А что это даёт городу?\r\nДесятки очищенных территорий, убранные парки, дворы и общественные пространства. Город преображается не только внешне, но и по атмосфере. Совместный труд объединяет жителей, делает улицы уютнее, а воздух — чище.\r\n\r\n🔥 Огромное спасибо каждому студенту, преподавателю и всем горожанам, кто взял в руки грабли и метлы! Мы доказали: вместе мы можем больше. И это только начало.\r\n\r\n#ЗеленыйДесант #АэрокосмическийКолледж #Субботник2026 #ЧистыйГород #НашеБудущее', '[\"https://sun9-6.userapi.com/s/v1/ig2/RHJs3bzzHZnG99hx8P3z7pNCDOzJN5pNS6Mr9PbZu9k1UoxO6KgzVq8BPzY3j3ez2Y59dtxXXR8jMN8uhZ-jP5wY.jpg?quality=95&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720,1080x1080,1280x1280&from=bu&u=Fvh0YWsfs8czuLVpiJjujRYm5AEf-PRNPeUmDJ7TrlY\", \"https://sun9-78.userapi.com/s/v1/ig2/9nu15WRS__3cbr-GUfoGIVU2NgYJq6mSUvXAdtCi4MCN0rGWhT6nNWMjSNz-IUh470PKAxcMKmBsVx55qL2W3a5b.jpg?quality=95&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720,1080x1080,1280x1280&from=bu&u=uKkle9e-uYwn9-4KL5TPUQM6YUOWOCZNtH5ZoS80cTw\", \"https://sun9-55.userapi.com/s/v1/ig2/2906vmfv6rqtboOazUXML6mYrVOGzfwjq2tlKRv05ox-ifvN-EIpfWsGv1Ob0jVH4VDxDJx7fg6mf5uGqdfVYPbu.jpg?quality=95&as=32x32,48x47,72x71,108x106,160x158,240x237,360x355,480x473,540x533,640x631,720x710,721x711&from=bu&u=n9EcQLdV2N3DzsvfXmFnAI5HWLAkF_H7PgTN_x0ESuk\", \"https://sun9-38.userapi.com/s/v1/ig2/Mw5uX5XVbzeHh8GwoLIB6lzFoV3PkMysSds2tS3G1-nZ5em2c-RsYjDABaCj6mh_v7ZuwX0byyTc7VX2kKHMAxdx.jpg?quality=95&as=32x22,48x33,72x49,108x74,160x109,240x163,360x245,480x327,540x368,640x436,720x490,1080x736,1280x872,1440x981,1693x1153&from=bu&u=YiuRq9yXkrpw6Bzlxr5HKFLOd_HaRDLfYmpPTX04zjg\", \"https://sun9-10.userapi.com/s/v1/ig2/Rubr39Y0yAf3QKbSWiAvbK3k1IRMFv03B8DgUf30rchvLci4tzTLTqJDJnF8-WaEWtFJwGYCinKcUYlusW1wOAWc.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=La_P39DRgGj0H5UPFqFTjJswUY9FEh4d1NVElejigW0\", \"https://sun9-38.userapi.com/s/v1/ig2/eYakZ1LheYUy0s7Kc5xCxonqtuN7wE_h9Hd0--5Ns67zpVoXRvkta8Vg3if2qXaa8q2khopatjGoBbRgNXOQZzb1.jpg?quality=95&as=32x38,48x56,72x85,108x127,160x188,240x282,360x423,480x564,540x635,640x752,720x846,1080x1270,1280x1505,1440x1693,1920x2257&from=bu&u=17aOGH39A6i90TfCAGucl8F3UT5yJhOJOfTAlokL9KE\", \"https://sun9-74.userapi.com/s/v1/ig2/iIW5gqVFZzX8or28afxg6e2ZZqIZgwep-OIiKBxLsQaw-954YpDfPqGzq1fjewxNYZVBsa2ntCkXiMehGNDqcz31.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=30jJoITdHy7KFwHyA8F60WKRgtPCsAGtO8tAJD8gKxI\", \"https://sun9-50.userapi.com/s/v1/ig2/_HF1t3AYrhM6JpBR5AXWaO5mgtauAhATziI0DnglNAa7Alcwg62YLSINxZH1TAZqYRYTfpFEZq9n94Phnv_trhMn.jpg?quality=95&as=32x39,48x58,72x87,108x130,160x193,240x290,360x434,480x579,540x652,640x772,720x869,1080x1303,1280x1545,1440x1738,1920x2317&from=bu&u=SGXPOqf3DPpCKkGaTHsSlyuF_W7tgCgggBu6drAKE3Q\", \"https://sun9-46.userapi.com/s/v1/ig2/ElQuwcc7TEgaZcOuwk_416JxIblae1zme_787i6Z_KHqlf9mVnjvGlzGJIoK7q5KKe9Xp-9FlYggjbqE35w0W20D.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=OTcKd5R-_JdS_otKTRQpWdojVLruZb39oPVWVUZXLHU\"]', 0, '2026-04-30 08:23:54', 'approved', 61, 1, '2026-05-01 07:26:52', NULL, '2026-05-01 07:26:09'),
(337, -186869747, 2601, 'https://vk.com/wall-186869747_2601', '🚀 Это событие — важная веха для всего нашего коллектива!', '🚀 Это событие — важная веха для всего нашего коллектива!\r\n\r\nС 13 по 15 апреля в Санкт-Петербурге прошёл VIII Всероссийский педагогический съезд системы образования России. Мероприятие объединило участников в очном и дистанционном форматах.\r\n\r\nДля Аэрокосмического колледжа участие в таком масштабном событии — это возможность заявить о себе на федеральном уровне, обменяться опытом с ведущими образовательными организациями страны и подтвердить высокий уровень подготовки студентов.\r\n\r\nИтог нашего участия — Диплом лауреата Всероссийского конкурса «500 лучших образовательных организаций страны — 2026».\r\n\r\n🏆 Эта награда — прямое признание ежедневного труда каждого преподавателя, мастера производственного обучения и сотрудника колледжа. Именно ваше мастерство, неравнодушие и профессионализм приносят такие результаты.\r\n\r\nГордимся!', '[\"https://sun9-19.userapi.com/s/v1/ig2/Sp2gR7DzFedgWAEGJQbQ-4LlO_kBn6JXK-_jrvQreuw378OyRCVNaVHQJU7lPRynYiPEVPwIROCB2gYsMe6v7cmV.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=Z0sm_2hGuxwQrP--16XM_yQ1lC13hT429N08SzF3YFA\", \"https://sun9-80.userapi.com/s/v1/ig2/0a68GeNwg4V0RGa-59RpllI2CERcw0QKlj1Y_p8_7IU-MbPKjiNSjaDDZFVYAjMSVMyBV15vj9w0B86a9XXLatkI.jpg?quality=95&as=32x43,48x65,72x98,108x147,160x218,240x326,360x489,480x653,540x734,640x870,720x979,1080x1468,1280x1740,1440x1958,1883x2560&from=bu&u=bacItUqgdf2RpVCznTMiiliJJZeXqz0RRyxSGOiReZE\", \"https://sun1-86.userapi.com/s/v1/ig2/vkGXl7M9-ggbrYH4wOrKjGMuqgtcjhHg4syaPeHkQyuVm27e4mocZL4C3wGWb3djRH5yyw4MxNw7sXT4uzGiFz11.jpg?quality=95&as=32x43,48x64,72x96,108x144,160x213,240x320,360x480,480x640,540x720,640x853,720x960,1080x1440,1280x1707,1440x1920,1920x2560&from=bu&u=javuWCc1k-RvHGeXgPgJ5fNduFW84RzMqj83gOKBUpQ\"]', 0, '2026-05-04 05:33:01', 'approved', 62, 1, '2026-05-05 13:36:11', NULL, '2026-05-04 08:31:48'),
(352, -186869747, 2602, 'https://vk.com/wall-186869747_2602', 'Сегодня на правобережной площадке Университета Решетнева прошёл торжественный…', 'Сегодня на правобережной площадке Университета Решетнева прошёл торжественный митинг, посвящённый 81-й годовщине Победы в Великой Отечественной войне.\n\nВ этот памятный день преподаватели, студенты и почётные гости собрались вместе, чтобы отдать дань уважения героизму советского народа. \nС приветственным словом к собравшимся обратился Э. Ш. Акбулатов, подчеркнув важность сохранения исторической памяти и преемственности поколений, поздравил всех присутствующих с этой святой датой, а мы еще раз задумались о том, как хрупок мир и как важно беречь историю.\nМы помним подвиг наших предков и гордимся их мужеством. Вечная слава героям! 🕊', '[\"https://sun9-21.userapi.com/s/v1/ig2/yd-rQGWo3BJVLJZmc0eqxURuJlueayXKJopj1phsRDuK2jqSTQMW_nG37Pnc20alVTVMxDxZexqS5Fk1B4AR100u.jpg?quality=95&as=32x29,48x44,72x66,108x99,160x147,240x221,360x331,480x442,540x497,640x589,720x663,1080x994,1280x1178,1440x1325,2399x2208&from=bu&u=JNiwozGthTBZih7yxBYXulOX3dfCHDMeQi-kq8to-_U\", \"https://sun9-11.userapi.com/s/v1/ig2/TvswMmXzvXNLyt2ZPDhnFGPtM0gvcdlF_-WhDcN_Pvh4Ag3lp7G4zXUtSNxOM9hYwMCBnWSJhDeegIm1w-q8GMtP.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x959,1440x1079,2560x1919&from=bu&u=iXbhj6BWIQRFRig41u-ZfzD4VmtmZRuPZY2EHgurcaE\", \"https://sun9-56.userapi.com/s/v1/ig2/Wyc0Ke3178WC_RqFWrgqqVJpEnlMCDWm-YgJgxhs6fcpFujLSAQ2qUzHK30wvvLK8TUIFW-7gY7FdatBoBLOCYh0.jpg?quality=95&as=32x22,48x33,72x49,108x74,160x109,240x164,360x246,480x328,540x368,640x437,720x491,1080x737,1280x873,1440x983,2560x1747&from=bu&u=7hZVYLw2-dnKt35DEme4I21IVnJgViDZh6VIN5TcNPQ\", \"https://sun9-59.userapi.com/s/v1/ig2/8Wr4MB7lO96SD7aLvvkN1u8hrxlv5_tThbyQ40MFkNBAKcEIqPl30w_EMUfCyexdTX8QassRHXrx6-KsI-WK-dG8.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x959,1440x1079,2560x1919&from=bu&u=P5BeXR0sPreZN5VXNQieYf-QNVbDwlltz6Cvezs3IV4\", \"https://sun9-29.userapi.com/s/v1/ig2/6bN8U4qkN7fRKWvICxsxgtadL6cLC5wZYEfZw-BhmoGnwed2P782deozKgJq8LgLBxXjI6z3xLMOe4CyadByY2oz.jpg?quality=95&as=32x30,48x46,72x68,108x103,160x152,240x228,360x342,480x456,540x513,640x607,720x683,1080x1025,1280x1215,1440x1367,2560x2430&from=bu&u=ybUztvZd3RGLd-In1ROQfMzyCNMvw14B9CAyFClN6H0\", \"https://sun9-26.userapi.com/s/v1/ig2/vHASsmDnHTWw1frJjtLXBndctoz06jsULZtaWw3X-Wmyniac15pqLlA1iGf2rnHKNsLsfwd1xsL_pFJ8nC1TKNi5.jpg?quality=95&as=32x24,48x36,72x54,108x81,160x120,240x180,360x270,480x360,540x405,640x480,720x540,1080x810,1280x960,1440x1080,2560x1920&from=bu&u=BYpTw-Ngm-lMo90HuNOl-mFIuJbGFcwqc98d9TyWY_c\"]', 0, '2026-05-05 07:49:56', 'pending', NULL, NULL, NULL, NULL, '2026-05-05 13:45:25');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `admin_login_log`
--
ALTER TABLE `admin_login_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_admin_login_user` (`user_id`),
  ADD KEY `idx_admin_login_created` (`created_at`,`id`);

--
-- Индексы таблицы `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_applications_status` (`status`,`type`,`created_at`,`id`),
  ADD KEY `idx_applications_status_created` (`status`,`created_at`,`id`),
  ADD KEY `idx_applications_type` (`type`,`created_at`,`id`);

--
-- Индексы таблицы `application_files`
--
ALTER TABLE `application_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_app_files_app` (`application_id`);

--
-- Индексы таблицы `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_audit_user` (`user_id`),
  ADD KEY `idx_audit_created` (`created_at`,`id`);

--
-- Индексы таблицы `bell_schedule`
--
ALTER TABLE `bell_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_contacts_active` (`is_active`,`sort_order`,`id`),
  ADD KEY `idx_contacts_category_active` (`category`,`is_active`);

--
-- Индексы таблицы `content_revisions`
--
ALTER TABLE `content_revisions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_content_revisions_user` (`created_by`),
  ADD KEY `idx_content_revisions_entity` (`entity_type`,`entity_id`,`id`);

--
-- Индексы таблицы `disciplines_ref`
--
ALTER TABLE `disciplines_ref`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_disciplines_active_title` (`is_active`,`title`,`id`);

--
-- Индексы таблицы `education_programs`
--
ALTER TABLE `education_programs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_education_program_type_title` (`type`,`title`),
  ADD KEY `idx_education_programs_published` (`is_published`,`type`,`sort_order`,`id`);

--
-- Индексы таблицы `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_events_author` (`created_by`),
  ADD KEY `idx_events_category_starts` (`category`,`starts_at`),
  ADD KEY `idx_events_partner` (`partner_id`),
  ADD KEY `idx_events_published_starts` (`is_published`,`starts_at`);

--
-- Индексы таблицы `groups_ref`
--
ALTER TABLE `groups_ref`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `fk_groups_curator_staff` (`curator_staff_id`),
  ADD KEY `idx_groups_specialty_course_active` (`specialty_id`,`course_year`,`is_active`);

--
-- Индексы таблицы `group_schedule`
--
ALTER TABLE `group_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_group_schedule_group` (`group_id`);

--
-- Индексы таблицы `media_assets`
--
ALTER TABLE `media_assets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_media_created_by` (`created_by`),
  ADD KEY `idx_media_audience` (`audience`,`is_published`,`sort_order`,`id`);

--
-- Индексы таблицы `news_items`
--
ALTER TABLE `news_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_news_author` (`author_user_id`),
  ADD KEY `idx_news_published` (`is_published`,`published_at`,`id`);

--
-- Индексы таблицы `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `fk_pages_created_by` (`created_by`),
  ADD KEY `fk_pages_updated_by` (`updated_by`),
  ADD KEY `idx_pages_audience_slug` (`audience`,`slug`,`is_published`);

--
-- Индексы таблицы `partners`
--
ALTER TABLE `partners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_partners_published` (`is_published`,`sort_order`,`id`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Индексы таблицы `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`key`);

--
-- Индексы таблицы `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_specialties_published` (`is_published`,`sort_order`,`id`);

--
-- Индексы таблицы `specialty_curriculum`
--
ALTER TABLE `specialty_curriculum`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_curriculum` (`specialty_id`,`semester`,`discipline_id`),
  ADD KEY `fk_curriculum_discipline` (`discipline_id`),
  ADD KEY `idx_curriculum_specialty_semester_sort` (`specialty_id`,`semester`,`sort_order`,`id`);

--
-- Индексы таблицы `staff_members`
--
ALTER TABLE `staff_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_staff_published` (`is_published`,`sort_order`,`id`),
  ADD KEY `idx_staff_department_pub` (`department`,`is_published`);

--
-- Индексы таблицы `stories`
--
ALTER TABLE `stories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stories_published` (`is_published`,`sort_order`,`id`);

--
-- Индексы таблицы `student_portfolio_items`
--
ALTER TABLE `student_portfolio_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_student_portfolio_user` (`student_user_id`,`is_published`,`sort_order`,`id`),
  ADD KEY `idx_portfolio_student_pub` (`student_user_id`,`is_published`),
  ADD KEY `idx_portfolio_specialty` (`specialty_id`);

--
-- Индексы таблицы `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `student_code` (`student_code`),
  ADD KEY `fk_student_profile_group` (`group_id`),
  ADD KEY `fk_student_profile_curator` (`curator_staff_id`);

--
-- Индексы таблицы `student_resumes`
--
ALTER TABLE `student_resumes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_student_resume_user` (`student_user_id`,`is_published`,`id`);

--
-- Индексы таблицы `teacher_profiles`
--
ALTER TABLE `teacher_profiles`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `fk_teacher_profile_staff` (`staff_member_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Индексы таблицы `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `fk_user_roles_role` (`role_id`);

--
-- Индексы таблицы `vacancies`
--
ALTER TABLE `vacancies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vacancies_active` (`is_active`,`published_at`,`id`),
  ADD KEY `idx_vacancies_partner` (`partner_id`),
  ADD KEY `idx_vacancies_active_pub` (`is_active`,`published_at`),
  ADD KEY `idx_vacancies_expires` (`expires_at`);

--
-- Индексы таблицы `vk_parser_runs`
--
ALTER TABLE `vk_parser_runs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `vk_pending_stories`
--
ALTER TABLE `vk_pending_stories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_vk_post` (`vk_owner_id`,`vk_post_id`),
  ADD KEY `idx_vk_pending_status` (`status`,`vk_published_at`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `admin_login_log`
--
ALTER TABLE `admin_login_log`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT для таблицы `applications`
--
ALTER TABLE `applications`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT для таблицы `application_files`
--
ALTER TABLE `application_files`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT для таблицы `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=308;

--
-- AUTO_INCREMENT для таблицы `bell_schedule`
--
ALTER TABLE `bell_schedule`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `content_revisions`
--
ALTER TABLE `content_revisions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `disciplines_ref`
--
ALTER TABLE `disciplines_ref`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `education_programs`
--
ALTER TABLE `education_programs`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `groups_ref`
--
ALTER TABLE `groups_ref`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `group_schedule`
--
ALTER TABLE `group_schedule`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `media_assets`
--
ALTER TABLE `media_assets`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `news_items`
--
ALTER TABLE `news_items`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `partners`
--
ALTER TABLE `partners`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT для таблицы `specialties`
--
ALTER TABLE `specialties`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `specialty_curriculum`
--
ALTER TABLE `specialty_curriculum`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `staff_members`
--
ALTER TABLE `staff_members`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `stories`
--
ALTER TABLE `stories`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT для таблицы `student_portfolio_items`
--
ALTER TABLE `student_portfolio_items`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `student_resumes`
--
ALTER TABLE `student_resumes`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT для таблицы `vacancies`
--
ALTER TABLE `vacancies`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `vk_parser_runs`
--
ALTER TABLE `vk_parser_runs`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT для таблицы `vk_pending_stories`
--
ALTER TABLE `vk_pending_stories`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=366;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `admin_login_log`
--
ALTER TABLE `admin_login_log`
  ADD CONSTRAINT `fk_admin_login_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `application_files`
--
ALTER TABLE `application_files`
  ADD CONSTRAINT `fk_app_files_app` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `content_revisions`
--
ALTER TABLE `content_revisions`
  ADD CONSTRAINT `fk_content_revisions_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_author` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_events_partner` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `groups_ref`
--
ALTER TABLE `groups_ref`
  ADD CONSTRAINT `fk_groups_curator_staff` FOREIGN KEY (`curator_staff_id`) REFERENCES `staff_members` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_groups_specialty` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `group_schedule`
--
ALTER TABLE `group_schedule`
  ADD CONSTRAINT `fk_group_schedule_group` FOREIGN KEY (`group_id`) REFERENCES `groups_ref` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `media_assets`
--
ALTER TABLE `media_assets`
  ADD CONSTRAINT `fk_media_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `news_items`
--
ALTER TABLE `news_items`
  ADD CONSTRAINT `fk_news_author` FOREIGN KEY (`author_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `fk_pages_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pages_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ограничения внешнего ключа таблицы `specialty_curriculum`
--
ALTER TABLE `specialty_curriculum`
  ADD CONSTRAINT `fk_curriculum_discipline` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines_ref` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_curriculum_specialty` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `student_portfolio_items`
--
ALTER TABLE `student_portfolio_items`
  ADD CONSTRAINT `fk_portfolio_specialty` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student_portfolio_user` FOREIGN KEY (`student_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD CONSTRAINT `fk_student_profile_curator` FOREIGN KEY (`curator_staff_id`) REFERENCES `staff_members` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_student_profile_group` FOREIGN KEY (`group_id`) REFERENCES `groups_ref` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_student_profile_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `student_resumes`
--
ALTER TABLE `student_resumes`
  ADD CONSTRAINT `fk_student_resumes_user` FOREIGN KEY (`student_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `teacher_profiles`
--
ALTER TABLE `teacher_profiles`
  ADD CONSTRAINT `fk_teacher_profile_staff` FOREIGN KEY (`staff_member_id`) REFERENCES `staff_members` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_teacher_profile_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `vacancies`
--
ALTER TABLE `vacancies`
  ADD CONSTRAINT `fk_vacancies_partner` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
