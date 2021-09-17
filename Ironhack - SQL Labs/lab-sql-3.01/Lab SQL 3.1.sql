USE sakila2;
-- Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE (first_name='TAMMY') AND (last_name= 'SANDERS');

INSERT INTO staff(staff_id, first_name, last_name, address_id, email, store_id, active,username, password,last_update)
VALUES
(3,'TAMMY','SANDERS',79,'tammy.sanders@sakilastaff.com',2,1,'Tammy','newpassword','2006-02-15 03:57:16');

SELECT * FROM staff;

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:

INSERT INTO rental(rental_date, inventory_id, customer_id, return_date, staff_id,last_update)
VALUES
('2005-05-26 06:52:36', 1, 130, '2005-06-09 01:19:28', 1, '2006-02-15 21:30:53');

SELECT * FROM sakila2.film f
JOIN sakila2.inventory
USING (film_id)
JOIN sakila2.rental r
USING (inventory_id)
WHERE r.inventory_id = 1 AND customer_id = 130;


