USE sakila2;

-- How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT COUNT(inventory_id) FROM inventory
WHERE film_id IN (
	SELECT film_id FROM (
    FROM title, film_id
    FROM film
    WHERE title = 'Hunchback Impossible') sub1
);

SELECT COUNT(film_id) AS tot_H
FROM inventory
WHERE film_id ='439';
-- List all films whose length is longer than the average of all the films.

SELECT title AS Movie , length AS Duration_in_mn
FROM film
WHERE length > (SELECT AVG(length)
FROM film);

-- Use subqueries to display all actors who appear in the film Alone Trip.

    SELECT title AS Movie, film_id as Film_ID, COUNT(DISTINCT actor_id) AS Nb_of_actors_casted FROM sakila2.film_actor
    JOIN film
    USING (film_id)
WHERE film_id IN (
	SELECT film_id 
    FROM (
		SELECT film_id, title 
		FROM sakila2.film
		WHERE title = 'Alone Trip')
    sub1
);

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT title AS List_of_Family_Movies FROM film
JOIN film_category
USING (film_id)
JOIN category c
USING (category_id)
WHERE name = 'Family';

-- Get name and email from customers from Canada using subqueries. 
-- Do the same with joins. Note that to create a join, you will have to identify the correct tables 
-- with their primary keys and foreign keys, that will help you get the relevant information.

SELECT CONCAT(first_name,' ', last_name) AS Customer, email AS Email_Address, country AS Country FROM customer
JOIN address
USING (address_id)
JOIN city
USING (city_id)
JOIN country
USING (country_id)
WHERE country = 'Canada';

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

-- Most prolific actor
SELECT CONCAT(first_name,' ', last_name) AS Actor, COUNT(title) AS Nb_of_movies_played FROM actor 
JOIN film_actor
USING (actor_id)
JOIN film
USING (film_id)
GROUP BY Actor 
ORDER BY COUNT(title) DESC
LIMIT 1;

SELECT CONCAT(first_name,' ', last_name) AS Most_prolific_Actor_or_Actress, title Movies_played FROM film
JOIN film_actor
USING (film_id)
JOIN actor
USING (actor_id)
WHERE CONCAT(first_name,' ', last_name) =
(SELECT CONCAT(first_name,' ', last_name) AS Actor FROM actor
JOIN film_actor
USING (actor_id)
JOIN film
USING (film_id)
GROUP BY Actor 
ORDER BY COUNT(title) DESC
LIMIT 1);

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer 
-- if the customer that has made the largest sum of payments.

-- Most profitable customer
SELECT CONCAT(first_name,' ', last_name) AS Customer , SUM(amount) AS Total_paid FROM customer
JOIN payment
USING (customer_id)
GROUP BY Customer
ORDER BY Total_paid DESC
LIMIT 1;

SELECT CONCAT(c.first_name,' ', c.last_name) AS Customer, title AS Movies_Rented FROM film
JOIN inventory
USING (film_id)
JOIN rental
USING (inventory_id)
JOIN payment p
USING (rental_id)
JOIN customer c
ON p.customer_id = c.customer_id
WHERE CONCAT(c.first_name,' ', c.last_name) =
(SELECT CONCAT(c2.first_name,' ', c2.last_name) AS Customer FROM customer c2
JOIN payment
USING (customer_id)
GROUP BY Customer
ORDER BY SUM(amount) DESC
LIMIT 1);

-- Customers who spent more than the average payments.

-- Average payment
SELECT AVG(amount) FROM payment;

SELECT CONCAT(first_name,' ', last_name) AS Customer, amount AS Amount_per_customer FROM customer
JOIN payment
USING (customer_id)
WHERE amount > (SELECT AVG(amount) FROM payment)
GROUP BY Customer;

