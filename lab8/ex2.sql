-- first query
select distinct f.title, f.rating, cc.name
from film as f
join film_category as f_c
	on f.film_id = f_c.film_id
join category as cc
	on f_c.category_id = cc.category_id
where (cc.name = 'Horror' or cc.name = 'Sci-Fi')
	and (f.rating = 'R' or f.rating = 'PG-13')
	and f.film_id not in (
		select iv.film_id
		from inventory as iv
		join rental as rt on iv.inventory_id = rt.inventory_id
	);

-- second query
select ct.city as city, s.store_id as store_id, sum(pt.amount) as total_sum
from store as s
join address as ad on ad.address_id = s.address_id
join city as ct on ct.city_id = ad.city_id
join staff as st on s.store_id = st.store_id
join payment as pt on pt.staff_id = st.staff_id
group by s.store_id, ct.city_id
having sum(pt.amount) = (
	select max(total_sum) as total_sum
	from (
	select ct.city as city, s.store_id as store_id, sum(pt.amount) as total_sum
	from store as s
	join address as ad on ad.address_id = s.address_id
	join city as ct on ct.city_id = ad.city_id
	join staff as st on s.store_id = st.store_id
	join payment as pt on pt.staff_id = st.staff_id
	group by s.store_id, ct.city_id) as i_D
	where i_D.city = ct.city
	group by i_D.city
)