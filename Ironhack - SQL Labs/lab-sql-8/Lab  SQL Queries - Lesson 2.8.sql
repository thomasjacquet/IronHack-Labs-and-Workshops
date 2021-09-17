-- Write a query to display for each store its store ID, city, and country.

SELECT s.store_id AS Store_ID, c.city AS City, co.country AS Country
FROM sakila.store s
JOIN sakila.address a
USING (address_id)
JOIN sakila.city c
USING (city_id)
RIGHT JOIN sakila.country co
USING (country_id)
WHERE(c.city) IS NOT NULL
GROUP BY store_id;

-- Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id  AS Store_ID, SUM(p.amount) AS Total_Amount
FROM sakila.store s
JOIN sakila.staff st
USING (store_id)
JOIN sakila.payment p
USING (staff_id)
GROUP BY store_id;


-- Which film categories are longest?

SELECT c.name AS Category, ROUND(AVG(f.length)) AS Film_Average_Length_in_mn
FROM sakila.category c
JOIN sakila.film_category fc
USING (category_id)
JOIN sakila.film f
USING (film_id)
GROUP by name
ORDER by AVG(f.length) DESC
LIMIT 3;

-- Display the most frequently rented movies in descending order.

SELECT COUNT(rental_id) AS Nb_of_Rentals, film.title AS Name_of_movie
FROM sakila.rental
JOIN sakila.inventory
USING (inventory_id)
JOIN sakila.film 
USING (film_id)
GROUP BY film.title
ORDER BY COUNT(rental_id) DESC
LIMIT 10;

-- List the top five genres in gross revenue in descending order.

SELECT category.name AS Genre, SUM(payment.amount) AS Total_Amount_by_Genre
FROM sakila.payment
JOIN sakila.rental
USING (rental_id)
JOIN sakila.inventory
USING (inventory_id)
JOIN sakila.film
USING (film_id)
JOIN sakila.film_category
USING (film_id)
JOIN sakila.category
USING (category_id)
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title,s.store_id
FROM sakila.store s
JOIN sakila.address a
ON a.address_id = s.address_id
JOIN sakila.film f
WHERE f.title = "Academy Dinosaur" AND store_id = 1
GROUP BY s.store_id

-- Get all pairs of actors that worked together.

SELECT DISTINCT(f3.title) AS Title_of_the_Film,CONCAT(a.first_name,' ', a.last_name, ' / ', a2.first_name,' ', a2.last_name) AS Actors FROM sakila.film_actor AS f1
JOIN sakila.film_actor AS f2
ON (f1.film_id = f2.film_id) AND (f1.actor_id <> f2.actor_id)
JOIN sakila.film AS f3
ON (f1.film_id = f3.film_id)
JOIN SAKILA.ACTOR AS a
ON a.actor_id =f1.actor_id
JOIN SAKILA.ACTOR AS a2
ON a2.actor_id =f2.actor_id
GROUP BY f1.film_id
ORDER BY f1.film_id ASC;

-- Get all pairs of customers that have rented the same film more than 3 times.

SELECT CONCAT(c.first_name,' ', c.last_name, ' / ', c2.first_name,' ', c2.last_name) AS Customers
FROM sakila.customer AS c
JOIN sakila.customer AS c2
ON c.customer_id <> c2.customer_id


-- For each film, list actor that has acted in more films.