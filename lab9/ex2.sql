drop function retrieves_customers;

create or replace function retrieves_customers(
    start_address_id INTEGER,
    end_address_id INTEGER
)
returns table (
    customerId INTEGER,
    addressId SMALLINT,
    firstname  VARCHAR,
    lastname   VARCHAR,
    email_ VARCHAR
)
as
$$
begin
    if(not((0 <= $1 and $1 < 600) and (0 <= $2 and $2 < 600) and ($1 <= $2)))
    then
        raise exception 'Something went wrong';
    end if;
    return query select customer_id, address_id, first_name, last_name, email
    from customer
    where address_id between $1 and $2
    order by address_id;
end;
$$ language plpgsql;

select *
from retrieves_customers(10, 40);