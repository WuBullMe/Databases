CREATE TABLE IF NOT EXISTS accounts (
     name varchar(200) NOT NULL,
     id int  NOT NULL,
     credit int not null,
     currency varchar(10) not null,
     BankName varchar (20) not null,
     PRIMARY KEY (id)
);


insert into accounts (name, id, credit, currency, BankName) values 
	('Muhammad', 1, 1000, 'RUB', 'SberBank'),
	('Sadi', 2, 1000, 'RUB', 'Tinkoff'),
	('akai_Davlat', 3, 1000, 'RUB', 'SberBank'),
	('gareni', 4, 0, 'RUB', 'SberBank');

CREATE TABLE ledger (
    id int not null,
    from_account_id INTEGER NOT NULL,
    to_account_id INTEGER NOT NULL,
    fee INTEGER NOT NULL,
    amount INTEGER NOT NULL,
    transaction_datetime TIMESTAMP NOT null,
    PRIMARY KEY(id)
);

-- Start transaction
START TRANSACTION;


-- T1: Account 1 send 500 RUB to Account 3
SAVEPOINT t1;
UPDATE accounts SET credit = credit - 500 WHERE id = 1;
UPDATE accounts SET credit = credit + 500 WHERE id = 3;
UPDATE accounts SET credit = credit + 0 WHERE id = 4;
INSERT INTO ledger (id, from_account_id, to_account_id, fee, amount, transaction_datetime)
VALUES (1, 1, 3, 0, 500, NOW());

-- T2: Account 2 send 700 RUB to Account 1
SAVEPOINT t2;
UPDATE accounts SET credit = credit - 700 WHERE id = 2;
UPDATE accounts SET credit = credit + 670 WHERE id = 1;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;
INSERT INTO ledger (id, from_account_id, to_account_id, fee, amount, transaction_datetime)
VALUES (2, 2, 1, 30, 700, NOW());

-- T3: Account 2 send to 100 RUB to Account 3
SAVEPOINT t3;
UPDATE accounts SET credit = credit - 100 WHERE id = 2;
UPDATE accounts SET credit = credit + 70 WHERE id = 3;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;
INSERT INTO ledger (id, from_account_id, to_account_id, fee, amount, transaction_datetime)
VALUES (3, 2, 3, 30, 100, NOW());

-- Return the amount Credit for all Account and Transaction
SELECT * FROM accounts;
select * from ledger;

-- Rollback T3
ROLLBACK TO SAVEPOINT t3;

-- Rollback T2
ROLLBACK TO SAVEPOINT t2;

-- Rollback T1
ROLLBACK TO SAVEPOINT t1;

-- Commit transaction
commit;
