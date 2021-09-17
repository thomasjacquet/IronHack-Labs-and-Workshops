USE sakila;
SELECT last_name FROM customer
LIMIT 20;
SELECT create_date FROM customer;
SELECT language_id as language FROM film
LIMIT 10;
SELECT COUNT(store_id) FROM store;
SELECT * FROM store; -- The company has 2 stores
SELECT COUNT(staff_id) FROM staff; 
SELECT * FROM staff; -- The company has 2 person in its staff
SELECT COUNT(rental_date) FROM rental;
SELECT return_date FROM rental;
SELECT * FROM rental;

