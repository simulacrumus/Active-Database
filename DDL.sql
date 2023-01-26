CREATE DATABASE  IF NOT EXISTS `Active`;
USE `Active`;

SET TIME_ZONE='-05:00';

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
CREATE TABLE `facility` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(25) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url` varchar(250) NOT NULL,
  `address` varchar(250) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `email` varchar(50) NOT NULL,
  `lng` decimal(12,10) NOT NULL,
  `lat` decimal(12,10) NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`),
  UNIQUE KEY `key` (`key`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(25) NOT NULL,
  `title` varchar(50) NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `pool`
--

DROP TABLE IF EXISTS `pool`;
CREATE TABLE `pool` (
  `id` int NOT NULL AUTO_INCREMENT,
  `length` int NOT NULL,
  `title` varchar(50) NOT NULL,
  `indoor` tinyint(1) NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(25) NOT NULL,
  `title` varchar(50) NOT NULL,
  `category_id` int NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `key` (`key`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `type_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `type_id` int NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `facility_reservation`
--

DROP TABLE IF EXISTS `facility_reservation`;
CREATE TABLE `facility_reservation` (
  `id` varchar(30) NOT NULL,
  `facility_id` int NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_id` (`facility_id`),
  CONSTRAINT `facility_reservation_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `available_activity`
--

DROP TABLE IF EXISTS `available_activity`;
CREATE TABLE `available_activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `available` tinyint NOT NULL,
  `facility_reservation_id` varchar(30) NOT NULL,
  `activity_id` int NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_reservation_id` (`facility_reservation_id`),
  KEY `activity_id` (`activity_id`),
  CONSTRAINT `available_activity_ibfk_1` FOREIGN KEY (`facility_reservation_id`) REFERENCES `facility_reservation` (`id`),
  CONSTRAINT `available_activity_ibfk_2` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=530 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `facility_activity`
--

DROP TABLE IF EXISTS `facility_activity`;
CREATE TABLE `facility_activity` (
  `facility_id` int NOT NULL,
  `activity_id` int NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`facility_id`,`activity_id`),
  KEY `activity_id` (`activity_id`),
  CONSTRAINT `facility_activity_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`id`),
  CONSTRAINT `facility_activity_ibfk_2` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `facility_pool`
--

DROP TABLE IF EXISTS `facility_pool`;
CREATE TABLE `facility_pool` (
  `id` int NOT NULL AUTO_INCREMENT,
  `facility_id` int NOT NULL,
  `pool_id` int NOT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facility_id` (`facility_id`),
  KEY `pool_id` (`pool_id`),
  CONSTRAINT `facility_pool_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`id`),
  CONSTRAINT `facility_pool_ibfk_2` FOREIGN KEY (`pool_id`) REFERENCES `pool` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
