create table orders
      (orderId INT,
       itemId INT,
       quantity INT,
       PRIMARY KEY(orderId, itemId)
       );
       
INSERT INTO orders VALUES ('2301', '3786', '3');
INSERT INTO orders VALUES ('2301', '4011', '6');
INSERT INTO orders VALUES ('2301', '9132', '8');
INSERT INTO orders VALUES ('2302', '5794', '4');
INSERT INTO orders VALUES ('2303', '4011', '2');
INSERT INTO orders VALUES ('2303', '3141', '2');

create table items
        (itemId INT,
         itemName VARCHAR(15),
         price REAL,
         PRIMARY KEY(itemId)
         );

INSERT INTO items VALUES ('3786', 'Net', '35.00');
INSERT INTO items VALUES ('4011', 'Racket', '65.00');
INSERT INTO items VALUES ('9132', 'Pack-3', '4.75');
INSERT INTO items VALUES ('5794', 'Pack-6', '5.00');
INSERT INTO items VALUES ('3141', 'Cover', '10.00');

create table customers
        (customerId INT,
         customerName VARCHAR(15),
         city VARCHAR(15),
         PRIMARY KEY(customerId)
         );
         
INSERT INTO customers VALUES ('101', 'Martin', 'Prague');
INSERT INTO customers VALUES ('107', 'Herman', 'Madrid');
INSERT INTO customers VALUES ('110', 'Pedro', 'Moscow');

create table orderCustomer
        (orderId INT,
         customerId INT,
         date DATE,
         PRIMARY KEY(orderId)
         );
         
INSERT INTO orderCustomer VALUES ('2301', '101', '2011-02-23');
INSERT INTO orderCustomer VALUES ('2302', '107', '2011-02-25');
INSERT INTO orderCustomer VALUES ('2303', '110', '2011-11-27');

CREATE TABLE schools (
    school_id INT PRIMARY KEY,
    school_name VARCHAR(50)
);

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(30),
    school_id INT
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(60),
    publisher VARCHAR(30)
);

CREATE TABLE loan_books (
    loan_id INT PRIMARY KEY,
    school_id INT,
    teacher_id INT,
    course VARCHAR(40),
    room VARCHAR(10),
    grade VARCHAR(15),
    book_id INT,
    loanData DATE
);
INSERT INTO schools VALUES ('1', 'Horizon Education Institute');
INSERT INTO schools VALUES ('2', 'Bright Institution');

INSERT INTO teachers VALUES ('1', 'Chad Russell', '1');
INSERT INTO teachers VALUES ('2', 'E.F.Codd', '1');
INSERT INTO teachers VALUES ('3', 'Jones Smith', '1');
INSERT INTO teachers VALUES ('4', 'Adam Baker', '2');

INSERT INTO books VALUES ('1', 'Learning and teaching in early childhood education', 'BOA Editions');
INSERT INTO books VALUES ('2', 'Preschool, N56', 'Taylor & Francis Publishing');
INSERT INTO books VALUES ('3', 'Early Childhood Education N9', 'Prentice Hall');
INSERT INTO books VALUES ('4', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill');

INSERT INTO loan_books VALUES ('1', '1', '1', 'Logical Thinking', '1.A01', '1st grade', '1', '2010-09-09');
INSERT INTO loan_books VALUES ('2', '1', '1', 'Writing', '1.A01', '1st grade', '2', '2010-05-05');
INSERT INTO loan_books VALUES ('3', '1', '1', 'Numerical thinking', '1.A01', '1st grade', '1', '2010-05-05');
INSERT INTO loan_books VALUES ('4', '1', '2', 'Spatial, Temporal and Causal Thinking', '1.B01', '1st grade', '3', '2010-05-06');
INSERT INTO loan_books VALUES ('5', '1', '2', 'Numerical thinking', '1.B01', '1st grade', '1', '2010-05-06');
INSERT INTO loan_books VALUES ('6', '1', '3', 'Writing', '1.A01', '2nd grade', '1', '2010-09-09');
INSERT INTO loan_books VALUES ('7', '1', '3', 'English', '1.A01', '2nd grade', '4', '2010-05-05');
INSERT INTO loan_books VALUES ('8', '2', '4', 'Logical Thinking', '2.B01', '1st grade', '4', '2010-12-18');
INSERT INTO loan_books VALUES ('9', '2', '4', 'Numerical Thinking', '2.B01', '1st grade', '1', '2010-05-06');

-- Exercise 2, b second query
select s.school_name as name, l.loanData as loanData, t.teacher_name as teacher_name, b.book_name as book_name
from (
    select school_id, min(loanData) as minData
    from loan_books
    group by school_id
) as d join loan_books as l join schools as s join teachers as t join books as b
  on d.school_id = l.school_id and d.minData = l.loanData and l.school_id = s.school_id and 
  t.teacher_id = l.teacher_id and b.book_id = l.book_id;

-- Exercise 2, b first query
select s.school_name, b.publisher, count(*) as number_of_books
from loan_books as l inner join books as b 
  inner join schools as s
  on b.book_id = l.book_id and s.school_id = l.school_id
group by l.school_id, b.publisher;


-- Exercise 1, b second query
select c.customerId, c.customerName, r.total_sum, r.total_number_of_items
from (select o.orderId as order_ID, count(*) as total_number_of_items, sum(i.price * o.quantity) as total_sum
  from orders as o left join items as i
    on o.itemId = i.itemId
  group by o.orderId) as r inner join orderCustomer as oc inner join customers as c
where r.order_ID = oc.orderId and oc.customerId = c.customerId
order by r.total_sum DESC
limit 1;

-- Exercise 1, b first query
select o.orderId as order_ID, count(*) as total_number_of_items, sum(i.price * o.quantity) as total_sum
from orders as o left join items as i
  on o.itemId = i.itemId
group by o.orderId;