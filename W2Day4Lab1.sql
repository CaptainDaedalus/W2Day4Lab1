/*
1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
2. Display the total amount rung up by each staff member in August of 2005.
3. Which actor has appeared in the most films?
4. Most active customer (the customer that has rented the most number of films)
5. Display the first and last names, as well as the address, of each staff member.
6. List each film and the number of actors who are listed for that film.
7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
8. List number of films per category.
*/
use sakila;
-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
select * from film_category;
select * from category;

select cat.name, count(film_id) as "number_of_movies"

from sakila.category as cat
join sakila.film_category as f

on cat.category_id = f.category_id

group by cat.name
order by "number_of_movies" DESC;


-- 2. Display the total amount rung up by each staff member in August of 2005.
select * from staff;
select * from payment;

SELECT s.staff_id, sum(p.amount) as "Total amount"
	FROM sakila.staff as s
    JOIN sakila.payment p
    ON s.staff_id = p.staff_id
    WHERE left(p.payment_date, 7) = "2005-08"
    GROUP BY s.staff_id;
    
-- 3. Which actor has appeared in the most films?
select * from actor;
select * from film_actor;

select a.last_name as "Name of Actor", count(f.film_id) as "film amount"
	FROM sakila.actor as a
    JOIN sakila.film_actor f
    ON a.actor_id = f.actor_id
	GROUP BY a.last_name;
    
-- 4. Most active customer (the customer that has rented the most number of films) --> SMITH, rented 32 films
select * from customer;
select * from rental;


select c.last_name as "Name of Customer", 
count(r.customer_id) as "Number of Rentals"
	FROM sakila.customer as c
    JOIN sakila.rental r
    ON c.customer_id = r.customer_id
	GROUP BY c.last_name
    order by r. customer_id ASC;
    
-- 5. Display the first and last names, as well as the address, of each staff member.
select * from address;
select * from staff;

select concat(s.first_name, " ", s.last_name) as Name_of_Staff, 
a.address as Address_of_Staff
	FROM sakila.staff as s
    JOIN sakila.address as a
    ON s.address_id = a.address_id;
    
-- GROUP BY Name_of_Staff; (not necessary cuz columns of new list created after select)
-- order by a.address; (not necessary cuz columns of new list created after select)
    
-- 6. List each film and the number of actors who are listed for that film.
select * from film;
select * from film_actor;

select f.title as "Film Title", count(fa.actor_id) as "Number of Actors"

FROM sakila.film as f
    JOIN sakila.film_actor as fa
    ON f.film_id = fa.film_id
    
	GROUP BY f.title
    order by fa.actor_id ASC;
    
/*
7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers 
  alphabetically by last name.
*/
select * from customer;
select * from payment;

select c.last_name as "Customer Name", sum(p.amount) as "Total Paid"

FROM sakila.customer as c
    JOIN sakila.payment as p
    ON c.customer_id = p.customer_id
    group by p.amount
    order by c.last_name ASC;
    
-- 8. List number of films per category.
select * from category;
select * from film_category;

select c.name as "Name of Category", count(fc.film_id) as "Number of Films"

FROM sakila.film_category as fc
    JOIN sakila.category as c
    ON fc.category_id = c.category_id
    
    group by c.name
    order by fc.film_id ASC;  -- > ascending doesn't seem to work again
    
    