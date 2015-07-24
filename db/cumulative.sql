-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: localhost    Database: clone
-- ------------------------------------------------------
-- Server version	5.6.24-log

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
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `code` char(2) NOT NULL,
  `name` varchar(255) NOT NULL,
  `nativename` varchar(255) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `IXU_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES ('de','German','Deutsch'),('en','English','English'),('fr','French','Français'),('ru','Russian','Русский');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages_labels`
--

DROP TABLE IF EXISTS `languages_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages_labels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `languagecode` char(2) NOT NULL,
  `section` varchar(255) NOT NULL,
  `anchor` varchar(255) NOT NULL,
  `label` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IXU_languagecode_labelkey` (`languagecode`,`section`,`anchor`),
  KEY `IX_labelkey` (`section`,`anchor`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages_labels`
--

LOCK TABLES `languages_labels` WRITE;
/*!40000 ALTER TABLE `languages_labels` DISABLE KEYS */;
INSERT INTO `languages_labels` VALUES (1,'en','home','welcome','Use this code as a way to quickly start any new project.'),(2,'fr','home','welcome','Utilisez ce code comme un moyen de démarrer rapidement tout nouveau projet.'),(3,'en','home','title','Welcome!'),(4,'fr','home','title','Bienvenue!'),(5,'en','login','incorrect','Login incorrect, please try again'),(6,'en','login','welcome','Welcome back!');
/*!40000 ALTER TABLE `languages_labels` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `roles` VALUES (1,'Administrators','Administrator',0,1),(2,'Authors','Author',0,1),(3,'Editors','Editor',0,1),(4,'Users','User',1,1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `name` varchar(255) NOT NULL,
  `value` text,
  `valuetype` enum('STRING','TEXT','NUMBER','BOOLEAN') NOT NULL DEFAULT 'STRING',
  `controltype` enum('TEXT','DROPDOWN','RADIOBUTTON','CHECKBOX') NOT NULL DEFAULT 'TEXT',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
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
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `province` varchar(128) DEFAULT NULL,
  `postalcode` varchar(28) DEFAULT NULL,
  `country` varchar(128) DEFAULT NULL,
  `securityquestion` varchar(255) DEFAULT NULL,
  `securityanswer` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `locale` varchar(128) DEFAULT NULL,
  `isactive` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IXU_login` (`login`),
  UNIQUE KEY `IXU_email` (`email`),
  UNIQUE KEY `IXU_oauth` (`oauthid`,`oauthsource`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','827ccb0eea8a706c4c34a16891f84e7b',NULL,NULL,'Admin','Admin','test3@somedomain.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(2,'user','827ccb0eea8a706c4c34a16891f84e7b',NULL,NULL,'Some','User','test2@somedomain.com','','','Sevastopol','Krym','','Ukraine','My favorite food','Pizza',NULL,NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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
INSERT INTO `users_roles` VALUES (1,1),(2,2),(2,3),(2,4);
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
  `moment` datetime NOT NULL,
  `lastactionmoment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isactive` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IXU_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_sessions`
--

LOCK TABLES `users_sessions` WRITE;
/*!40000 ALTER TABLE `users_sessions` DISABLE KEYS */;
INSERT INTO `users_sessions` VALUES (1,2,'cb65fd344e4d78b6dedb2a304038dc30d9365732','2015-06-26 21:05:14','2015-06-26 19:05:14',1),(2,2,'c0642cbca3875d64cda9be1adf1a1b7fbc7007be','2015-06-26 21:06:24','2015-06-26 19:06:24',1),(3,2,'4b3f496106377f5b8ab48fc7860857bf3d65bf36','2015-06-26 22:06:25','2015-06-26 20:06:25',1),(4,2,'6fce67d4196b14a1e1b71c0defc0eb3286a916f4','2015-06-26 22:06:57','2015-06-26 20:06:57',1),(5,2,'ccdbdef2186687dca4f64328e117a86c486bd552','2015-06-26 22:07:17','2015-06-26 20:07:17',1),(6,2,'578ccb701f772ca95ade3b40295e62cbd7b35742','2015-06-26 22:08:36','2015-06-26 20:08:36',1),(7,2,'f38170bb684cc056b8c15eaf55e54ef02eec7dc8','2015-06-26 22:08:36','2015-06-26 20:08:36',1),(8,2,'41752e32443842bc0fd44520f81aec715b8bae6d','2015-06-26 22:32:52','2015-06-26 20:32:52',1),(9,2,'50270687c80505881ed3e3e27dac240977c0bb75','2015-06-26 22:36:14','2015-06-26 20:36:14',1),(10,2,'b737c9ed71852c0917a54554944bbea67db5b391','2015-06-26 22:36:35','2015-06-26 20:36:35',1),(11,2,'86784ae22271cd2b4218187a95549877c86c241a','2015-06-26 22:36:36','2015-06-26 20:36:36',1),(12,2,'7aad6b441dacb63a54a6b1d9d201c37c485c5213','2015-06-26 22:36:37','2015-06-26 20:36:37',1),(13,2,'833c944058a56b60841c6eef939859efa9421207','2015-06-26 22:36:37','2015-06-26 20:36:37',1),(14,2,'7bda73dd3a4ff1cd12f68f707c63dde35733e8bf','2015-06-26 22:37:28','2015-06-26 20:37:28',1),(15,2,'b9943c1bc1669bbc5cb1f3576db546d15e6fcf0e','2015-06-26 22:39:10','2015-06-26 20:39:10',1),(16,2,'fbd5a2f7ce77e3be0c1630779f03591227d3df11','2015-06-26 22:39:48','2015-06-26 20:39:48',1),(17,2,'5091650d0df29cdcf3a428b89c293a404ab6c54e','2015-06-26 23:12:18','2015-06-26 21:12:44',1),(18,2,'e59975433bdd2446b7e3e01b469c80530d3092cb','2015-06-26 23:12:44','2015-06-26 21:12:52',1),(19,2,'09142ce0ceb06ddb56e4871ebf3b9ecc3f858671','2015-06-26 23:12:52','2015-06-26 21:35:28',1),(20,2,'3c444ac159ab167f5d85b7a4ee4946174aa4a79a','2015-06-26 23:35:28','2015-06-26 21:35:28',1),(21,2,'0364d4add8683fb486a213125164c9ecb3ab14b3','2015-06-26 23:44:29','2015-06-26 21:46:37',0),(22,2,'6d13fa6c38187de8d686e0ce740b0890e82daebb','2015-06-27 23:29:37','2015-06-27 21:29:50',0),(23,2,'00aab08b6136a07c0f947855c72d978490b38a21','2015-06-27 23:31:27','2015-06-27 21:32:39',0),(24,2,'2ce5da7cb91c4b7e4d3fbff50d034144816bbb64','2015-06-27 23:32:45','2015-06-27 21:32:46',0),(25,2,'03f725a1d7e66e047efb7d1e86ef527eae49657d','2015-06-27 23:33:09','2015-06-27 21:33:16',0),(26,2,'21878ac9c6261eb14b36f63ba239eb4b2ad5d3b5','2015-06-27 23:34:15','2015-06-27 21:34:24',0),(27,1,'94d92e3201eff4d8166829a7f7bbc31e5481d457','2015-07-24 16:39:22','2015-07-24 14:42:10',1);
/*!40000 ALTER TABLE `users_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'clone'
--

--
-- Dumping routines for database 'clone'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_language_labels` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_language_labels`(arg_languagecode CHAR(2))
BEGIN

	SELECT `section`, `anchor`, CONCAT(`section`, ".", `anchor`) AS labelkey, `label`
	FROM languages_labels
	WHERE languagecode = arg_languagecode
	ORDER BY section, anchor;

	SELECT DISTINCT `section` 
	FROM languages_labels
	WHERE languagecode = arg_languagecode
	ORDER BY section;

    SELECT `code`, `name`, `nativename`
    FROM languages
	ORDER BY `code`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_language_label` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_language_label`(arg_languagecode CHAR(2), arg_section VARCHAR(255), arg_anchor VARCHAR(255), arg_label TEXT)
BEGIN

DECLARE var_id INT;

SET var_id = 0;

IF EXISTS (SELECT `id`
		   FROM `languages_labels`
		   WHERE `languagecode` = arg_languagecode
               AND `section` = arg_section
               AND `anchor` = arg_anchor)
			
THEN 

	SELECT `id`
    INTO var_id    
	FROM `languages_labels`
	WHERE `languagecode` = arg_languagecode
        AND `section` = arg_section
        AND `anchor` = arg_anchor;

	UPDATE `languages_labels`
    SET `label` = arg_label
    WHERE `id` = var_id;
    
ELSE

	INSERT INTO languages_labels (`languagecode`, `section`, `anchor`, `label`)
	VALUES (arg_languagecode, arg_section, arg_anchor, arg_label);
    
    SET var_id = LAST_INSERT_ID();

END IF;

SELECT `languagecode`, `section`, `anchor`, CONCAT(`section`, ".", `anchor`) AS `labelkey`, `label`
FROM `languages_labels`
WHERE `id` = var_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usp_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_login`(arg_login varchar(45), arg_passwd varchar(128))
BEGIN

DECLARE var_user_id INT;
DECLARE var_sessiontoken VARCHAR(128);

SET var_user_id = 0;
SET var_sessiontoken = SHA1(RAND());

IF EXISTS(
            SELECT id
            FROM users
            WHERE login = arg_login
            AND passwd = arg_passwd
            AND isactive = 1
          ) THEN

  SELECT id
  INTO var_user_id
  FROM users
  WHERE login = arg_login
  AND passwd = arg_passwd
  AND isactive = 1;

  INSERT INTO users_sessions (id_user, token, moment)
  VALUES (var_user_id, var_sessiontoken, NOW());

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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_logout`(arg_sessiontoken varchar(128))
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
  SET isactive = 0, lastactionmoment = NOW()
  WHERE token = arg_sessiontoken
	AND isactive = 1;

END IF;

SELECT u.id, u.login, u.firstname, u.lastname, u.email, x.token as sessiontoken, x.moment, x.lastactionmoment, x.isactive AS usersession_isactive
FROM users u
  JOIN users_sessions x
WHERE u.id = var_user_id
  AND x.token = arg_sessiontoken
ORDER BY x.moment DESC
LIMIT 1;

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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_pass`(arg_sessiontoken varchar(128))
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
SET lastactionmoment = NOW()
WHERE token = arg_sessiontoken
AND isactive = 1;

SELECT id_user
INTO var_user_id
FROM users_sessions
WHERE token = arg_sessiontoken
AND isactive = 1;

END IF;

SELECT u.id, u.login, u.firstname, u.lastname, u.email, x.token as sessiontoken, x.moment, x.lastactionmoment, x.isactive AS usersession_isactive
FROM users u
  JOIN users_sessions x
    ON x.id_user = u.id
WHERE u.id = var_user_id
  AND u.isactive = 1
  AND x.isactive = 1
  AND x.token = arg_sessiontoken;

SELECT id, pluralname, singularname
FROM roles r
	JOIN users_roles ur
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

-- Dump completed on 2015-07-24 16:43:30
