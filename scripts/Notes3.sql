-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.19 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-05-09 23:12:19
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;

-- Dumping database structure for notes
DROP DATABASE IF EXISTS `notes`;
CREATE DATABASE IF NOT EXISTS `notes` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `notes`;


-- Dumping structure for table notes.book
DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
  `isbn` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(200) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `translator` varchar(50) DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `cover_pic` varchar(100) DEFAULT NULL,
  `publish_dt` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table notes.book: ~5 rows (approximately)
DELETE FROM `book`;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` (`isbn`, `name`, `author`, `translator`, `publisher`, `cover_pic`, `publish_dt`) VALUES
	('9787111255833', 'Effective Java中文版(第2版)', '（美）布洛克', '杨春花，俞黎敏', '机械工业出版社', NULL, '2009-1-1'),
	('9787115232687', '人月神话', '（美）布鲁克斯', NULL, '人民邮电出版社', NULL, '2010-8-1'),
	('9787512403208', '中国最美的88个特色旅游地', '《旅游圣经》编辑部', NULL, '北京航空航天大学出版社', NULL, '2011-4-1'),
	('9787514301205', '一个人私奔', '王迪诗', '', '现代出版社', NULL, '2011-8-1'),
	('9787531343516', '我亦飘零久', '独木舟', NULL, '春风文艺出版社', NULL, '2012-11-1');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;


-- Dumping structure for table notes.comment
DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `review_id` int(11) NOT NULL,
  `user_id` varchar(30) NOT NULL DEFAULT '',
  `content` varchar(500) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `create_time_str` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Dumping data for table notes.comment: ~10 rows (approximately)
DELETE FROM `comment`;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` (`comment_id`, `review_id`, `user_id`, `content`, `create_time`, `create_time_str`) VALUES
	(1, 10, 'lucy', '好温馨！', NULL, '10:30'),
	(2, 10, 'sally', '好好人做不得诶~', NULL, '10:32'),
	(3, 10, 'chris', '好吧我承认我就是这样的~', NULL, '11:05'),
	(4, 7, 'lucy', '！', NULL, '10:30'),
	(5, 8, 'sally', '好好人做不得诶~', NULL, '10:32'),
	(6, 9, 'chris', '好吧我承认我就是这样的~', NULL, '11:05'),
	(7, 38, 'chris', 'en', '2012-06-23 00:00:00', '2012-06-23 10:48'),
	(8, 9, 'echo', '3423', '2013-04-10 23:41:55', ''),
	(9, 2, 'echo', 'fadf', '2013-04-11 18:43:03', ''),
	(11, 16, 'echo', 'fdhifhd', '2013-04-14 10:49:40', '');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;


-- Dumping structure for table notes.follows
DROP TABLE IF EXISTS `follows`;
CREATE TABLE IF NOT EXISTS `follows` (
  `user_id` varchar(30) NOT NULL DEFAULT '',
  `follower_id` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`follower_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table notes.follows: ~95 rows (approximately)
DELETE FROM `follows`;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
INSERT INTO `follows` (`user_id`, `follower_id`) VALUES
	('adam', 'alex'),
	('adam', 'bob'),
	('adam', 'carole'),
	('adam', 'chris'),
	('adam', 'echo'),
	('adam', 'july'),
	('adam', 'lily'),
	('adam', 'lucy'),
	('adam', 'sally'),
	('alex', 'bob'),
	('alex', 'carole'),
	('alex', 'chris'),
	('alex', 'echo'),
	('alex', 'july'),
	('alex', 'lily'),
	('alex', 'lucy'),
	('alex', 'sally'),
	('andy', 'alex'),
	('andy', 'bob'),
	('andy', 'carole'),
	('andy', 'echo'),
	('andy', 'july'),
	('andy', 'lily'),
	('andy', 'lucy'),
	('andy', 'sally'),
	('bob', 'alex'),
	('bob', 'carole'),
	('bob', 'chris'),
	('bob', 'echo'),
	('bob', 'july'),
	('bob', 'lily'),
	('bob', 'lucy'),
	('bob', 'sally'),
	('carole', 'alex'),
	('carole', 'bob'),
	('carole', 'chris'),
	('carole', 'echo'),
	('carole', 'sally'),
	('chris', 'alex'),
	('chris', 'carole'),
	('chris', 'echo'),
	('chris', 'july'),
	('chris', 'lily'),
	('chris', 'lucy'),
	('chris', 'sally'),
	('echo', 'alex'),
	('echo', 'bob'),
	('echo', 'carole'),
	('echo', 'chris'),
	('echo', 'july'),
	('echo', 'lily'),
	('echo', 'lucy'),
	('echo', 'sally'),
	('july', 'alex'),
	('july', 'bob'),
	('july', 'chris'),
	('july', 'echo'),
	('july', 'sally'),
	('lily', 'alex'),
	('lily', 'bob'),
	('lily', 'carole'),
	('lily', 'chris'),
	('lily', 'echo'),
	('lily', 'july'),
	('lily', 'sally'),
	('lucy', 'alex'),
	('lucy', 'carole'),
	('lucy', 'echo'),
	('lucy', 'july'),
	('lucy', 'sally'),
	('sally', 'bob'),
	('sally', 'chris'),
	('sally', 'echo'),
	('sally', 'lily'),
	('susan', 'alex'),
	('susan', 'bob'),
	('susan', 'chris'),
	('susan', 'echo'),
	('susan', 'july'),
	('susan', 'sally'),
	('tina', 'carole'),
	('tina', 'chris'),
	('tina', 'echo'),
	('tina', 'lily'),
	('tina', 'lucy'),
	('tina', 'sally'),
	('vicky', 'carole'),
	('vicky', 'chris'),
	('vicky', 'july'),
	('vicky', 'lily'),
	('vicky', 'lucy'),
	('vicky', 'sally'),
	('zoe', 'alex'),
	('zoe', 'echo'),
	('zoe', 'sally');
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;


-- Dumping structure for table notes.rate
DROP TABLE IF EXISTS `rate`;
CREATE TABLE IF NOT EXISTS `rate` (
  `review_id` int(10) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `rate` int(5) DEFAULT NULL,
  `up` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table notes.rate: ~19 rows (approximately)
DELETE FROM `rate`;
/*!40000 ALTER TABLE `rate` DISABLE KEYS */;
INSERT INTO `rate` (`review_id`, `user_id`, `rate`, `up`) VALUES
	(1, 'chris', 5, 1),
	(1, 'echo', 4, 1),
	(2, 'bob', 3, 1),
	(9, 'echo', NULL, 1),
	(9, 'echo', 1, NULL),
	(9, 'echo', 1, NULL),
	(9, 'echo', 1, NULL),
	(2, 'echo', 1, NULL),
	(9, 'echo', 1, NULL),
	(9, 'echo', 1, NULL),
	(2, 'echo', 1, NULL),
	(9, 'echo', 3, NULL),
	(9, 'echo', 4, NULL),
	(2, 'echo', 2, NULL),
	(13, 'chris', NULL, 1),
	(13, 'chris', 1, NULL),
	(13, 'chris', 3, NULL),
	(16, 'echo', NULL, 1),
	(16, 'echo', 3, NULL);
/*!40000 ALTER TABLE `rate` ENABLE KEYS */;


-- Dumping structure for table notes.review
DROP TABLE IF EXISTS `review`;
CREATE TABLE IF NOT EXISTS `review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) DEFAULT '0',
  `forward_id` int(11) DEFAULT NULL,
  `forward_user` varchar(50) DEFAULT NULL,
  `isbn` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `rating` int(5) DEFAULT NULL,
  `content` varchar(300) DEFAULT NULL,
  `filetype` varchar(50) DEFAULT NULL,
  `uploadfile` varchar(30) DEFAULT NULL,
  `authority` int(5) DEFAULT '2',
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- Dumping data for table notes.review: ~31 rows (approximately)
DELETE FROM `review`;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` (`review_id`, `tag`, `forward_id`, `forward_user`, `isbn`, `user_id`, `rating`, `content`, `filetype`, `uploadfile`, `authority`) VALUES
	(1, '随笔', 0, NULL, '9787111255833', 'echo', NULL, '好', NULL, NULL, 2),
	(2, '小说', 0, NULL, '9787115232687', 'chris', NULL, '好', NULL, NULL, 2),
	(3, '散文', 0, NULL, '9787111255833', 'echo', NULL, '000000000000000000000000', NULL, NULL, 2),
	(4, '管理', 0, NULL, '9787111255833', 'chris', NULL, '寰堥樋榫欑殑\n                                ', NULL, NULL, 2),
	(5, '随笔', 0, NULL, '9787111255833', 'echo', 2, '34892<b>730947129471298</b>31232', NULL, NULL, 2),
	(9, '小说', 2, 'Chris', '9787115232687', 'echo', NULL, '好', NULL, NULL, 2),
	(10, '小说', NULL, NULL, '11111', 'echo', 4, '<br>', NULL, NULL, 2),
	(11, '小说', NULL, NULL, '2222', 'echo', 4, '<br>', NULL, NULL, 2),
	(12, '小说', NULL, NULL, '3333', 'echo', 4, 'aaaaaaaaaaaaaaaa\n', NULL, NULL, 2),
	(13, '小说', NULL, NULL, '4444', 'echo', 3, '&lt;b&gt;fdsafdsf&lt;/b&gt;', NULL, NULL, 2),
	(15, '散文', NULL, NULL, '是', 'echo', 2, '<font size="6"><b><i><u>你好好好</u></i></b></font>', NULL, NULL, 2),
	(16, '小说', 12, 'Echo', '3333', 'chris', 4, 'aaaaaaaaaaaaaaaa\n', NULL, NULL, 2),
	(17, '小说', NULL, NULL, '6666', 'echo', 2, '<b>fdsafdsg</b>', NULL, NULL, 2),
	(21, '小说', NULL, NULL, '', 'echo', 1, 'aaaaaaaaaaaaaaaa\n', NULL, NULL, 2),
	(22, '小说', 16, 'Chris', '3333', 'echo', 4, 'aaaaaaaaaaaaaaaa\n', NULL, NULL, 2),
	(23, '小说', NULL, NULL, '', 'echo', 1, '', NULL, NULL, 2),
	(24, '小说', NULL, NULL, 'bbbb', 'echo', 5, 'bbbbbbbbbbb\n', NULL, NULL, 2),
	(25, '小说', NULL, NULL, 'cccc', 'echo', 1, 'setBackColor\nsetFontStyle\n', NULL, NULL, 2),
	(26, '小说', NULL, NULL, 'rtf', 'echo', 1, 'rtf\n', NULL, NULL, 2),
	(27, '小说', NULL, NULL, 'qqq', 'echo', 1, 'qqqqq', '个人情感', NULL, 1),
	(28, '小说', NULL, NULL, '', 'echo', 1, 'chris is a bad egg!\n', '个人情感', NULL, 1),
	(29, '小说', NULL, NULL, '', 'echo', 1, 'fsadf<b>asdfad</b>sf<font color="#ffff00"><span style="background-color: rgb(0, 0, 255); ">as</span>df</font>a', '个人情感', NULL, 1),
	(32, '小说', NULL, NULL, '', 'echo', 1, NULL, '逸闻趣事', NULL, 1),
	(33, '小说', NULL, NULL, '', 'echo', 1, NULL, '理性分析', NULL, 1),
	(34, '小说', NULL, NULL, '', 'echo', 1, NULL, '理性分析', 'myfile.txt', 1),
	(36, '小说', NULL, NULL, 'rrrr', 'echo', 1, '<i>rrrrrrrrrrr</i>', '个人情感', NULL, 1),
	(37, '小说', NULL, NULL, 'fdfads', 'echo', 1, '<u>eeeeeeeeeeee</u>', '个人情感', NULL, 1),
	(39, '小说', NULL, NULL, '', 'echo', 1, NULL, '个人情感', '22.txt', 1),
	(40, '小说', NULL, NULL, '', 'echo', 1, NULL, '理性分析', '11.txt', 1),
	(41, '小说', NULL, NULL, '', 'echo', 1, NULL, '逸闻趣事', 'eclipse 快捷键.txt', 1),
	(42, '小说', NULL, NULL, '', 'echo', 1, '伊~~奇<font color="#008000">怪怪怪</font>！！！content丢了~<div>总之 文件<b>名可以保存的</b>呢！</div>', '日常杂谈', 'G阅读词汇.txt', 1);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;


-- Dumping structure for table notes.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(30) NOT NULL DEFAULT '',
  `password` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(30) NOT NULL DEFAULT '',
  `gender` varchar(30) NOT NULL DEFAULT '',
  `come_from` varchar(30) NOT NULL DEFAULT '',
  `create_time` date NOT NULL,
  `portrait_small` varchar(30) NOT NULL DEFAULT '',
  `portrait_large` varchar(30) NOT NULL DEFAULT '',
  `sort_ind` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table notes.user: ~16 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `name`, `password`, `email`, `gender`, `come_from`, `create_time`, `portrait_small`, `portrait_large`, `sort_ind`) VALUES
	('aaaaaa', 'aaaaaa', '910725a', 'm', 'cgong@fudan.edu.cn', 'shanghai', '2012-06-23', 'img/people/person1.png', 'img/user2.jpg', 0),
	('adam', 'Adam', '123', 'adam.xin@fudan.edu.cn', 'm', 'Jiangsu', '2012-06-01', 'img/people/person10.jpg', 'img/people/person10.jpg', 3),
	('alex', 'Alex', '123', 'alex.lv@fudan.edu.cn', 'm', 'Shanghai', '2012-06-01', 'img/people/person8.png', 'img/people/person8.png', 8),
	('andy', 'Andy', '123', 'andy.wang@fudan.edu.cn', 'm', 'Jilin', '2012-06-01', 'img/people/person11.jpg', 'img/people/person11.jpg', 1),
	('bob', 'Bob', '123', 'bob.zhao@fudan.edu.cn', 'm', 'Shanghai', '2012-06-01', 'img/people/person4.png', 'img/people/person4.png', 4),
	('carole', 'Carole', '123', 'carole.li@fudan.edu.cn', 'f', 'Anhui', '2012-06-01', 'img/people/person2.png', 'img/people/person2.png', 2),
	('chris', 'Chris', '123', 'chris.lv@fudan.edu.cn', 'm', 'USA', '2012-06-01', 'img/people/person9.jpg', 'img/people/person9.jpg', 9),
	('echo', 'Echo', '123', 'echo.gong@fudan.edu.cn', 'f', 'USA', '2012-06-01', 'img/people/person3.png', 'img/user2.jpg', 3),
	('july', 'July', '123', 'july.xin@fudan.edu.cn', 'm', 'Korea', '2012-06-01', 'img/people/person7.png', 'img/people/person7.png', 7),
	('lily', 'Lily', '123', 'Lily.li@fudan.edu.cn', 'f', 'Beijing', '2012-06-01', 'img/people/person6.png', 'img/people/person6.png', 6),
	('lucy', 'Lucy', '123', 'lucy.wang@fudan.edu.cn', 'f', 'Shanghai', '2012-06-01', 'img/people/person5.png', 'img/people/person5.png', 5),
	('sally', 'Sally', '123', 'sally.wang@fudan.edu.cn', 'f', 'Zulu', '2012-06-01', 'img/people/person1.png', 'img/people/person1.png', 1),
	('susan', 'Susan', '123', 'susan.li@fudan.edu.cn', 'f', 'UK', '2012-06-01', 'img/people/person15.jpg', 'img/people/person15.jpg', 6),
	('tina', 'Tina', '123', 'tina.li@fudan.edu.cn', 'f', 'Japan', '2012-06-01', 'img/people/person12.jpg', 'img/people/person12.jpg', 2),
	('vicky', 'vicky', '123', 'vicky.wang@fudan.edu.cn', 'f', 'Shanghai', '2012-06-01', 'img/people/person14.jpg', 'img/people/person14.jpg', 5),
	('zoe', 'Zoe', '123', 'zoe.zhao@fudan.edu.cn', 'f', 'Wuxi', '2012-06-01', 'img/people/person13.jpg', 'img/people/person13.jpg', 4);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
