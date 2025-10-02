-- 1
SELECT rating, COUNT(*) AS pocet
FROM film
GROUP BY rating

-- 5
SELECT YEAR(payment_date) AS rok, MONTH(payment_date) AS mesic, SUM(amount) AS soucet
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY rok, mesic

-- 6
SELECT store_id, COUNT(*)
FROM inventory
GROUP BY store_id
HAVING COUNT(*) > 2300

-- 9
SELECT rating
FROM film
WHERE length < 50
GROUP BY rating
HAVING SUM(length) > 250
ORDER BY rating DESC

-- 10
SELECT language_id, COUNT(*) AS pocet
FROM film
GROUP BY language_id

-- 11
SELECT language.name, COUNT(*) AS pocet
FROM
	film
	JOIN language ON film.language_id = language.language_id
GROUP BY language.name

-- 12
SELECT language.name, COUNT(film.film_id) AS pocet
FROM
	language
	LEFT JOIN film ON film.language_id = language.language_id
GROUP BY language.name

-- 13
SELECT
	customer.customer_id, customer.first_name, customer.last_name,
	COUNT(rental.rental_id) AS pocet
FROM
	customer
	LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name

-- 15
SELECT actor.actor_id, actor.first_name, actor.last_name,
	COUNT(film_actor.film_id) AS pocet
FROM
	actor
	JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
HAVING COUNT(film_actor.film_id) > 20

-- 16
SELECT customer.customer_id, customer.first_name, customer.last_name,
	ISNULL(SUM(payment.amount), 0) AS celkem,
	MIN(payment.amount) AS nejmene,
	MAX(payment.amount) AS nejvice,
	AVG(payment.amount) AS prumer
FROM 
	customer
	LEFT JOIN rental ON customer.customer_id = rental.customer_id
	LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY
	customer.customer_id, customer.first_name, customer.last_name

-- 20
SELECT address.address, city.city, country.country
FROM
	customer
	JOIN address ON customer.address_id = address.address_id
	JOIN city ON address.city_id = city.city_id
	JOIN country ON city.country_id = country.country_id
	LEFT JOIN rental ON customer.customer_id = rental.customer_id
	LEFT JOIN inventory ON rental.inventory_id = inventory.inventory_id
	LEFT JOIN film_actor ON inventory.film_id = film_actor.film_id
GROUP BY address.address, city.city, country.country
HAVING COUNT (DISTINCT film_actor.actor_id) < 40	

-- 23
SELECT language.name, COUNT(film.film_id) AS pocet
FROM
	language
	LEFT JOIN film ON 
		film.language_id = language.language_id AND film.length > 350
GROUP BY language.name