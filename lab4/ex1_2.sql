
  
CREATE TABLE IF NOT EXISTS `Specialization` (
     `name` varchar(200) NOT NULL,
      PRIMARY KEY (`name`)
);

insert into Specialization (name) values 
  ('Robotics'),
  ('AAI'),
  ('DS'),
  ('SD'),
  ('CS');

CREATE TABLE IF NOT EXISTS `Course` (
     `name` varchar(200) NOT NULL,
     `credits` int NOT NULL,
     PRIMARY KEY (`name`)
) ;

insert into Course (name, credits) values
  ('SQL', '5'),
  ('Networks', '2'),
  ('DSA', '10'),
  ('Theory game', '5');

CREATE TABLE IF NOT EXISTS `Student` (
     `name` varchar(200) NOT NULL,
     `id` int  NOT NULL,
     `native language` varchar(200) NOT NULL,
     PRIMARY KEY (`id`)
)  ;

insert into Student (name, id, `native language`) values
  ('Sadi', '1', 'tajik'),
  ('Maga', '2', 'english'),
  ('DavlatSun', '3', 'russian'),
  ('NodirBoviev', '4', 'tajik'),
  ('Jordon', '5', 'english'),
  ('Vladik', '6', 'russian'),
  ('Anton', '7', 'russian'),
  ('Sanya', '8', 'russian'),
  ('Gera', '9', 'turkey'),
  ('Wow', '10', 'english'),
  ('Gigi', '11', 'russian');

CREATE TABLE IF NOT EXISTS `takes` (
     `name` varchar(200) NOT NULL,
      `id` int  NOT NULL,
      foreign key (`name`) references `Specialization`(`name`),
      foreign key (`id`) references `Student`(`id`)
) ;

insert into takes (name, id) values
  ('AAI', '1'),
  ('DS', '3'),
  ('AAI', '2'),
  ('DS', '4'),
  ('Robotics', '5');

CREATE TABLE IF NOT EXISTS `enroll` (
     `name` varchar(200) NOT NULL,
      `id` int  NOT NULL,
      foreign key (`name`) references `Course`(`name`),
      foreign key (`id`) references `Student`(`id`)
) ;

insert into enroll (id, name) values
  ('1', 'SQL'),
  ('1', 'Networks'),
  ('2', 'SQL'),
  ('2', 'Networks'),
  ('3', 'Theory game'),
  ('4', 'DSA'),
  ('5', 'SQL');
  
-- query a
select s.name
from Student as s
limit 10;

-- query b
select s.name
from Student as s
where s.`native language` != 'russian';

-- query c
select distinct s.name
from takes as t inner join Student as s
on t.id = s.id
where t.name = 'Robotics';


-- query d
select distinct c.name, s.name
from enroll as e inner join Course as c
    on e.name = c.name
    inner join Student as s 
    on e.id = s.id
where c.credits < 3;

-- query e
select distinct e.name
from enroll as e inner join Student as s
    on e.id = s.id and s.`native language` = 'english'
  


