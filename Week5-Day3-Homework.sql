
-- 1. List all customers who live in Texas (use JOINs)

select c.first_name, c.last_name, a.district
from customer c 
join address a 
on c.address_id = a.address_id 
where a.district = 'Texas';



-- 2. List all payments of more than $7.00 with the customer’s first and last name

select c.first_name, c.last_name, p.amount
from customer c 
join payment p 
on c.customer_id = p.customer_id 
where p.amount > 7;



-- 3. Show all customer names who have made over $175 in payments (use subqueries)

select c.customer_id, c.first_name, c.last_name
from customer c
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
);


-- 4. List all customers that live in Argentina (use the city table)

select c.first_name, c.last_name, a.district, ci.city, co.country
from customer c 
join address a 
on c.address_id = a.address_id
join city ci
on a.city_id = ci.city_id 
join country co 
on ci.country_id = co.country_id 
where co.country = 'Argentina';


select *
from city;



-- 5. Show all the film categories with their count in descending order

select fc.category_id, c.name, count(fc.category_id)
from film_category fc
join category c 
on fc.category_id = c.category_id 
group by fc.category_id, c.name 
order by count(fc.category_id) desc;



--6. What film had the most actors in it (show film info)?
select f.film_id, f.title, count(fa.actor_id)
from film f 
join film_actor fa 
on f.film_id = fa.film_id 
join actor a 
on fa.actor_id = a.actor_id 
group by f.film_id 
order by count(fa.actor_id) desc
limit 1;


--7. Which actor has been in the least movies?
select a.actor_id, a.first_name, a.last_name, count(fa.film_id)
from actor a
join film_actor fa 
on a.actor_id  = fa.actor_id 
group by a.actor_id 
order by count(fa.film_id)
limit 1;

--8. Which country has the most cities?
select c.country, count(ci.city) as num_cities
from country c 
join city ci 
on c.country_id = ci.country_id 
group by c.country
order by num_cities desc
limit 1;



--9. List the actors who have been in between 20 and 25 films.

select a.actor_id, a.first_name, a.last_name, count(fa.film_id)
from actor a 
join film_actor fa 
on a.actor_id = fa.actor_id
group by a.actor_id
having count(fa.film_id) between 20 and 25
order by actor_id 
;
