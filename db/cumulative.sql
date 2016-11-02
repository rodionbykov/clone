-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.13-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.5077
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table clone.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pluralname` varchar(45) NOT NULL,
  `singularname` varchar(45) NOT NULL,
  `isdefault` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `isactive` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table clone.roles: ~4 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `pluralname`, `singularname`, `isdefault`, `isactive`) VALUES
	(1, 'Administrators', 'Administrator', 0, 1),
	(2, 'Authors', 'Author', 0, 1),
	(3, 'Editors', 'Editor', 0, 1),
	(4, 'Users', 'User', 1, 1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table clone.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `name` varchar(255) NOT NULL,
  `value` text,
  `valuetype` enum('STRING','TEXT','NUMBER','BOOLEAN','DICTIONARY') NOT NULL DEFAULT 'STRING',
  `controltype` enum('INPUT','TEXT','NUMBER','DROPDOWN','RADIOBUTTON','CHECKBOX') NOT NULL DEFAULT 'INPUT',
  `dictionary` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table clone.settings: ~0 rows (approximately)
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

-- Dumping structure for table clone.users
CREATE TABLE IF NOT EXISTS `users` (
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

-- Dumping data for table clone.users: ~2 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `login`, `passwd`, `oauthid`, `oauthsource`, `firstname`, `lastname`, `email`, `phone`, `address`, `city`, `province`, `postalcode`, `country`, `securityquestion`, `securityanswer`, `link`, `locale`, `isactive`) VALUES
	(1, 'admin', '827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, 'Admin', 'Admin', 'test3@somedomain.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
	(2, 'user', '827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, 'Some', 'User', 'test2@somedomain.com', '', '', 'Sevastopol', 'Krym', '', 'Ukraine', 'My favorite food', 'Pizza', NULL, NULL, 1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table clone.users_roles
CREATE TABLE IF NOT EXISTS `users_roles` (
  `id_user` int(10) unsigned NOT NULL,
  `id_role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_user`,`id_role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table clone.users_roles: ~4 rows (approximately)
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` (`id_user`, `id_role`) VALUES
	(1, 1),
	(2, 2),
	(2, 3),
	(2, 4);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;

-- Dumping structure for table clone.users_sessions
CREATE TABLE IF NOT EXISTS `users_sessions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `token` varchar(45) NOT NULL,
  `moment` datetime NOT NULL,
  `lastactionmoment` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isactive` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IXU_token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- Dumping data for table clone.users_sessions: ~27 rows (approximately)
/*!40000 ALTER TABLE `users_sessions` DISABLE KEYS */;
INSERT INTO `users_sessions` (`id`, `id_user`, `token`, `moment`, `lastactionmoment`, `isactive`) VALUES
	(1, 2, 'cb65fd344e4d78b6dedb2a304038dc30d9365732', '2015-06-26 21:05:14', '2015-06-26 21:05:14', 1),
	(2, 2, 'c0642cbca3875d64cda9be1adf1a1b7fbc7007be', '2015-06-26 21:06:24', '2015-06-26 21:06:24', 1),
	(3, 2, '4b3f496106377f5b8ab48fc7860857bf3d65bf36', '2015-06-26 22:06:25', '2015-06-26 22:06:25', 1),
	(4, 2, '6fce67d4196b14a1e1b71c0defc0eb3286a916f4', '2015-06-26 22:06:57', '2015-06-26 22:06:57', 1),
	(5, 2, 'ccdbdef2186687dca4f64328e117a86c486bd552', '2015-06-26 22:07:17', '2015-06-26 22:07:17', 1),
	(6, 2, '578ccb701f772ca95ade3b40295e62cbd7b35742', '2015-06-26 22:08:36', '2015-06-26 22:08:36', 1),
	(7, 2, 'f38170bb684cc056b8c15eaf55e54ef02eec7dc8', '2015-06-26 22:08:36', '2015-06-26 22:08:36', 1),
	(8, 2, '41752e32443842bc0fd44520f81aec715b8bae6d', '2015-06-26 22:32:52', '2015-06-26 22:32:52', 1),
	(9, 2, '50270687c80505881ed3e3e27dac240977c0bb75', '2015-06-26 22:36:14', '2015-06-26 22:36:14', 1),
	(10, 2, 'b737c9ed71852c0917a54554944bbea67db5b391', '2015-06-26 22:36:35', '2015-06-26 22:36:35', 1),
	(11, 2, '86784ae22271cd2b4218187a95549877c86c241a', '2015-06-26 22:36:36', '2015-06-26 22:36:36', 1),
	(12, 2, '7aad6b441dacb63a54a6b1d9d201c37c485c5213', '2015-06-26 22:36:37', '2015-06-26 22:36:37', 1),
	(13, 2, '833c944058a56b60841c6eef939859efa9421207', '2015-06-26 22:36:37', '2015-06-26 22:36:37', 1),
	(14, 2, '7bda73dd3a4ff1cd12f68f707c63dde35733e8bf', '2015-06-26 22:37:28', '2015-06-26 22:37:28', 1),
	(15, 2, 'b9943c1bc1669bbc5cb1f3576db546d15e6fcf0e', '2015-06-26 22:39:10', '2015-06-26 22:39:10', 1),
	(16, 2, 'fbd5a2f7ce77e3be0c1630779f03591227d3df11', '2015-06-26 22:39:48', '2015-06-26 22:39:48', 1),
	(17, 2, '5091650d0df29cdcf3a428b89c293a404ab6c54e', '2015-06-26 23:12:18', '2015-06-26 23:12:44', 1),
	(18, 2, 'e59975433bdd2446b7e3e01b469c80530d3092cb', '2015-06-26 23:12:44', '2015-06-26 23:12:52', 1),
	(19, 2, '09142ce0ceb06ddb56e4871ebf3b9ecc3f858671', '2015-06-26 23:12:52', '2015-06-26 23:35:28', 1),
	(20, 2, '3c444ac159ab167f5d85b7a4ee4946174aa4a79a', '2015-06-26 23:35:28', '2015-06-26 23:35:28', 1),
	(21, 2, '0364d4add8683fb486a213125164c9ecb3ab14b3', '2015-06-26 23:44:29', '2015-06-26 23:46:37', 0),
	(22, 2, '6d13fa6c38187de8d686e0ce740b0890e82daebb', '2015-06-27 23:29:37', '2015-06-27 23:29:50', 0),
	(23, 2, '00aab08b6136a07c0f947855c72d978490b38a21', '2015-06-27 23:31:27', '2015-06-27 23:32:39', 0),
	(24, 2, '2ce5da7cb91c4b7e4d3fbff50d034144816bbb64', '2015-06-27 23:32:45', '2015-06-27 23:32:46', 0),
	(25, 2, '03f725a1d7e66e047efb7d1e86ef527eae49657d', '2015-06-27 23:33:09', '2015-06-27 23:33:16', 0),
	(26, 2, '21878ac9c6261eb14b36f63ba239eb4b2ad5d3b5', '2015-06-27 23:34:15', '2015-06-27 23:34:24', 0),
	(27, 1, '94d92e3201eff4d8166829a7f7bbc31e5481d457', '2015-07-24 16:39:22', '2015-07-24 16:42:10', 1);
/*!40000 ALTER TABLE `users_sessions` ENABLE KEYS */;

-- Dumping structure for procedure clone.usp_login
DELIMITER //
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

END//
DELIMITER ;

-- Dumping structure for procedure clone.usp_logout
DELIMITER //
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

END//
DELIMITER ;

-- Dumping structure for procedure clone.usp_pass
DELIMITER //
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


END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
