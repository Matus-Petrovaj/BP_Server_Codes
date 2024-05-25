-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: localhost:3306
-- Čas generovania: So 25.Máj 2024, 10:50
-- Verzia serveru: 10.11.4-MariaDB-1~deb12u1
-- Verzia PHP: 8.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `Lab_DB`
--
CREATE DATABASE IF NOT EXISTS `Lab_DB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `Lab_DB`;

DELIMITER $$
--
-- Procedúry
--
DROP PROCEDURE IF EXISTS `ResetIncrement`$$
CREATE DEFINER=`paterson`@`localhost` PROCEDURE `ResetIncrement` ()   BEGIN
    DECLARE currentVal INT;
    SELECT AUTO_INCREMENT INTO currentVal FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'distance_db' AND TABLE_NAME = 'distance_table';
    IF currentVal >= 310 THEN
        SET @sql = CONCAT('ALTER TABLE distance_table AUTO_INCREMENT = 1');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `bme_table`
--

DROP TABLE IF EXISTS `bme_table`;
CREATE TABLE `bme_table` (
                             `id` bigint(20) UNSIGNED NOT NULL,
                             `temperature` float DEFAULT NULL,
                             `humidity` float DEFAULT NULL,
                             `pressure` float DEFAULT NULL,
                             `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `distance_table`
--

DROP TABLE IF EXISTS `distance_table`;
CREATE TABLE `distance_table` (
                                  `id` bigint(20) NOT NULL,
                                  `distance` int(11) DEFAULT NULL,
                                  `timestamp` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `gas_table`
--

DROP TABLE IF EXISTS `gas_table`;
CREATE TABLE `gas_table` (
                             `id` bigint(20) NOT NULL,
                             `ppm` double DEFAULT NULL,
                             `timestamp` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `node_1_bme_table`
--

DROP TABLE IF EXISTS `node_1_bme_table`;
CREATE TABLE `node_1_bme_table` (
                                    `id` bigint(20) UNSIGNED NOT NULL,
                                    `temperature` float DEFAULT NULL,
                                    `humidity` float DEFAULT NULL,
                                    `pressure` float DEFAULT NULL,
                                    `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `node_1_gas_table`
--

DROP TABLE IF EXISTS `node_1_gas_table`;
CREATE TABLE `node_1_gas_table` (
                                    `id` bigint(20) NOT NULL,
                                    `ppm` double DEFAULT NULL,
                                    `timestamp` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `node_2_bme_table`
--

DROP TABLE IF EXISTS `node_2_bme_table`;
CREATE TABLE `node_2_bme_table` (
                                    `id` bigint(20) UNSIGNED NOT NULL,
                                    `temperature` float DEFAULT NULL,
                                    `humidity` float DEFAULT NULL,
                                    `pressure` float DEFAULT NULL,
                                    `timestamp` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `node_2_gas_table`
--

DROP TABLE IF EXISTS `node_2_gas_table`;
CREATE TABLE `node_2_gas_table` (
                                    `id` bigint(20) NOT NULL,
                                    `ppm` double DEFAULT NULL,
                                    `timestamp` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `bme_table`
--
ALTER TABLE `bme_table`
    ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `distance_table`
--
ALTER TABLE `distance_table`
    ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `gas_table`
--
ALTER TABLE `gas_table`
    ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `node_1_bme_table`
--
ALTER TABLE `node_1_bme_table`
    ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `node_1_gas_table`
--
ALTER TABLE `node_1_gas_table`
    ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `node_2_bme_table`
--
ALTER TABLE `node_2_bme_table`
    ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `node_2_gas_table`
--
ALTER TABLE `node_2_gas_table`
    ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `bme_table`
--
ALTER TABLE `bme_table`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `distance_table`
--
ALTER TABLE `distance_table`
    MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `gas_table`
--
ALTER TABLE `gas_table`
    MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `node_1_bme_table`
--
ALTER TABLE `node_1_bme_table`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `node_1_gas_table`
--
ALTER TABLE `node_1_gas_table`
    MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `node_2_bme_table`
--
ALTER TABLE `node_2_bme_table`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pre tabuľku `node_2_gas_table`
--
ALTER TABLE `node_2_gas_table`
    MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

DELIMITER $$
--
-- Udalosti
--
DROP EVENT IF EXISTS `GasCleanupEvent`$$
CREATE DEFINER=`paterson`@`localhost` EVENT `GasCleanupEvent` ON SCHEDULE EVERY 1 HOUR STARTS '2024-02-11 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM gas_table WHERE timestamp < NOW() - INTERVAL 1 MONTH$$

DROP EVENT IF EXISTS `DistanceCleanupEvent`$$
CREATE DEFINER=`paterson`@`localhost` EVENT `DistanceCleanupEvent` ON SCHEDULE EVERY 1 HOUR STARTS '2024-02-11 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM distance_table WHERE timestamp < NOW() - INTERVAL 1 MONTH$$

DROP EVENT IF EXISTS `BmeCleanupEvent`$$
CREATE DEFINER=`paterson`@`localhost` EVENT `BmeCleanupEvent` ON SCHEDULE EVERY 1 HOUR STARTS '2024-02-11 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM bme_table WHERE timestamp < NOW() - INTERVAL 1 MONTH$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
