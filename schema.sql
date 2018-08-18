CREATE TABLE `users` (
  `User` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `Password` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `key` varchar(1024) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Uid` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-1',
  `Gid` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-1',
  `Dir` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`User`),
  UNIQUE KEY `User` (`User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`User`, `Password`, `Uid`, `Gid`, `Dir`)
VALUES
	('foo', '', '2100', '2100', '/var/ftp/foo');