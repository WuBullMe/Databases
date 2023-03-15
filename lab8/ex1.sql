-- before index
explain select *
from customer
where name = 'Natalie Ellis';
-- cost: 0.00
-- time: 43.50

explain select *
from customer
where address = '07920 Devin Crescent
West Matthew, VT 32196';
-- cost: 0.00
-- time: 43.50

create index name_btree on customer using btree(address);
create index name_hash on customer using HASH (name);

-- after index
explain select *
from customer
where name = 'Natalie Ellis';
-- cost: 0.00
-- time: 8.02

explain select *
from customer
where address = '07920 Devin Crescent
West Matthew, VT 32196';
-- cost: 0.28
-- time: 8.29