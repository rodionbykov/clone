-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: clone
-- ------------------------------------------------------
-- Server version	5.7.18-0ubuntu0.16.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pluralname` varchar(45) NOT NULL,
  `singularname` varchar(45) NOT NULL,
  `tokens` text,
  `isdefault` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `isactive` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrators','Administrator','ADD_USER,EDIT_USER,DELETE_USER',0,1),(2,'Editors','Editor','ADD_ANY,EDIT_ANY,DELETE_ANY',0,1),(3,'Authors','Author','ADD_OWN,EDIT_OWN,DELETE_OWN',0,1),(4,'Users','User','VIEW_ANY',1,1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` varchar(45) NOT NULL,
  `label` varchar(255) NOT NULL,
  `value` text,
  `valuetype` enum('STRING') DEFAULT 'STRING',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES ('ADD_ANY','Add document and assign ownership'),('ADD_OWN','Add document and own it'),('ADD_USER','Add new user'),('DELETE_ANY','Delete document owned by someone else'),('DELETE_OWN','Delete owned document'),('DELETE_USER','Delete existing user'),('EDIT_ANY','Edit document owned by someone else'),('EDIT_OWN','Edit owned document '),('EDIT_USER','Edit existing user'),('VIEW_ANY','Viewing document made by any Author');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(45) NOT NULL,
  `passwd` varchar(128) NOT NULL,
  `oauthid` varchar(225) DEFAULT NULL,
  `oauthsource` varchar(3) DEFAULT NULL,
  `isactive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IXU_login` (`login`),
  UNIQUE KEY `IXU_oauth` (`oauthid`,`oauthsource`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','8cb2237d0679ca88db6464eac60da96345513964',NULL,NULL,1),(2,'editor','8cb2237d0679ca88db6464eac60da96345513964',NULL,NULL,1),(3,'author','8cb2237d0679ca88db6464eac60da96345513964',NULL,NULL,1),(4,'user','8cb2237d0679ca88db6464eac60da96345513964',NULL,NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_accounts`
--

DROP TABLE IF EXISTS `users_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_account_user` (`id_user`),
  CONSTRAINT `fk_account_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_accounts`
--

LOCK TABLES `users_accounts` WRITE;
/*!40000 ALTER TABLE `users_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `id_user` int(10) unsigned NOT NULL,
  `id_role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_user`,`id_role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (1,1),(2,2),(3,3),(4,4);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_sessions`
--

DROP TABLE IF EXISTS `users_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_sessions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `token` varchar(45) NOT NULL,
  `created` datetime NOT NULL,
  `moment` datetime NOT NULL,
  `isactive` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IXU_token` (`token`),
  KEY `fk_session_user` (`id_user`),
  CONSTRAINT `fk_session_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_sessions`
--

LOCK TABLES `users_sessions` WRITE;
/*!40000 ALTER TABLE `users_sessions` DISABLE KEYS */;
INSERT INTO `users_sessions` VALUES (1,4,'58c104c1c8bb4981417e706ae71dad11b4786671','2017-01-20 15:28:49','2017-01-20 15:28:49',1),(2,1,'e513a45f3acf949ac24fda131c387a87163059e8','2017-01-20 15:30:18','2017-01-20 15:30:18',1),(3,1,'224f898ace3cfa0d34e3f7d60720c0a8f42345b2','2017-01-20 15:34:45','2017-01-20 15:34:45',1);
/*!40000 ALTER TABLE `users_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_settings`
--

DROP TABLE IF EXISTS `users_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) NOT NULL,
  `id_setting` varchar(45) NOT NULL,
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ixu_user_setting` (`id_setting`,`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_settings`
--

LOCK TABLES `users_settings` WRITE;
/*!40000 ALTER TABLE `users_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'clone'
--
/*!50003 DROP PROCEDURE IF EXISTS `usp_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_login`(
	IN `arg_login` varchar(45),
	IN `arg_passwd` varchar(128)

)
BEGIN

DECLARE var_user_id INT;
DECLARE var_sessiontoken VARCHAR(128);

SET var_user_id = 0;
SET var_sessiontoken = SHA1(RAND());

IF EXISTS(
            SELECT id
            FROM `users`
            WHERE login = arg_login
            AND passwd = SHA1(arg_passwd)
            AND isactive = 1
          ) THEN

  SELECT id
  INTO var_user_id
  FROM `users`
  WHERE login = arg_login
  AND passwd = SHA1(arg_passwd)
  AND isactive = 1;

  INSERT INTO users_sessions (id_user, token, created, moment)
  VALUES (var_user_id, var_sessiontoken, NOW(), NOW());

END IF;

CALL usp_pass (var_sessiontoken);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_logout` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_logout`(
	IN `arg_sessiontoken` varchar(128)
)
BEGIN

DECLARE var_user_id INT;
SET var_user_id = 0;

IF EXISTS (
            SELECT id_user
            FROM users_sessions
            WHERE token = arg_sessiontoken
				AND isactive = 1
          )

THEN

  SELECT id_user
  INTO var_user_id
  FROM users_sessions
  WHERE token = arg_sessiontoken
	AND isactive = 1;

  UPDATE users_sessions
  SET isactive = 0, moment = NOW()
  WHERE token = arg_sessiontoken
	AND isactive = 1;

END IF;

SELECT u.id, u.login, x.token as sessiontoken, x.created, x.moment
FROM `users` u
  JOIN users_sessions x
WHERE u.id = var_user_id
  AND x.token = arg_sessiontoken;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_pass` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_pass`(
	IN `arg_sessiontoken` varchar(128)
)
BEGIN

DECLARE var_user_id INT;

SET var_user_id = 0;

IF EXISTS (
            SELECT id_user
            FROM users_sessions
            WHERE token = arg_sessiontoken
              AND isactive = 1
          )
THEN

UPDATE users_sessions 
SET moment = NOW()
WHERE token = arg_sessiontoken
AND isactive = 1;

SELECT id_user
INTO var_user_id
FROM users_sessions
WHERE token = arg_sessiontoken
AND isactive = 1;

END IF;

SELECT u.id, u.login, x.token as sessiontoken, x.created, x.moment
FROM `users` u
  JOIN users_sessions x
    ON x.id_user = u.id
WHERE u.id = var_user_id
  AND u.isactive = 1
  AND x.isactive = 1
  AND x.token = arg_sessiontoken;

SELECT r.id, r.pluralname, r.singularname, r.tokens
FROM `roles` r
	JOIN `users_roles` ur
		ON ur.id_role = r.id
WHERE ur.id_user = var_user_id;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-18 18:02:57
