insert into `author` (`first_name`, `last_name`)
values
('Peter', 'Temple'),
('Peter', 'Corris'),
('Tara', 'Moss'),
('Merrilee', 'Moss');

insert into `publisher` (`name`)
values
('Random House'),
('Harper Collins'),
('Text'),
('Allen and Unwin');

insert into `format` (`name`)
values
('Paperback'),
('Hardback');

insert into `book`
set
`title` = 'The Broken Shore',
`author` = 1,
`publisher` = 3,
`format` = 1,
`isbn` = 9781921656774,
`published_date` = '2010-09-27';