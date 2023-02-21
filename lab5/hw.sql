-- 7
select max(res.counter) as max_enrollment
from (
	select w.s_sec_id, count(w.t_sec_id) as counter
	from (
		select s.sec_id as s_sec_id, takes.sec_id as t_sec_id, takes.year as year, 
		takes.semester as semester
		from (
			select distinct sec_id
			from section
		) as s left join takes
			on s.sec_id = takes.sec_id
	) as w
	where w.semester = 'Fall' and w.year = 2022
	group by w.s_sec_id
) as res;


-- 6
select w.s_sec_id, count(w.t_sec_id) as counter
from (
	select s.sec_id as s_sec_id, takes.sec_id as t_sec_id, takes.year as year, 
	takes.semester as semester
	from (
    	select distinct sec_id
    	from section
  	) as s left join takes
		on s.sec_id = takes.sec_id
) as w
where w.semester = 'Fall' and w.year = 2022
group by w.s_sec_id;


-- 5
select name
from instructor
where dept_name = 'Biology';


-- 4
select *
from course
where course_id like 'CS-1%';


-- 3 (a)
select (
	select min(cnt)
	from (
		select count(takes.sec_id) as cnt
		from (
			select distinct sec_id
			from section
		) as s left join takes
			on s.sec_id = takes.sec_id
		group by s.sec_id
	) as w
) as min_enrollment, (
	select max(cnt)
	from (
		select count(takes.sec_id) as cnt
		from (
			select distinct sec_id
			from section
		) as s left join takes
			on s.sec_id = takes.sec_id
		group by s.sec_id
	) as w
) as max_enrollment;


-- 3 (b)
select min(cnt) as min_enrollment, max(cnt) as max_enrollment
from (
	select count(takes.sec_id) as cnt
	from (
		select distinct sec_id
		from section
	) as s left join takes
		on s.sec_id = takes.sec_id
	group by s.sec_id
) as w;


-- 2
select *
from (
	select sec_id, count(*) as cnt
	from takes
	group by sec_id
) as wow
where cnt = (
	select max(cnt)
	from (
		select count(*) as cnt, sec_id
		from takes
		group by sec_id
	) as wow
);


-- 1
select min(cnt) as min_enrollment, max(cnt) as max_enrollment
from (
		select count(*) as cnt, sec_id
		from takes
		group by sec_id
	) as wow;