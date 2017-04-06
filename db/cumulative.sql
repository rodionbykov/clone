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
  `tokens` text,
  `isdefault` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `isactive` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Dumping data for table clone.roles: ~4 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `pluralname`, `singularname`, `tokens`, `isdefault`, `isactive`) VALUES
	(1, 'Administrators', 'Administrator', 'ADMIN', 0, 1),
	(2, 'Editors', 'Editor', 'ADD_ANY,EDIT_ANY,DELETE_ANY', 0, 1),
	(3, 'Authors', 'Author', 'ADD_OWN,EDIT_OWN,DELETE_OWN', 0, 1),
	(4, 'Users', 'User', 'BROWSE,VIEW', 1, 1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table clone.users
CREATE TABLE IF NOT EXISTS `users` (
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

-- Dumping data for table clone.users: ~4 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `login`, `passwd`, `oauthid`, `oauthsource`, `isactive`) VALUES
	(1, 'admin', '8cb2237d0679ca88db6464eac60da96345513964', NULL, NULL, 1),
	(2, 'editor', '8cb2237d0679ca88db6464eac60da96345513964', NULL, NULL, 1),
	(3, 'author', '8cb2237d0679ca88db6464eac60da96345513964', NULL, NULL, 1),
	(4, 'user', '8cb2237d0679ca88db6464eac60da96345513964', NULL, NULL, 1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table clone.users_accounts
CREATE TABLE IF NOT EXISTS `users_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_account_user` (`id_user`),
  CONSTRAINT `fk_account_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table clone.users_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `users_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_accounts` ENABLE KEYS */;

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
	(3, 3),
	(4, 4);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;

-- Dumping structure for table clone.users_sessions
CREATE TABLE IF NOT EXISTS `users_sessions` (
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

-- Dumping data for table clone.users_sessions: ~3 rows (approximately)
/*!40000 ALTER TABLE `users_sessions` DISABLE KEYS */;
INSERT INTO `users_sessions` (`id`, `id_user`, `token`, `created`, `moment`, `isactive`) VALUES
	(1, 4, '58c104c1c8bb4981417e706ae71dad11b4786671', '2017-01-20 15:28:49', '2017-01-20 15:28:49', 1),
	(2, 1, 'e513a45f3acf949ac24fda131c387a87163059e8', '2017-01-20 15:30:18', '2017-01-20 15:30:18', 1),
	(3, 1, '224f898ace3cfa0d34e3f7d60720c0a8f42345b2', '2017-01-20 15:34:45', '2017-01-20 15:34:45', 1);
/*!40000 ALTER TABLE `users_sessions` ENABLE KEYS */;

-- Dumping structure for table clone.users_settings
CREATE TABLE IF NOT EXISTS `users_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text,
  `valuetype` enum('STRING','TEXT','NUMBER','BOOLEAN','DICTIONARY') NOT NULL DEFAULT 'STRING',
  `controltype` enum('INPUT','TEXT','NUMBER','DROPDOWN','RADIOBUTTON','CHECKBOX') NOT NULL DEFAULT 'INPUT',
  `dictionary` text,
  PRIMARY KEY (`id`),
  KEY `fk_setting_user` (`id_user`),
  KEY `name` (`name`),
  CONSTRAINT `fk_setting_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table clone.users_settings: ~0 rows (approximately)
/*!40000 ALTER TABLE `users_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_settings` ENABLE KEYS */;

-- Dumping structure for procedure clone.usp_login
DELIMITER //
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

END//
DELIMITER ;

-- Dumping structure for procedure clone.usp_logout
DELIMITER //
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

END//
DELIMITER ;

-- Dumping structure for procedure clone.usp_pass
DELIMITER //
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


END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
