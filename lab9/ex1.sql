create or replace function get_addresses_with_11()
returns table (
  address_id INTEGER,
  city       VARCHAR(30),
  address    VARCHAR(30)
)
as $$
begin
  return query select a.address_id, c.city, a.address
               from address a
               join city c ON a.city_id = c.city_id
               where a.address like '%11%'
                 and c.city_id between 400 and 600;
end;
$$ language plpgsql;

select * from get_addresses_with_11();

alter table address
  add COLUMN latitude float,
  add COLUMN longitude float;

select * from address;
