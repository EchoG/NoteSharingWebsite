-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.19 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-06-29 23:01:13
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Dumping data for table notes.comment: ~17 rows (approximately)
DELETE FROM `comment`;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` (`comment_id`, `review_id`, `user_id`, `content`, `create_time`, `create_time_str`) VALUES
	(1, 10, 'lucy', '好温馨！', '2012-05-13 17:43:47', ''),
	(2, 10, 'sally', '好好人做不得诶~', '2012-05-14 17:43:55', ''),
	(3, 10, 'chris', '好吧我承认我就是这样的~', '2012-05-15 12:43:59', ''),
	(4, 7, 'lucy', '！', '2012-06-13 17:44:10', ''),
	(5, 8, 'sally', '好好人做不得诶~', '2012-06-18 17:38:20', ''),
	(6, 9, 'chris', '好吧我承认我就是这样的~', '2012-06-19 17:44:41', ''),
	(7, 38, 'chris', 'en', '2012-06-23 00:00:00', ''),
	(8, 9, 'echo', '3423', '2013-04-10 23:41:55', ''),
	(9, 2, 'echo', 'fadf', '2013-04-11 18:43:03', ''),
	(11, 16, 'echo', 'fdhifhd', '2013-04-14 10:49:40', ''),
	(12, 2, 'echo', 'hk', '2013-05-12 23:19:51', ''),
	(13, 43, 'echo', '深有感触！', '2013-05-13 02:16:40', ''),
	(14, 2, 'echo', 'sadfsdf', '2013-05-13 16:20:31', ''),
	(15, 10, 'lily', '嗷', '2013-05-13 17:19:35', ''),
	(16, 51, 'lily', '人性', '2013-05-13 17:40:43', ''),
	(17, 51, 'lily', 'test', '2013-05-13 18:34:40', ''),
	(18, 44, 'lily', '啦啦', '2013-06-04 02:08:26', '');
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

-- Dumping data for table notes.rate: ~29 rows (approximately)
DELETE FROM `rate`;
/*!40000 ALTER TABLE `rate` DISABLE KEYS */;
INSERT INTO `rate` (`review_id`, `user_id`, `rate`, `up`) VALUES
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
	(16, 'echo', 3, NULL),
	(3, 'echo', NULL, 1),
	(43, 'echo', 1, NULL),
	(10, 'echo', 4, NULL),
	(10, 'echo', NULL, 1),
	(51, 'lily', 5, NULL),
	(51, 'lily', NULL, 1),
	(54, 'echo', NULL, 1),
	(12, 'echo', NULL, 1),
	(48, 'echo', 3, NULL),
	(48, 'echo', NULL, 1),
	(48, 'lily', 4, NULL),
	(48, 'lily', NULL, 1),
	(44, 'lily', NULL, 1);
/*!40000 ALTER TABLE `rate` ENABLE KEYS */;


-- Dumping structure for table notes.review
DROP TABLE IF EXISTS `review`;
CREATE TABLE IF NOT EXISTS `review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) DEFAULT NULL,
  `forward_id` int(11) DEFAULT NULL,
  `forward_user` varchar(50) DEFAULT NULL,
  `isbn` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `rating` int(5) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `filetype` varchar(50) DEFAULT NULL,
  `uploadfile` varchar(30) DEFAULT NULL,
  `authority` int(5) DEFAULT '2',
  `pubtime` datetime DEFAULT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

-- Dumping data for table notes.review: ~25 rows (approximately)
DELETE FROM `review`;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` (`review_id`, `tag`, `forward_id`, `forward_user`, `isbn`, `user_id`, `rating`, `content`, `filetype`, `uploadfile`, `authority`, `pubtime`) VALUES
	(1, '随笔', NULL, NULL, '致我们终将逝去的青春', 'echo', NULL, '低吟一缕清风，静守安然；浅弹一阕弦音，追诉流年；陌上寒烟，阐释青春个中深意。光阴流转，岁月渗透忧伤，曾经的那人、那事、那段过往，千年轮回，随着云烟苍老。满月风华，也许，只是一曲流觞，祭奠青春年华，或走，或停，或遥首……', '个人情感', NULL, 2, '2013-06-28 11:17:08'),
	(2, '小说', NULL, NULL, '无比芜杂的心绪', 'chris', NULL, '我已经被这样问了几百遍。由于我曾经和他一起做过《地下》的采访，好像作为一个近距离接触他的人有义务汇报一样，总有人这么问我。但这很难回答。本来要用三言两语来形容一个人就很困难，更何况是世界性的村上。就算曝一些他在搭乘电车的时候，笨手笨脚地丢了车票，在检票口把浑身上下翻了个遍，喝啤酒的时候会自称“俺”，一会儿又改称“我”之类的趣事，也只会变成是我胡诌，破坏“世界的村上”的形象。虽说如此，也不能用一句“不知道”回应，让人家以为他这个人毫无人情味，也令人犯愁。我就暂且这么回答。', '日常杂谈', NULL, 2, '2013-06-28 11:17:08'),
	(3, '散文', NULL, NULL, '国富论有感', 'chris', NULL, '亚当·斯密（Adam Smith, 1723-1790）是经济学的主要创立者。他于1723年出生在苏格兰的克科底，青年时就读于牛津大学。1751年到1764年在格斯哥大学担任哲学教授。在此期间发表了他的第一部著作《道德情操论》，确立了他在知识界的威望。但是他的不朽名声主要在于他在1776年发表的伟大著作《国家财富的性质和原因的研究》。该书一举成功，使他在余生中享受着荣誉和爱戴。1790年，亚当·斯密在克科底去逝。他一生未娶，没有子女。', '理性分析', NULL, 2, '2013-06-28 11:17:08'),
	(4, '管理', NULL, NULL, '生如夏花-死如秋叶', 'chris', NULL, '在最美好的年龄遇到你爱的人，在最富激情的时候读到你喜欢的诗，那感觉大概是一样的吧。泰戈尔的诗集我很早的时候就读过，在一定程度上那是我爱上文学的启蒙力量之一。泰戈尔诗歌的译本很多，且不乏大家与名家。伊沙夫妇将泰翁的诗歌重新翻译，却翻译的那么美，的确令人有些意外之感。我看伊沙伉俪的译本，多少是抱着些比照心态的，然而一看之下，大觉惊艳。', '逸闻趣事', NULL, 2, '2013-06-28 11:17:08'),
	(5, '随笔', NULL, NULL, '流行音乐的秘密', 'echo', NULL, '　“人人都有欣赏和评价艺术的权利，但不是每个人都有足够的艺术判断力，艺术的标准最终是由少数人定义的，你可以不接受，也可以另起炉灶再搞一套，但它始终在那，并不会因为多了你的标准，就出现「多重标准」。所谓的「多重标准」其实就是没有标准。音乐分类学，及以此为基础的音乐评价体系（如格莱美），不是在评价作品，而是在迎合受众甚至蒙蔽受众。” ', '理性分析', NULL, 2, '2013-06-28 11:17:08'),
	(9, NULL, 2, 'Chris', '无比芜杂的心绪', 'adam', NULL, '如果在阅读中掩去作者的姓名背景，我也将毫不怀疑地断定，这本充满迟暮感伤的书，出自一位老者。不过在此之前，我已获得了关于此书的初步印象：它完成于1985年，当时57岁的加西亚•马尔克斯，于四年前得到诺贝尔奖，正享有着与日俱增的世界性荣耀。', NULL, NULL, 2, '2013-06-28 11:17:08'),
	(10, '散文', NULL, NULL, '小王子', 'echo', NULL, '小王子是一个超凡脱俗的仙童，他住在一颗只比他大一丁点儿的小行星上。陪伴他的是一朵他非常喜爱的小玫瑰花。但玫瑰花的虚荣心伤害了小王子对她的感情。小王子告别小行星，开始了遨游太空的旅行。他先后访问了六个行星，各种见闻使他陷入忧伤，他感到大人们荒唐可笑、太不正常。只有在其中一个点灯人的星球上，小王子才找到一个可以作为朋友的人。但点灯人的天地又十分狭小，除了点灯人他自己，不能容下第二个人。在地理学家的指点下，孤单的小王子来到人类居住的地球。', '逸闻趣事', NULL, 2, '2013-06-28 11:17:08'),
	(11, '管理', NULL, NULL, '白夜行', 'lucy', NULL, '“只希望能手牵手在太阳下散步”，这个象征故事内核的绝望念想，有如一个美丽的幌子，随着无数凌乱、压抑、悲凉的故事片段像纪录片一样一一还原：没有痴痴相思，没有海枯石烂，只剩下一个冰冷绝望的诡计，最后一丝温情也被完全抛弃，万千读者在一曲救赎罪恶的凄苦爱情中悲切动容……', '理性分析', NULL, 2, '2013-06-28 11:17:08'),
	(13, '小说', NULL, NULL, '何以笙箫默', 'echo', NULL, '我以为，这一切都是姻缘的安排。大学时代的赵默笙阳光灿烂，对法学系大才子何以琛一见倾心，开朗直率的她拔足倒追，终于使才气出众的他为她停留驻足……然而由于命运的捉弄 ', '个人情感', NULL, 2, '2013-06-28 11:17:08'),
	(15, '散文', NULL, NULL, '华胥引', 'echo', NULL, '宋凝这个姑娘是不容易得到幸福的，她想嫁大英雄，性子倔强不服输，男子一般不都是喜欢为温柔婉约的女子么。而阿凝的天真，阿凝的温柔，她只想让沈岸看见。可是世界上阴差阳错的事情有多少，况且还有柳萋萋的从中作梗。宋凝一心一意爱着沈岸，她的爱情已经卑微到了不能再低的地步，但她的表面依然坚强风雨不摧。可惜宋凝心里想的，沈岸永远不知道。 ', '个人情感', NULL, 2, '2013-06-28 11:17:08'),
	(16, NULL, 12, 'Echo', '苏菲的世界', 'chris', NULL, '奉行自由主义的大不列颠，永远将“自由”供奉在“平等”之前，所以“红眼病”发病率不高，“势利眼”十分常见，“成功人士”走到哪里，都会受人青睐，其结果，是等级梯次井然有序，价值观念相对保守。以剑桥各学院的中心草坪来说，祖制规定，唯有院长和教授方有资格潇洒地斜行穿越，他们目不斜视、趾高气昂、袍子内虎虎生风。因此，当可怜的查尔斯经受严酷的考验——伙伴们把他的帽子扔到三一学院的大草坪上，看他敢不敢走上草坪去把它捡回来——他不免内心挣扎，在学院的“神圣草坪”上行走，几乎是每一个“剑桥孩子”能够犯下的最严重罪行。', NULL, NULL, 2, '2013-06-28 11:17:08'),
	(17, '小说', NULL, NULL, '我们仨', 'echo', NULL, '偶尔夜里睡不着，还会爬起来找书看，又是《我们仨》看过几遍了，还是喜欢的要命。看钱钟书和杨绛，这么两个乱世学人，淡泊宁静的，与世无争，与人无求，不事权贵，不理世事，袖手书斋，大隐隐于心，躲在人群背后，读书写字做学问，这样安静舒张的心，现在已经没有了吧，被灼热物欲驱动的心，虚弱又不宁，谁还敢理直气壮的声称自己享受着绝尘的精神生活？钱钟书和杨绛，说到底还是骨子里有精英意识，中国人所谓士子气，知识分子的倨傲的人，他们并不鄙夷引车卖浆者流，这个精英，是与富贵官贾，社交名流相对的', '日常杂谈', '', 2, '2013-06-28 11:17:08'),
	(43, '小说', NULL, NULL, '往事并不如烟', 'chris', NULL, '我一向认为人老了，简单的衣食住行，都是无比的沉重与艰难，他们的内心自不会再有炽热之情或刻骨之思。但我面前的史良，以忧伤表达出的至爱，令我感动不已。当我跨入老龄，生活之侣也撒手人寰的时候，史良的涕泣和那方白手帕的记忆，便愈发地生动起来，也深刻起来。是的，脆弱的生命随时可以消失，一切都可能转瞬间即空，归于破灭，惟有死者的灵魂和生者的情感是永远的存在。', '个人情感', '', 2, '2013-06-28 11:17:08'),
	(44, '小说', NULL, NULL, '时光的旅行', 'echo', NULL, '<font face="华文彩云">只能用碎片来形容，但许许多多的碎片串联起一整段旅行，而且旅行的精华往往也是一些碎片。比如我能想起第一次去马来西亚，兰卡威一家海滨旅馆的服务生和我在海边唱《海贼王》的片尾曲，</font>他是因为喜欢OP，我是因为喜欢片尾曲的演唱者东方神起。这种零碎的琐事是特别小，但却特别能记得住。 慕容引刀这本绘本，旅行本身并不是重点，远方<font face="Tahoma">的</font><font face="Arial">人和事像</font>充满暖意的吉光片羽闪耀在整本书里，令人读来能够会心一笑，也能恍然大悟。书里.', '日常杂谈', '', 2, '2013-06-28 11:17:08'),
	(45, NULL, 3, 'Chris', '国富论有感', 'echo', NULL, '亚当·斯密（Adam Smith, 1723-1790）是经济学的主要创立者。他于1723年出生在苏格兰的克科底，青年时就读于牛津大学。1751年到1764年在格斯哥大学担任哲学教授。在此期间发表了他的第一部著作《道德情操论》，确立了他在知识界的威望。但是他的不朽名声主要在于他在1776年发表的伟大著作《国家财富的性质和原因的研究》。该书一举成功，使他在余生中享受着荣誉和爱戴。1790年，亚当·斯密在克科底去逝。他一生未娶，没有子女。', NULL, NULL, 2, '2013-06-28 11:17:08'),
	(47, NULL, 10, 'Echo', '小王子', 'echo', NULL, '小王子是一个超凡脱俗的仙童，他住在一颗只比他大一丁点儿的小行星上。陪伴他的是一朵他非常喜爱的小玫瑰花。但玫瑰花的虚荣心伤害了小王子对她的感情。小王子告别小行星，开始了遨游太空的旅行。他先后访问了六个行星，各种见闻使他陷入忧伤，他感到大人们荒唐可笑、太不正常。只有在其中一个点灯人的星球上，小王子才找到一个可以作为朋友的人。但点灯人的天地又十分狭小，除了点灯人他自己，不能容下第二个人。在地理学家的指点下，孤单的小王子来到人类居住的地球。', NULL, NULL, 2, '2013-06-28 11:17:08'),
	(50, NULL, 15, 'Echo', '华胥引', 'lily', NULL, '宋凝这个姑娘是不容易得到幸福的，她想嫁大英雄，性子倔强不服输，男子一般不都是喜欢为温柔婉约的女子么。而阿凝的天真，阿凝的温柔，她只想让沈岸看见。可是世界上阴差阳错的事情有多少，况且还有柳萋萋的从中作梗。宋凝一心一意爱着沈岸，她的爱情已经卑微到了不能再低的地步，但她的表面依然坚强风雨不摧。可惜宋凝心里想的，沈岸永远不知道。 ', NULL, NULL, 2, '2013-06-28 11:17:08'),
	(51, '管理', NULL, NULL, '1984', 'lily', NULL, '<div class="para" style="margin-bottom: 14px; text-indent: 30px; font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; background-color: rgb(255, 255, 255);">“战争即和平；自由即奴役；无知即力量。”</div><div class="para" style="margin-bottom: 14px; text-indent: 30px; font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; background-color: rgb(255, 255, 255);">“谁控制过去就控制未来，谁控制现在就控制过去。”</div><div class="para" style="margin-bottom: 14px; text-indent: 30px; font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; background-color: rgb(255, 255, 255);">“老大哥在看着你！”</div><div class="para" style="margin-bottom: 14px; text-indent: 30px; font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; background-color: rgb(255, 255, 255);">“所谓自由就是可以说2 2=4的自由。”</div><div class="para" style="margin-bottom: 14px; text-indent: 30px; font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; background-color: rgb(255, 255, 255);">“思想罪不会带来死亡；思想罪本身就是死亡。”</div><div class="para" style="margin-bottom: 14px; text-indent: 30px; font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; background-color: rgb(255, 255, 255);">“在遮阴的栗树下，你出卖了我，我出卖了你。”<sup style="white-space: nowrap; margin-left: 2px; color: rgb(51, 102, 204); cursor: pointer; padding: 0px 2px;">[7]</sup><a name="ref_[7]_5089828" style="color: rgb(19, 110, 194);"></a></div><div class="para" style="margin-bottom: 14px; text-indent: 30px; font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; background-color: rgb(255, 255, 255);">“如果有希望，希望在无产者身上。”</div><div class="para" style="margin-bottom: 14px; text-indent: 30px; font-family: arial, 宋体, sans-serif; font-size: 14px; line-height: 24px; background-color: rgb(255, 255, 255);"><img src="http://img3.douban.com/icon/u57798500-5.jpg" alt="米兰达"></div>', '个人情感', '', 2, '2013-06-28 11:17:08'),
	(55, NULL, 12, 'Lily', '苏菲的世界', 'echo', NULL, '14岁的少女苏菲某天放学回家，发现了神秘的一封信。----你是谁？----世界从哪里来？就这样，在一位神秘导师的指导引下，苏菲开始思索从古希腊到康德，从祁克果到佛洛伊德等各位大师所思考的根本问题。与此同时，苏菲不断接到了些极不寻常的来信，世界像迹团一般在她眼底展开。苏菲运用少女天生的悟性与后天知识，企图解开这些迹团然而事实真相远比她所想的更怪异、更离奇……《苏菲的世界》，即是智慧的世界，梦的世界。它将会唤醒每个人内心深处对生命的赞叹与对人生终极意义的关怀和好奇。', NULL, NULL, 2, '2013-06-28 11:17:08'),
	(57, '小说', NULL, NULL, 'test', 'echo', NULL, 'tsetttt', '日常杂谈', '', 2, '2013-06-28 11:17:08'),
	(58, '散文', NULL, NULL, 'test', 'lily', NULL, 'test', '日常杂谈', 'test.txt', 2, '2013-06-28 11:17:08'),
	(59, '散文', NULL, NULL, 'testprivacy', 'lily', NULL, 'ppp', '日常杂谈', '', 1, '2013-06-28 11:17:08'),
	(60, '散文', NULL, NULL, 'testdraft', 'lily', NULL, 'testtest', '日常杂谈', '', 2, '2013-06-29 11:37:41'),
	(76, NULL, NULL, NULL, '', 'lily', NULL, 'asdf', NULL, NULL, 3, '2013-06-29 22:57:40');
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
  `create_time` datetime NOT NULL,
  `portrait_small` varchar(30) NOT NULL DEFAULT '',
  `portrait_large` varchar(30) NOT NULL DEFAULT '',
  `sort_ind` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table notes.user: ~15 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `name`, `password`, `email`, `gender`, `come_from`, `create_time`, `portrait_small`, `portrait_large`, `sort_ind`) VALUES
	('adam', 'Adam', '123', 'adam.xin@fudan.edu.cn', 'm', 'Jiangsu', '2012-06-01 00:00:00', 'img/people/person10.jpg', 'img/people/person10.jpg', 3),
	('alex', 'Alex', '123', 'alex.lv@fudan.edu.cn', 'm', 'Shanghai', '2012-06-01 00:00:00', 'img/people/person8.png', 'img/people/person8.png', 8),
	('andy', 'Andy', '123', 'andy.wang@fudan.edu.cn', 'm', 'Jilin', '2012-06-01 00:00:00', 'img/people/person11.jpg', 'img/people/person11.jpg', 1),
	('bob', 'Bob', '123', 'bob.zhao@fudan.edu.cn', 'm', 'Shanghai', '2012-06-01 00:00:00', 'img/people/person4.png', 'img/people/person4.png', 4),
	('carole', 'Carole', '123', 'carole.li@fudan.edu.cn', 'f', 'Anhui', '2012-06-01 00:00:00', 'img/people/person2.png', 'img/people/person2.png', 2),
	('chris', 'Chris', '123', 'chris.lv@fudan.edu.cn', 'm', 'USA', '2012-06-01 00:00:00', 'img/people/person9.jpg', 'img/people/person9.jpg', 9),
	('echo', 'Echo', '123', 'echo.gong@fudan.edu.cn', 'f', 'USA', '2012-06-01 00:00:00', 'img/people/person3.png', 'img/user2.jpg', 3),
	('july', 'July', '123', 'july.xin@fudan.edu.cn', 'm', 'Korea', '2012-06-01 00:00:00', 'img/people/person7.png', 'img/people/person7.png', 7),
	('lily', 'Lily', '123', 'Lily.li@fudan.edu.cn', 'f', 'Beijing', '2012-06-01 00:00:00', 'img/people/person6.png', 'img/people/person6.png', 6),
	('lucy', 'Lucy', '123', 'lucy.wang@fudan.edu.cn', 'f', 'Shanghai', '2012-06-01 00:00:00', 'img/people/person5.png', 'img/people/person5.png', 5),
	('sally', 'Sally', '123', 'sally.wang@fudan.edu.cn', 'f', 'Zulu', '2012-06-01 00:00:00', 'img/people/person1.png', 'img/people/person1.png', 1),
	('susan', 'Susan', '123', 'susan.li@fudan.edu.cn', 'f', 'UK', '2012-06-01 00:00:00', 'img/people/person15.jpg', 'img/people/person15.jpg', 6),
	('tina', 'Tina', '123', 'tina.li@fudan.edu.cn', 'f', 'Japan', '2012-06-01 00:00:00', 'img/people/person12.jpg', 'img/people/person12.jpg', 2),
	('vicky', 'vicky', '123', 'vicky.wang@fudan.edu.cn', 'f', 'Shanghai', '2012-06-01 00:00:00', 'img/people/person14.jpg', 'img/people/person14.jpg', 5),
	('zoe', 'Zoe', '123', 'zoe.zhao@fudan.edu.cn', 'f', 'Wuxi', '2012-06-01 00:00:00', 'img/people/person13.jpg', 'img/people/person13.jpg', 4);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40014 SET FOREIGN_KEY_CHECKS=1 */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
