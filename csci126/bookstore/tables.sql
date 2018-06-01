create table `book`
(
	`id` integer not NULL auto_increment,
	`title` varchar(200) not NULL,
    `author` integer not NULL default 0,
    `publisher` integer not NULL default 0,
    `published_date` date,
    `isbn` decimal(13),
    `price` decimal(5,2),
    `format` integer not NULL default 0,
    primary key (`id`),
    key (`title`),
    key (`author`),
    key (`publisher`),
    key (`format`)
);

create table `author`
(
	`id` integer not NULL auto_increment,
    `first_name` varchar(50),
    `last_name` varchar(50) not NULL,
    primary key (`id`),
    key (`last_name`)
);

create table `publisher`
(
	`id` integer not NULL auto_increment,
    `name` varchar(100) not NULL,
    `notes` text,
    primary key (`id`),
    key (`name`)
);

create table `format`
(
	`id` integer not NULL auto_increment,
    `name` varchar(20) not NULL,
    `notes` text,
    primary key (`id`),
    key (`name`)
);