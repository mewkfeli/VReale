-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: vreale
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookmarks`
--

DROP TABLE IF EXISTS `bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookmarks` (
  `bookmark_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  PRIMARY KEY (`bookmark_id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `bookmarks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bookmarks_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks`
--

LOCK TABLES `bookmarks` WRITE;
/*!40000 ALTER TABLE `bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id_comment` int NOT NULL,
  `comment_content` varchar(45) NOT NULL,
  `id_post` int NOT NULL,
  `id_message_reply` int DEFAULT NULL,
  `id_user` int NOT NULL,
  PRIMARY KEY (`id_comment`),
  KEY `id_post_fk_idx` (`id_post`),
  KEY `id_reply_fk_idx` (`id_message_reply`),
  KEY `id_comments_user_fk_idx` (`id_user`),
  CONSTRAINT `id_comments_user_fk` FOREIGN KEY (`id_user`) REFERENCES `users` (`user_id`),
  CONSTRAINT `id_post_fk` FOREIGN KEY (`id_post`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `id_reply_fk` FOREIGN KEY (`id_message_reply`) REFERENCES `comments` (`id_comment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dailytopics`
--

DROP TABLE IF EXISTS `dailytopics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dailytopics` (
  `topic_id` int NOT NULL AUTO_INCREMENT,
  `tag_id` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`topic_id`),
  UNIQUE KEY `date` (`date`,`tag_id`),
  KEY `tag_id_fk_idx` (`tag_id`),
  CONSTRAINT `tag_id_fk` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dailytopics`
--

LOCK TABLES `dailytopics` WRITE;
/*!40000 ALTER TABLE `dailytopics` DISABLE KEYS */;
/*!40000 ALTER TABLE `dailytopics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_types`
--

DROP TABLE IF EXISTS `post_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_types` (
  `id_post_type` int NOT NULL AUTO_INCREMENT,
  `post_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_post_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_types`
--

LOCK TABLES `post_types` WRITE;
/*!40000 ALTER TABLE `post_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `post_type` int NOT NULL,
  `visibility` enum('public','private','subscribers_only','archived') DEFAULT 'public',
  `parent_post_id` int DEFAULT NULL,
  `is_thread_starter` tinyint(1) DEFAULT '0',
  `is_hidden` tinyint(1) DEFAULT '0',
  `common_post_type` int NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `idx_posts_visibility` (`visibility`),
  KEY `common_type_fk_idx` (`common_post_type`),
  KEY `user_id_fk_idx` (`user_id`),
  KEY `post_type_fk_idx` (`post_type`),
  FULLTEXT KEY `ft_post_content` (`content`),
  CONSTRAINT `common_type_fk` FOREIGN KEY (`common_post_type`) REFERENCES `type_common` (`id_type_common`),
  CONSTRAINT `post_type_fk` FOREIGN KEY (`post_type`) REFERENCES `post_types` (`id_post_type`),
  CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posttags`
--

DROP TABLE IF EXISTS `posttags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posttags` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `posttag_fk_2_idx` (`tag_id`),
  CONSTRAINT `posttag_fk` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `posttag_fk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posttags`
--

LOCK TABLES `posttags` WRITE;
/*!40000 ALTER TABLE `posttags` DISABLE KEYS */;
/*!40000 ALTER TABLE `posttags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reactions`
--

DROP TABLE IF EXISTS `reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reactions` (
  `id_reactions` int NOT NULL,
  `id_post` int NOT NULL,
  `id_user` int NOT NULL,
  `reaction_type` varchar(45) NOT NULL,
  `id_comment` int DEFAULT NULL,
  PRIMARY KEY (`id_reactions`),
  KEY `id_post_fk_reactions_idx` (`id_post`),
  KEY `id_user_fk_reactions_idx` (`id_user`),
  KEY `id_comment_fk_reactions_idx` (`id_comment`),
  CONSTRAINT `id_comment_fk_reactions` FOREIGN KEY (`id_comment`) REFERENCES `comments` (`id_comment`),
  CONSTRAINT `id_post_fk_reactions` FOREIGN KEY (`id_post`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `id_user_fk_reactions` FOREIGN KEY (`id_user`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reactions`
--

LOCK TABLES `reactions` WRITE;
/*!40000 ALTER TABLE `reactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `subscriber_id` int NOT NULL,
  `target_id` int NOT NULL,
  PRIMARY KEY (`subscriber_id`,`target_id`),
  KEY `target_id` (`target_id`),
  CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`subscriber_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `subscriptions_chk_1` CHECK ((`subscriber_id` <> `target_id`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_tags_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_common`
--

DROP TABLE IF EXISTS `type_common`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_common` (
  `id_type_common` int NOT NULL,
  `type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_type_common`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_common`
--

LOCK TABLES `type_common` WRITE;
/*!40000 ALTER TABLE `type_common` DISABLE KEYS */;
/*!40000 ALTER TABLE `type_common` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `registration_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','banned') NOT NULL DEFAULT 'active',
  `reputation_score` int NOT NULL DEFAULT '0',
  `role` varchar(10) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_users_reputation` (`reputation_score`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-26 15:15:56
