CREATE TABLE `book` (
	`isbn` VARCHAR(50) NOT NULL DEFAULT '',
	`name` VARCHAR(200) NULL DEFAULT NULL,
	`author` VARCHAR(50) NULL DEFAULT NULL,
	`translator` VARCHAR(50) NULL DEFAULT NULL,
	`publisher` VARCHAR(50) NULL DEFAULT NULL,
	`cover_pic` VARCHAR(100) NULL DEFAULT NULL,
	`publish_dt` VARCHAR(100) NULL DEFAULT NULL,
	PRIMARY KEY (`isbn`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

CREATE TABLE `comment` (
	`comment_id` INT(11) NOT NULL AUTO_INCREMENT,
	`post_id` INT(11) NOT NULL,
	`user_id` VARCHAR(30) NOT NULL DEFAULT '',
	`content` VARCHAR(500) NULL DEFAULT NULL,
	`create_time` DATE NULL DEFAULT NULL,
	`create_time_str` VARCHAR(30) NOT NULL DEFAULT '',
	PRIMARY KEY (`comment_id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=8;

CREATE TABLE `follows` (
	`user_id` VARCHAR(30) NOT NULL DEFAULT '',
	`follower_id` VARCHAR(30) NOT NULL DEFAULT '',
	PRIMARY KEY (`user_id`, `follower_id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

CREATE TABLE `post` (
	`post_id` INT(11) NOT NULL AUTO_INCREMENT,
	`ref_post_id` INT(11) NULL DEFAULT NULL,
	`user_id` VARCHAR(30) NOT NULL DEFAULT '',
	`content` VARCHAR(500) NOT NULL DEFAULT '',
	`create_time` DATE NULL DEFAULT NULL,
	`create_time_str` VARCHAR(30) NOT NULL DEFAULT '',
	`send_source` VARCHAR(30) NOT NULL DEFAULT '',
	`favorite_count` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`post_id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=41;

CREATE TABLE `review` (
	`isbn` VARCHAR(50) NULL DEFAULT NULL,
	`user_id` VARCHAR(50) NULL DEFAULT NULL,
	`rating` INT(5) NULL DEFAULT NULL,
	`content` VARCHAR(300) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;


CREATE TABLE `user` (
	`user_id` VARCHAR(30) NOT NULL DEFAULT '',
	`name` VARCHAR(30) NOT NULL DEFAULT '',
	`password` VARCHAR(30) NOT NULL DEFAULT '',
	`email` VARCHAR(30) NOT NULL DEFAULT '',
	`gender` VARCHAR(30) NOT NULL DEFAULT '',
	`come_from` VARCHAR(30) NOT NULL DEFAULT '',
	`create_time` DATE NOT NULL,
	`portrait_small` VARCHAR(30) NOT NULL DEFAULT '',
	`portrait_large` VARCHAR(30) NOT NULL DEFAULT '',
	`sort_ind` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`user_id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB;




insert into review values ('9787111255833', '1', 1, "好");
insert into review values ('9787115232687', '1', 1, "好");
