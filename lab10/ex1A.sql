CREATE TABLE IF NOT EXISTS accounts (
     name varchar(200) NOT NULL,
     id int  NOT NULL,
     credit int not null,
     currency varchar(10) not null,
     PRIMARY KEY (id)
);


insert into accounts (name, id, credit, currency) values 
	('Muhammad', 1, 1000, 'RUB'),
	('Sadi', 2, 1000, 'RUB'),
	('akai_Davlat', 3, 1000, 'RUB');


-- Start transaction
START TRANSACTION;


-- T1: Account 1 send 500 RUB to Account 3
SAVEPOINT t1;
UPDATE accounts SET credit = credit - 500 WHERE id = 1;
UPDATE accounts SET credit = credit + 500 WHERE id = 3;

-- T2: Account 2 send 700 RUB to Account 1
SAVEPOINT t2;
UPDATE accounts SET credit = credit - 700 WHERE id = 2;
UPDATE accounts SET credit = credit + 700 WHERE id = 1;

-- T3: Account 2 send to 100 RUB to Account 3
SAVEPOINT t3;
UPDATE accounts SET credit = credit - 100 WHERE id = 2;
UPDATE accounts SET credit = credit + 100 WHERE id = 3;

-- Return credit for all accounts
SELECT * FROM accounts;

-- Rollback T3
ROLLBACK TO SAVEPOINT t3;

-- Rollback T2
ROLLBACK TO SAVEPOINT t2;

-- Rollback T1
ROLLBACK TO SAVEPOINT t1;

-- Commit transaction
COMMIT;


