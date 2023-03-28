CREATE TABLE IF NOT EXISTS account (
     username varchar(200) NOT NULL,
     fullname varchar(200) NOT NULL,
     balance int not null,
     Group_id int not null,
     PRIMARY KEY (name, fullname)
);

insert into account (username, fullname, balance, Group_id) values 
	('jones', 'Alice Jones', 82, 1),
	('bitdiddl', 'Ben Bitdiddle', 65, 1),
	('mike', 'Michael Dole', 73, 2),
	('alyssa', 'Alyssa P. Hacker', 79, 3),
	('bbrown', 'Bob Brown', 100, 3);


-- Terminal 1
begin transaction isolation level read committed;
select * from account;

select * from account;
-- after step 4 terminals show different information, in first terminal it shows jones and ajones for the second one.

update account set balance = balance + 10
where fullname = 'Alice Jones';

commit;


-- Terminal 2
begin transaction isolation level read committed;
update account set username = 'ajones'
where fullname = 'Alice Jones';
select * from account;

commit;


begin transaction isolation level read uncommitted ;

-- while trying to perform below operation, the infinite execution happens
update account set balance = balance + 20
where fullname = 'Alice Jones';
rollback;
commit;

