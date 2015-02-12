-- ===== TABLE USER ===== 
DROP TABLE `user`;
CREATE TABLE `user` (
    `user_id` VARCHAR(30) NOT NULL DEFAULT '',
    `name` VARCHAR(30) NOT NULL DEFAULT '',
    `password` VARCHAR(30) NOT NULL DEFAULT '',
    `email` VARCHAR(30) NOT NULL DEFAULT '',
    `gender` VARCHAR(30) NOT NULL DEFAULT '',
    `come_from` VARCHAR(30) NOT NULL DEFAULT '',
    `create_time`DATE NOT NULL,
    `portrait_small` VARCHAR(30) NOT NULL DEFAULT '',
    `portrait_large` VARCHAR(30) NOT NULL DEFAULT '',
    `sort_ind` INT NOT NULL DEFAULT 0,
    
    PRIMARY KEY (`user_id`)
);

DELETE FROM `user`;
INSERT INTO `user` (user_id, name, `password`, gender, come_from, create_time, portrait_small, portrait_large, email, sort_ind)
VALUES
('echo', 'Echo', '123', 'f', 'USA', '2012-06-01 00:00:00', 'img/people/person3.png', 'img/user2.jpg', 'echo.gong@fudan.edu.cn', 3),
('sally', 'Sally', '123', 'f', 'Zulu', '2012-06-01 00:00:00', 'img/people/person1.png', 'img/people/person1.png', 'sally.wang@fudan.edu.cn', 1),
('carole', 'Carole', '123', 'f', 'Anhui', '2012-06-01 00:00:00', 'img/people/person2.png', 'img/people/person2.png', 'carole.li@fudan.edu.cn', 2),
('bob', 'Bob', '123', 'm', 'Shanghai', '2012-06-01 00:00:00', 'img/people/person4.png', 'img/people/person4.png', 'bob.zhao@fudan.edu.cn', 4),
('lucy', 'Lucy', '123', 'f', 'Shanghai', '2012-06-01 00:00:00', 'img/people/person5.png', 'img/people/person5.png', 'lucy.wang@fudan.edu.cn', 5),
('lily', 'Lily', '123', 'f', 'Beijing', '2012-06-01 00:00:00', 'img/people/person6.png', 'img/people/person6.png', 'Lily.li@fudan.edu.cn', 6),
('july', 'July', '123', 'm', 'Korea', '2012-06-01 00:00:00', 'img/people/person7.png', 'img/people/person7.png', 'july.xin@fudan.edu.cn', 7),
('alex', 'Alex', '123', 'm', 'Shanghai', '2012-06-01 00:00:00', 'img/people/person8.png', 'img/people/person8.png', 'alex.lv@fudan.edu.cn', 8),
('chris', 'Chris', '123', 'm', 'USA', '2012-06-01 00:00:00', 'img/people/person9.png', 'img/people/person9.png', 'chris.lv@fudan.edu.cn', 9),
('adam', 'Adam', '123', 'm', 'Jiangsu', '2012-06-01 00:00:00', 'img/people/person10.jpg', 'img/people/person10.jpg', 'adam.xin@fudan.edu.cn',3),
('andy', 'Andy', '123', 'm', 'Jilin', '2012-06-01 00:00:00', 'img/people/person11.jpg', 'img/people/person11.jpg', 'andy.wang@fudan.edu.cn',1),
('tina', 'Tina', '123', 'f', 'Japan', '2012-06-01 00:00:00', 'img/people/person12.jpg', 'img/people/person12.jpg', 'tina.li@fudan.edu.cn',2),
('zoe', 'Zoe', '123', 'f', 'Wuxi', '2012-06-01 00:00:00', 'img/people/person13.jpg', 'img/people/person13.jpg', 'zoe.zhao@fudan.edu.cn',4),
('vicky', 'vicky', '123', 'f', 'Shanghai', '2012-06-01 00:00:00', 'img/people/person14.jpg', 'img/people/person14.jpg', 'vicky.wang@fudan.edu.cn',5),
('susan', 'Susan', '123', 'f', 'UK', '2012-06-01 00:00:00', 'img/people/person15.jpg', 'img/people/person15.jpg', 'susan.li@fudan.edu.cn', 6);

select * from user order by sort_ind asc;

create view vw_user_post as 
    select u.user_id, count(p.post_id) as post_count 
    from user u left join post p
    on u.user_id = p.user_id
    group by user_id 

create view vw_user_fans as
    select u.user_id, count(f.follower_id) as fans_count 
    from user u left join follows f 
    on u.user_id = f.user_id 
    group by user_id 

create view vw_user_follow as 
    select u.user_id, count(f.user_id) as follow_count 
    from user u left join follows f 
    on u.user_id = f.follower_id 
    group by user_id 

create view vw_user_followed as
    select 
    u.*,
    ufd.follow_count as follow_count,
    ufr.fans_count as fans_count,
    up.post_count as post_count
    from user u 
    left join vw_user_follow ufd on ufd.user_id = u.user_id
    left join vw_user_fans ufr on ufr.user_id = u.user_id
    left join vw_user_post up on up.user_id = u.user_id
    order by u.sort_ind asc 

create view vw_counted_user as 
select 
    u.*,
    ufd.follow_count as follow_count,
    ufr.fans_count as fans_count,
    up.post_count as post_count
from user u 
left join vw_user_follow ufd on ufd.user_id = u.user_id
left join vw_user_fans ufr on ufr.user_id = u.user_id
left join vw_user_post up on up.user_id = u.user_id
order by u.sort_ind asc 
    
    
-- ===== TABLE POST ===== 
DROP TABLE `post`;
CREATE TABLE `post` (
    `post_id` INT NOT NULL AUTO_INCREMENT,
    `ref_post_id` INT NULL,
    `user_id` VARCHAR(30) NOT NULL DEFAULT '',
    `content` VARCHAR(500) NOT NULL DEFAULT '',
    `create_time` DATE,
    `create_time_str` VARCHAR(30) NOT NULL DEFAULT '',
    `send_source` VARCHAR(30) NOT NULL DEFAULT '',
    `favorite_count` INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (`post_id`)
);

DELETE FROM post;
INSERT INTO post (post_id, ref_post_id, user_id, content, create_time, create_time_str, send_source, favorite_count)
VALUES
(1, NULL, 'lily', '【夏日最有可能晒不黑的星座女TOP5】NO.5双子座（每天都不忘敷面膜）、NO.4天秤座（上下班都戴着防晒帽）、NO.3金牛座（宅在家中不出门）、NO.2天蝎座（外出永远叫出租车）、NO.1射手座（出门不忘涂防晒露）', NULL, '昨天 23:10', '皮皮时光机', 71),
(2, NULL, 'alex', '【人间差距是怎样炼成的】1、别人看电视的时候，你在锻炼，或参加各种培训班；2、别人嘲笑的时候，你在闷头苦干；3、别人想着如何换工作的时候，你在想着如何做得更好；4、别人抱怨的时候，你在思考解决之道；5、别人想着归入哪一派时，你在寻求专业突破；6、每天坚持写日记，三省吾身。', NULL, '昨天 23:10', '皮皮时光机', 12),
(3, NULL, 'july', '【关于饭局的心理】1.提前一天预约是真请你，提前半天你是作陪，上菜了才请你是凑数的。2.一请就来叫爽快，三请才来叫摆谱，怎么请都不来叫原则，不请自来叫蹭饭。3.一周一饭局是正常人，一天一饭局是大红人，一天三饭局是交际花，一天N饭局是端盘子的。', NULL, '昨天 23:10', '皮皮时光机', 71),
(4, NULL, 'sally', '世界上有这么一个男人，小时候你怕他的威严，长大了你学他沉稳，他的爱很深沉但不求回报；你跟他撒娇耍赖瞎胡闹，他批评训斥你，但他对你的爱却从不改变；你只一句话，他就成为你的超人兼跑腿兼保镖兼顾问……全球最靠谱的男人就是他！——这个人就是最爱的老爸', NULL, '9:10', '皮皮时光机', 14),
(5, 2, 'bob', '昨日一人游乌镇，自娱自乐，感觉西栅要比东栅好得多。梦中之江南水乡，尤其华灯初上，古朴之中透着万种风情，留恋之处迟迟不肯退去。', NULL, '9:10', '皮皮时光机', 12),
(6, NULL, 'echo', 'There is a time in life that is full of uneasiness.We have no other choice but to face it.——生命中总有那么一段时光，充满不安，可是除了勇敢面对，我们别无选择。', NULL, '今天 9:23', 'BON Web版', 87),
(7, NULL, 'chris', '【历史的真相】1.当初关羽带着两个嫂嫂进了曹营，后来与毫发无损的出来！2.赵云带着阿斗杀的曹军丢盔弃甲，曹操却命令属下不准放箭！3.赵云带着阿斗回归后，刘备气愤得摔阿斗！4.刘备死时说如果阿斗不能辅佐就让诸葛亮替位！5.当魏军攻到成都，阿斗果断开门投降！——我好像知道了什么...（转）', NULL, '昨天 23:10', '皮皮时光机', 71),
(8, 6, 'bob', 'Fantastic! //@echo There is a time in life that is full of uneasiness.We have no other choice but to face it.——生命中总有那么一段时光，充满不安，可是除了勇敢面对，我们别无选择。', NULL, ' 23:10', '皮皮时光机', 71),
(9, 6, 'carole', '我很赞同 ！//@bob Fantastic! //@Echo There is a time in life that is full of uneasiness.We have no other choice but to face it.——生命中总有那么一段时光，充满不安，可是除了勇敢面对，我们别无选择。', NULL, '9:10', '皮皮时光机', 72),
(10, NULL, 'lucy', '你走，我不送你。你来，无论多大风多大雨，我要去接你。——梁实秋', NULL, '10:25', 'iPhone客户端', 21),
(11, NULL, 'adam', '人生若只如初见，何事秋风悲画扇。 等闲变却故人心，却道故人心易变。 骊山语罢清宵半，夜雨霖铃终不怨。 何如薄幸锦衣儿，比翼连枝当日愿。有情不必终老，暗香浮动恰好，无情未必就是决绝，我只要你记着：初见时彼此的微笑！', NULL, '昨天 23:10', '皮皮时光机', 22),
(12, 11, 'adam', '欲成大器，先要大气。大气之人，语气不惊不惧，性格不骄不躁，气势不张不扬，举止不猥不琐，静得优雅，动得从容，行得洒脱。大气之人，如一朵花，花香淡雅而悠长；如一棵树，枝叶茂盛而常青。大气之人，能安安心心做好本分的角色，认认真真干好手头的事情，不为名利而争斗，不为钱财而纠结。', NULL, '昨天 23:10', '皮皮时光机', 22),
(13, 10, 'adam', '不要忘记“家”的感觉有多好！', NULL, '昨天 23:10', '皮皮时光机', 29),
(14, NULL, 'adam', '【攻心术之人性悖论】1、一个人炫耀什么，说明内心缺少什么。2、一个人越在意的地方，就是最令他自卑的地方。3、有些人越越想得到的，就越是装作无所谓；越怕失去的，就越是装作不在乎。 4、憎恨某人，优点被看成伪装；喜欢某人，缺点也变得美好。', NULL, '9:10', '皮皮时光机', 62),
(15, 13, 'andy', '亲们，忙碌的一天又过去咯～在睡前，对于新的一天，有什么期待哦～小管今晚要熬夜干活咯，在这里祝福所有妞儿一觉起来后，神清气爽，事事顺心～。', NULL, '9:10', '皮皮时光机', 76),
(16, 4, 'tina', '以诗会友千般好，不落晶莹不落心。', NULL, '今天 9:23', 'BON Web版', 33),
(17, NULL, 'zoe', '世界上最难的是开诚相见，最容易的是阿谀奉承。开诚相见，只要有百分之一的虚假，那么马上就会出现不和谐，麻烦就会随之而来；阿谀奉承，哪怕从头至尾都是虚假，但令人感到高兴，听起来很舒服，哪怕觉得肉麻。——陀思妥耶夫斯基 《罪与罚》', NULL, '昨天 23:10', '皮皮时光机', 29),
(18, 3, 'vicky', '就让我一个人失忆。，过2个人的各自生活，忘却2个人一起的记忆——《命中注定我爱你》的歌曲，好感人。', NULL, ' 23:10', '皮皮时光机', 22),
(19, null, 'susan', '轻吟一句情话，执笔一副情画。 绽放一地情花，覆盖一片青瓦。 共饮一杯清茶，同研一碗青砂。 挽起一面轻纱，看清天边月牙。爱像水墨青花，何惧刹那芳华。——徐志摩《水墨青花》',NULL, '9:10', '皮皮时光机', 62),
(20, 7, 'andy', '人生百味，浓缩到最后，就是一个淡字。',NULL, '10:25', 'iPhone客户端', 179);


select * from post order by post_id asc

select p.*, u.portrait_small as user_image, u.name as user_name 
from post p, user u 
where p.user_id = u.user_id
order by post_id desc

--VERSION 1 (DECO)
select 
p.*, 
u.portrait_small as user_image, 
u.name as user_name,
u2.user_id as ref_user_id,
u2.name as ref_user_name,
u2.portrait_small as ref_user_image,
p2.content as ref_content,
p2.forward_count as ref_forward_count,
p2.comment_count as ref_comment_count
from post p
left join user u on p.user_id = u.user_id
left join post p2 on p.ref_post_id = p2.post_id
left join user u2 on p2.user_id = u2.user_id
order by post_id desc


--VERSION 2
select 
p.post_id, 
p.ref_post_id, 
p.user_id, 
p.content, 
p.create_time, 
p.create_time_str, 
p.send_source, 
p.favorite_count, 
IFNULL(forward_count,0) as forward_count, 
IFNULL(comment_count,0) as comment_count,
u.portrait_small as user_image, 
u.name as user_name,
pv1.post_id,
pv1.content,
pv1.ref_forward_count,
pv1.ref_comment_count,
pv1.ref_user_image,
pv1.ref_user_name
from post p
left join user u on p.user_id = u.user_id
left join (select count(p1.post_id) as forward_count, p1.ref_post_id as ref_post_id 
                from post p1 group by p1.ref_post_id) fc 
      on fc.ref_post_id = p.post_id
left join (select count(c1.comment_id) as comment_count, c1.post_id as ref_post_id 
                from comment c1 group by c1.post_id) cc 
      on cc.ref_post_id = p.post_id

left join (select p2.*, 
                        IFNULL(ref_forward_count,0) as ref_forward_count, 
                        IFNULL(ref_comment_count,0) as ref_comment_count ,                      
                        u2.portrait_small as ref_user_image, 
                        u2.name as ref_user_name
              from post p2 
              left join user u2 on p2.user_id = u2.user_id
              left join (select count(p3.post_id) as ref_forward_count, p3.ref_post_id as ref_post_id from post p3 group by p3.ref_post_id) fc2 
                        on fc2.ref_post_id = p2.post_id
               left join (select count(c2.comment_id) as ref_comment_count, c2.post_id as ref_post_id from comment c2 group by c2.post_id) cc2
                        on cc2.ref_post_id = p2.post_id) pv1 
        on p.ref_post_id = pv1.post_id
order by p.post_id desc


--VERSIOIN 3 -VIEWS
DROP VIEW vw_post_forward;
create view vw_post_forward as 
    select count(c1.comment_id) as forward_count, c1.post_id as ref_post_id 
    from comment c1 group by c1.post_id;
                
create view vw_post_comment as
    select count(c1.comment_id) as comment_count, c1.post_id as ref_post_id 
    from comment c1 group by c1.post_id
    
create view vw_counted_post as
    select 
    p.*, 
    IFNULL(fc.forward_count,0) as forward_count, 
    IFNULL(cc.comment_count,0) as comment_count,
    u.portrait_small as user_image, 
    u.name as user_name
    from post p
    left join user u on p.user_id = u.user_id
    left join vw_post_forward fc on fc.ref_post_id = p.post_id
    left join vw_post_comment cc on cc.ref_post_id = p.post_id
    order by post_id desc 
    
create view vw_full_post as
    select 
    p.*,
    pr.content as ref_content,
    pr.forward_count as ref_forward_count,
    pr.comment_count as ref_comment_count,
    pr.user_id as ref_user_id,
    pr.user_name as ref_user_name,
    pr.user_image as ref_user_image
    from vw_counted_post p
    left join vw_counted_post pr on p.ref_post_id = pr.post_id 
    order by p.post_id desc 

-- ===== TABLE COMMENT ===== 
DROP TABLE `comment`;
CREATE TABLE `comment` (
    `comment_id` INT(11) NOT NULL AUTO_INCREMENT,
    `post_id` INT NOT NULL,
    `user_id` VARCHAR(30) NOT NULL DEFAULT '',
    `content` VARCHAR(500),
    `create_time` DATE,
    `create_time_str` VARCHAR(30) NOT NULL DEFAULT '',
    
    PRIMARY KEY (`comment_id`)
);

DELETE FROM comment;
INSERT INTO comment (comment_id, post_id, user_id, content, create_time, create_time_str)
VALUES 
(1, 10, 'lucy', '好温馨！', NULL, '10:30'),
(2, 10, 'sally', '好好人做不得诶~', NULL, '10:32'),
(3, 10, 'chris', '好吧我承认我就是这样的~', NULL, '11:05'),
(4, 7, 'lucy', '！', NULL, '10:30'),
(5, 8, 'sally', '好好人做不得诶~', NULL, '10:32'),
(6, 9, 'chris', '好吧我承认我就是这样的~', NULL, '11:05');

select *, u.name as user_name, u.portrait_small as user_image_small
from comment c
left join user u
on c.user_id = u.user_id
where c.post_id = 10
order by comment_id desc

-- ===== TABLE FOLLOWS ===== 
-DROP TABLE `follows`;
CREATE TABLE `follows` (
    `user_id` VARCHAR(30) NOT NULL DEFAULT '',
    `follower_id` VARCHAR(30) NOT NULL DEFAULT '',
    PRIMARY KEY (`user_id`, `follower_id`)
)

DELETE FROM follows;
INSERT INTO follows (`user_id`, `follower_id`) values
('alex', 'bob'),
('bob', 'alex'),
('carole', 'echo'),
('chris', 'alex'),
('echo', 'bob'),
('echo', 'carole'),
('echo', 'chris'),
('echo', 'july'),
('echo', 'lily'),
('echo', 'sally'),
('july', 'alex'),
('july', 'echo'),
('lily', 'bob'),
('lily', 'chris'),
('lily', 'echo'),
('lucy', 'carole'),
('lucy', 'july'),
('echo','alex'),
('lily','alex'),
('lucy','alex'),
('carole','alex'),
('july','bob'),
('carole','bob'),
('sally','bob'),
('carole','chris'),
('sally','chris'),
('alex','chris'),
('bob','chris'),
('july','chris'),
('chris','echo'),
('bob','echo'),
('sally','echo'),
('lucy','echo'),
('alex','lily'),
('chris','lily'),
('sally','lily'),
('bob','lily'),
('alex','lucy'),
('chris','lucy'),
('bob','lucy'),
('echo','lucy'),
('alex','carole'),
('chris','carole'),
('bob','carole'),
('lily','carole'),
('alex','july'),
('bob','july'),
('chris','july'),
('lily','july'),
('alex','sally'),
('bob','sally'),
('chris','sally'),
('lucy','sally'),
('lily','sally'),
('carole','sally'),
('july','sally'),
('alex','echo'),
('adam','alex'),
('andy','alex'),
('zoe','alex'),
('susan','alex'),
('adam','bob'),
('andy','bob'),
('susan','bob'),
('tina','chris'),
('vicky','chris'),
('andy','chris'),
('adam','chris'),
('susan','chris'),
('susan','echo'),
('andy','echo'),
('tina','echo'),
('adam','echo'),
('adam','lily'),
('andy','lily'),
('tina','lily'),
('vicky','lily'),
('vicky','lucy'),
('tina','lucy'),
('adam','lucy'),
('andy','lucy'),
('vicky','carole'),
('adam','carole'),
('andy','carole'),
('tina','carole'),
('susan','july'),
('vicky','july'),
('adam','july'),
('andy','july'),
('susan','sally'),
('andy','sally'),
('tina','sally'),
('vicky','sally'),
('adam','sally'),
('zoe','sally'),
('zoe','echo');
