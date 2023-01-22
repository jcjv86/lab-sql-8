-- Lab | SQL Join (Part II)


USE sakila;

/* 1
Write a query to display for each store its store ID, city, and country.
*/
SELECT store_id, c.city, co.country FROM store as s
JOIN address as a
ON (s.address_id=a.address_id)
JOIN city as c 
ON (a.city_id=c.city_id)
JOIN country as co
ON (c.country_id=co.country_id);

/* 2
Write a query to display how much business, in dollars, each store brought in.
*/
SELECT s.store_id, a.address, SUM(p.amount) as total_income FROM payment as p
JOIN staff as s
ON (p.staff_id=s.staff_id)
JOIN address as a
ON s.address_id = a.address_id
GROUP BY s.store_id, a.address;

/* 3
Which film categories are longest?
*/
-- Total duration of all categories
SELECT c.name, sum(f.length) as duration FROM film AS f
JOIN film_category AS fc
ON f.film_id  = f.film_id
JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY duration DESC;

-- Max length per category (all the same)
SELECT c.name, max(f.length) as duration FROM film AS f
JOIN film_category AS fc
ON f.film_id  = f.film_id
JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY duration DESC;

/* 4
Display the most frequently rented movies in descending order.
*/
SELECT f.title, COUNT(f.film_id) AS most_frequently_rented FROM film as f
JOIN inventory as i
ON (f.film_id= i.film_id)
JOIN rental as r
ON (i.inventory_id=r.inventory_id)
GROUP BY f.title
ORDER BY most_frequently_rented DESC;

/* 5
List the top five genres in gross revenue in descending order.
*/
SELECT cat.name AS top_5_genres, SUM(p.amount) AS gross_revenue FROM category as cat
JOIN film_category as fc 
ON (cat.category_id=fc.category_id)
JOIN inventory as i
ON (fc.film_id=i.film_id)
JOIN rental as r
ON (i.inventory_id=r.inventory_id)
JOIN payment as p
ON (r.rental_id=p.rental_id)
GROUP BY cat.name
ORDER BY sum(p.amount) DESC
LIMIT 5;

/* 6
Is "Academy Dinosaur" available for rent from Store 1?
*/
SELECT f.film_id, f.title, s.store_id, i.inventory_id FROM inventory AS i
JOIN store AS s
ON i.store_id = s.store_id
JOIN film AS f
ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;

/* 7
Get all pairs of actors that worked together.
*/



/* 8
Get all pairs of customers that have rented the same film more than 3 times.
*/
SELECT c1.customer_id, c2.customer_id, COUNT(*) AS num_films FROM customer AS c1
INNER JOIN rental AS r1
ON r1.customer_id = c1.customer_id
INNER JOIN inventory AS i1
ON r1.inventory_id = i1.inventory_id
INNER JOIN film AS f1
ON i1.film_id = f1.film_id
INNER JOIN inventory AS i2
ON i2.film_id = f1.film_id
INNER JOIN rental AS r2
ON r2.inventory_id = i2.inventory_id
INNER JOIN customer AS c2
ON r2.customer_id = c2.customer_id
WHERE c1.customer_id <> c2.customer_id
GROUP BY c1.customer_id , c2.customer_id
HAVING COUNT(*) > 3
ORDER BY num_films DESC;


/* 9
For each film, list actor that has acted in more films.
*/


