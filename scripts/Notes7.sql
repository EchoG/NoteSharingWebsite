-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.5.19 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL version:             7.0.0.4053
-- Date/time:                    2013-07-03 18:43:28
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
  `content` mediumtext,
  `filetype` varchar(50) DEFAULT NULL,
  `uploadfile` varchar(30) DEFAULT NULL,
  `authority` int(5) DEFAULT '2',
  `pubtime` datetime DEFAULT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- Dumping data for table notes.review: ~49 rows (approximately)
DELETE FROM `review`;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` (`review_id`, `tag`, `forward_id`, `forward_user`, `isbn`, `user_id`, `rating`, `content`, `filetype`, `uploadfile`, `authority`, `pubtime`) VALUES
    (1, '随笔 小说 散文', NULL, NULL, '致我们终将逝去的青春', 'echo', NULL, '低吟一缕清风，静守安然；浅弹一阕弦音，追诉流年；陌上寒烟，阐释青春个中深意。光阴流转，岁月渗透忧伤，曾经的那人、那事、那段过往，千年轮回，随着云烟苍老。满月风华，也许，只是一曲流觞，祭奠青春年华，或走，或停，或遥首……', '个人情感', NULL, 2, '2013-06-28 11:17:08'),
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
    (61, '管理 技术 编程', NULL, NULL, 'Prolog', 'lily', NULL, '<font face="sans-serif"><span style="font-size: 15px; line-height: 22.078125px;"><font color="#dc143c">Prolog</font>（Programming in Logic的缩写）是一种逻辑编程语言。它建立在逻辑学的理论基础之上， 最初被运用于自然语言等研究领域。现在它已广泛的应用在人工智能的研究中，它可以用来建造专家系统、自然语言理解、智能知识库等。</span></font>', '个人情感', '', 2, '2013-07-03 00:41:09'),
    (62, '随笔 旅游', NULL, NULL, '意大利保格利小镇(Bolgheri)', 'lily', NULL, '<p style="margin: 0px 0px 0.8em; padding: 0px; line-height: 1.4; color: rgb(51, 51, 51); font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif; background-color: rgb(250, 250, 250);"><span style="color: rgb(255, 255, 0);"><strong style="font-style: inherit;"><span style="background-color: rgb(0, 0, 255);">小镇介绍</span></strong></span></p><p style="margin: 0px 0px 0.8em; padding: 0px; line-height: 1.4; color: rgb(51, 51, 51); font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif; background-color: rgb(250, 250, 250);"><br></p><p style="margin: 0px 0px 0.8em; padding: 0px; line-height: 1.4; color: rgb(51, 51, 51); font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif; background-color: rgb(250, 250, 250);">从 Viale dei Cipressi出发，有一条3英里长的笔直的公路，路的两侧栽种了2540棵柏树，这条路直通Bolgheri，一个被包围在托斯卡纳南部玛利玛葡萄园 之中的小城镇。除了极富戏剧性的路途外，位于当地中央广场的della Posta咖啡馆，是一家非常特别的红葡萄酒吧，这些葡萄酒始酿于上世纪八十年代，足以媲美现在的法国波尔多红酒，而且比较实惠，两人只要约100元人民 币。从Bolgheri向东南8公里的Bibbona有家名为Sant’Elena的酒店，有15间可供住宿的客房，提供带天蓬的床，石壁炉以及一流的意 大利面食。在Magona饭店，大厨Omar Barsacchi和Gionata d’Alessi将为你奉上传统的托斯卡纳-玛利玛式美食(填满西红柿汤的意大利馄饨)。<span style="line-height: 1.4;">>gt;gt;nbsp;</span></p><p style="margin: 0px 0px 0.8em; padding: 0px; line-height: 1.4; color: rgb(51, 51, 51); font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif; background-color: rgb(250, 250, 250);"><span style="background-color: rgb(255, 255, 255);"><strong style="font-style: inherit;"><span style="color: rgb(255, 255, 0);"><span style="background-color: rgb(0, 0, 255);">推荐理由</span></span></strong></span></p><p style="margin: 0px 0px 0.8em; padding: 0px; line-height: 1.4; color: rgb(51, 51, 51); font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif; background-color: rgb(250, 250, 250);">Bolgheri 这座隐藏在葡萄园中的庄园，其历史可以追溯到公园8世纪，现在的大部分建筑都是1496年后重建的。除了红葡萄酒，这是还被称为意大利最美丽的地方，从每 年11至第二年5月，成千上万迁徙的水鸟在这里停留。广阔的沙滩和茂密的树林将这里与都市分割开，使这里成为自然爱好者真正的天堂。</p><p style="margin: 0px 0px 0.8em; padding: 0px; line-height: 1.4; color: rgb(51, 51, 51); font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif; background-color: rgb(250, 250, 250);">特色指数：★★★★★</p><p style="margin: 0px 0px 0.8em; padding: 0px; line-height: 1.4; color: rgb(51, 51, 51); font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif; background-color: rgb(250, 250, 250);">神秘指数：★★★★★</p><p style="margin: 0px 0px 0.8em; padding: 0px; line-height: 1.4; color: rgb(51, 51, 51); font-family: Tahoma, Verdana, STHeiTi, simsun, sans-serif; background-color: rgb(250, 250, 250);">综合指数：★★★★★</p>', '旅游日志', '', 2, '2013-07-03 02:21:01'),
    (63, '经验 留学', NULL, NULL, 'EE GPA小弱求Offer的一点儿经验 2013Fall申请总结', 'lily', NULL, '<span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">还记得415那天，自己松了口气，在人人里发了篇日志，算是给自己一个交代。后来遇到一些准备出国的同学，发现虽然自己的背景和结果一般，但是因为申请了美国的PhD加国的MSc，基本申请过程都经历了一遍，还是有一些有用的经验，希望能够帮大家少走些弯路。在此毕业之际，在即将离开的宿舍里写下此文，默默祝福我的同学一生平安、一切顺利。祝福13Fall的各位一切顺利，也祝愿即将申请的勇士们都能成功飞越，拿到心仪的AD/Offer！</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">个人认为我的经验比较适用于希望拿到奖学金的童鞋，尤其是GPA需要弥补的……对于之前我从网上解决的问题就不再多说了，只说一些我感觉当时疑惑没有找到答案的争议性问题，提出一些自己的小见解，大神勿拍</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">废话少说，首先介绍一些自己的情况：</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">985 211 测控专业</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">GPA 83.7/100，3.28/4 （rank 50/120大概）</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">G 1320 3.5</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">T 108 S23</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">大三前暑假开始在实验室，在申请前基本完成一个项目。申请时无Paper。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">申请方向：光（EE BME OSE CS）</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">申请目标：北美，有奖</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">申请结果：U of Alabama Huntsville OSE（光学） PhD AD, UFL EE MS (AA奖), U of Calgary EE MSc offer。最终选择U of C。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="word-wrap: break-word; font-weight: 700; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">GT</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">GT的话，个人感觉还是越早越好（当然T的有效期一定要注意），一个是这样可以保证留出时间保证成绩够用（尽量一次通过！），同时如果你需要奖学金的话，大三大四最好还是能够有一个完整的时间在实验室里。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">对于GT的顺序，我是先G后T，这样的好处就是，T在听力口语没问题的情况下基本可以裸考（顺便刷个六级吧，倍儿爽，作文千万别写超了）。建议英语基础好的同学可以这样做。当然，如果基础一般，那么还是先T后G吧。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="word-wrap: break-word; font-weight: 700; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">PS、推荐信>amp;其他材料</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">PS这个东东应该还是蛮重要的，感觉好像如果套磁了的话这个也没有太大用处了，但是呢，其实陶瓷信很多部分和PS的实质是相同的。推荐信的话，Boss真的能自己写的真的太少见了，我的Boss们都是要求我写了之后他们去修改，不过修改之后也没给我看……所以具体信最后是怎样的我也不知道了。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">相关的材料网上有很多，在此不赘述。但是我想强调几点：</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">1.>nbsp; >nbsp; >nbsp; >nbsp; PS要说明你的性格，你的追求，你的经历、感悟、灵感，这种东西别人是不明白的！其实修改PS的过程也是对于自己认识深化的过程。不要找中介，他们做不到这一点。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">2.>nbsp; >nbsp; >nbsp; >nbsp; 务必找Native speaker帮忙修改。我的东西刚写出来的时候找了国外的朋友帮忙看，说我说话的方式感觉非常aggressive，虽然表面上看来语法一点问题也没有。这种问题估计只有native才能发现了。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">3.>nbsp; >nbsp; >nbsp; >nbsp; 推荐信记得把文件的作者改了哦~不需要像传说中那样打印出来老师签名再扫描，直接上传文档就好。如果自己传的话，千万别弄错了。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="word-wrap: break-word; font-weight: 700; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">套磁</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">这一部分我是想主要说一下的。我的GPA很惨，是我们专业这一届申请的人里面最惨的。感觉对于PhD来说好像GPA 3.5是个坎儿，MSc的话没有研究过。不过结果还好，最终还是拿到了Offer。感觉主要是套磁比较给力。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">什么情况下需要套磁呢？如果你需要进实验室，比如申请PhD或者加国的MSc，套磁很重要。你的分数、学过的课程等等不能说明你任何科研能力，paper啥的对方也不一定明白。所以一定要用套磁来突出自己在科研方面的潜力来吸引对方（当然，三围超牛的人也有完全不套照样拿大牛Offer的，我这小弱实在是不套就直接完蛋）。如果是授课型的，好像意义就不大了。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">我套磁回信如果算水回复大概是1/4。对于与我match的老师，有效回复的概率大概1/3。再强调一下，match非常重要！</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">我说的match不是那种狭义的match，不一定偏要你跟他做的东西完全一样。只要你用的一些方法，你的经验或者见解，对于他的方向同样适用，完全足够。千万不要在申请以前就把自己的方向限定的太狭窄。我申请了4个专业，EE BME CS OSE，都是选择与光相关的一些lab，如果算完全match的话，北美基本没有跟我之前做的相同的！都是德国和日本在做。所以，千万不要把自己定在太窄的方向里。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">我联系过程比较有代表性的老师有以下几个，在这里直接记为ABC老师吧，以防泄漏太多出问题哈哈。一点经历，供大家参考。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">A老师跟我做的部分相关，是个新AP，我的背景对他来说有用，但是他同时还需要另外一个方向的学生，而且更为急切，10月底第一次联系。我给他的套磁信长达600字，详述了我的研究经历，研究经历引发的一些思考（感觉经验和思考同等重要），对他方向的认识和展望。这个信是一气呵成的，完全是当时一脑袋热血涨出来的。A老师直接回复要求电话聊，聊了一个小时，主要内容关于我的项目以及他的项目介绍，说了一下他的项目现在存在的问题，讨论可能解决的方法。这一次比较失败的就是，我的项目中的一些解决方法帮助他的项目找到了思路，然后我直白的告诉他把我招过去不能解决这个问题（我的确不能），在这之后感觉他就不太热情了。但是一直到1月联系他依然很快回复，说会看申请神马的，再后来就跪了。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">B老师跟我项目相关性最大，完全一致，是个很一般的学校的教授。我的信就介绍了自己做了什么，然后跟他很match，我想继续这个方向。B老师回复也很热情，几次交流之后，甚至直接转发给招生委员会的人，而且对方也主动跟我联系了，介绍情况回答问题。这个后来跪了，原因在我看来，一个是当时以为很有把握，后来没跟这个教授保持联系（4个月没联系，早忘了），一个是我相关课程分数较低（60 ），估计没有过了招生委员会那关。我觉得，如果保持联系，要个面试，应该会有个Offer。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">C老师跟我方向相关，缺人，直接写出来需要我这种。我的信里主要介绍自己相关背景，然后表示对他感兴趣。他回信问了一些问题，发过来Paper问想法等等。经过一番考验后面试，直接口头Offer。这次感觉是首先比较match，而且对方缺人。面试和邮件表现都比较好，所以最后Offer。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">总结一点经验：</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">1.>nbsp; >nbsp; >nbsp; >nbsp; 写一个基本套磁信框架，然后根据不同老师适当修改。最基础的内容有：自我介绍（名字，学校，专业），研究经验介绍，用自己的经验match对方的东西而且最好能提出点儿想法，如果对方网页没有更新可以索要资料，最后表忠心问问要不要人。大概200字打住，然后根据不同的人稍微改一下内容和侧重点，第一封信就差不多了，等回信吧！</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">2.>nbsp; >nbsp; >nbsp; >nbsp; 如果一周内没有理你，就算理你基本也是水回复了，忘了他吧！（我的回复记录：最长53天，其次33天……都是模版）</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">3.>nbsp; >nbsp; >nbsp; >nbsp; 如果对方有效回复了，一定要保持联系！A和B两位老师的信我给学长看过之后他都觉得其实一直到录取前都是很有戏的。但是我真心没话说，所以总是不联系，最后只能让对方忘了我了。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">4.>nbsp; >nbsp; >nbsp; >nbsp; 从对方的用词可以看出态度，比如definitely want to keep in touch with you里面的definitely。然后YY对方的态度吧。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">5.>nbsp; >nbsp; >nbsp; >nbsp; 在正式的Offer以前，口头的东西都没有生效，请牢记这一点。尽量守住诺言，千万不要因为对方的一个口头承诺推掉一些机会，因为什么都说不准。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">6.>nbsp; >nbsp; >nbsp; >nbsp; 寻找match的老师和实验室最好的办法，第一是从平时看的论文里去找，第二是直接Google “Professor 项目关键字”，然后看域名edu，再去掉uk啊神马的别看~就搞定啦！</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="word-wrap: break-word; font-weight: 700; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">结果</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">套磁说完，基本上我这篇文的主要的东西也差不多了，最后说一下等结果。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">我第一个Offer也就是加拿大这个3.1就来了，要求4月之前回复，但是在我接受这个offer之前，除了一个拒信什么都没有。这是非常可能遇到的状况。请务必做好思想准备。当时我想了很久，觉得读个MSc真心不错，第一作为本科生感觉还需要一段时间仔细思考一下，这样盲目的直博会有些冲动。而且感觉MSc是个很好的跳板，同时去加国也是个很不错的选择。所以当时就这么应下了。</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">我在刚答应加国Offer之后的第二天就收到了UAH的PhD AD，里面让自己联系找实验室要钱，后来一起拿AD的人也都有钱了。紧接着后一天收到了UFL的MS……不过已经想明白了，已经从了，那就这样吧，I have my words.</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">以上是13Fall的一点小经验，希望能为大家提供一些信息！</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">记得去年的这个时候我也刚刚开始研究怎么申请，感谢前辈们留下的经验以及大家的热情帮助！</span><br style="word-wrap: break-word; color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);"><span style="color: rgb(68, 68, 68); font-family: Verdana, Helvetica, Arial, sans-serif; line-height: 21px; background-color: rgb(255, 255, 255);">大家加油，Bless All.</span>', '出国留学', '', 2, '2013-07-03 02:23:13');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;


-- Dumping structure for table notes.review_tag
DROP TABLE IF EXISTS `review_tag`;
CREATE TABLE IF NOT EXISTS `review_tag` (
  `review_id` int(10) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table notes.review_tag: ~30 rows (approximately)
DELETE FROM `review_tag`;
/*!40000 ALTER TABLE `review_tag` DISABLE KEYS */;
INSERT INTO `review_tag` (`review_id`, `tag`) VALUES
    (1, '随笔'),
    (1, '小说'),
    (1, '散文'),
    (1, '管理'),
    (2, '小说'),
    (2, '随笔'),
    (3, '散文'),
    (4, '管理'),
    (5, '随笔'),
    (10, '散文'),
    (11, '管理'),
    (13, '小说'),
    (15, '散文'),
    (17, '小说'),
    (43, '小说'),
    (44, '小说'),
    (50, '散文'),
    (51, '管理'),
    (55, '散文'),
    (57, '小说'),
    (58, '散文'),
    (59, '散文'),
    (60, '散文'),
    (61, '管理'),
    (61, '技术'),
    (61, '编程'),
    (62, '随笔'),
    (62, '旅游'),
    (63, '经验'),
    (63, '留学');
/*!40000 ALTER TABLE `review_tag` ENABLE KEYS */;


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
