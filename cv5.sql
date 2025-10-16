-- 1
SELECT
	film.film_id, film.title,
	(SELECT COUNT(*) FROM film_actor WHERE film_actor.film_id = film.film_id) AS pocet_hercu,
	(SELECT COUNT(*) FROM film_category WHERE film_category.film_id = film.film_id) AS pocet_kategorii
FROM film

-- 4
SELECT
	film.film_id, film.title,
	(
		SELECT COUNT(*)
		FROM film_actor
		WHERE film_actor.film_id = film.film_id
	) AS pocet_hercu,
	(
		SELECT COUNT(DISTINCT rental.customer_id)
		FROM
			rental
			JOIN inventory ON inventory.inventory_id = rental.inventory_id
		WHERE MONTH(rental.rental_date) = 8 and film.film_id = inventory.film_id
	) AS pocet_pujcek,
	(
		SELECT AVG(payment.amount)
		FROM
			inventory
			JOIN rental ON inventory.inventory_id = rental.inventory_id
			JOIN payment ON rental.rental_id = payment.rental_id
		WHERE inventory.film_id = film.film_id
	) AS prumerna_castka
FROM film

-- 6
SELECT customer_id, first_name, last_name
FROM customer
WHERE
	(
		SELECT COUNT(*)
		FROM payment
		WHERE payment.customer_id = customer.customer_id AND amount > 4
	)
	>
	(
		SELECT COUNT(*)
		FROM payment
		WHERE payment.customer_id = customer.customer_id AND amount < 4
	)

-- 11
SELECT
	customer.customer_id, customer.first_name, customer.last_name,
	(
		SELECT COUNT(*)
		FROM rental
		WHERE rental.customer_id = customer.customer_id
	) AS pocet_vyp
FROM customer
WHERE NOT EXISTS (
	SELECT *
	FROM
		rental
		JOIN inventory ON rental.inventory_id = inventory.inventory_id
		JOIN film ON inventory.film_id = film.film_id
		JOIN language ON film.language_id = language.language_id
	WHERE rental.customer_id = customer.customer_id AND language.name != 'english'
)
AND customer_id IN (SELECT customer_id FROM rental)

-- 13
SELECT film.film_id, film.title
FROM film
WHERE length = (SELECT MAX(length) FROM film)
--WHERE length >= ALL (SELECT length FROM film)

-- 14
SELECT f1.rating, f1.film_id, f1.title, f1.length
FROM film f1
WHERE length = (SELECT MAX(length) FROM film f2 WHERE f1.rating = f2.rating)

-- 16
SELECT
	a1.actor_id, a1.first_name, a1.last_name, f1.film_id, f1.title, f1.length
FROM
	actor a1
	JOIN film_actor fa1 ON fa1.actor_id = a1.actor_id
	JOIN film f1 ON f1.film_id = fa1.film_id
WHERE f1.length = (
	SELECT
		MAX(f2.length)
	FROM
		actor a2
		JOIN film_actor fa2 ON fa2.actor_id = a2.actor_id
		JOIN film f2 ON f2.film_id = fa2.film_id
	WHERE a1.actor_id = a2.actor_id
)

WITH T AS
(
	SELECT
		actor.actor_id, actor.first_name, actor.last_name, film.film_id, film.title, film.length
	FROM
		actor
		JOIN film_actor ON film_actor.actor_id = actor.actor_id
		JOIN film ON film.film_id = film_actor.film_id
)
SELECT *
FROM T t1
WHERE t1.length = (SELECT MAX(length) FROM T t2 WHERE t1.actor_id = t2.actor_id)

-- 25
WITH T AS(
	SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS pocet_vyp
	FROM
		customer
		LEFT JOIN rental ON rental.customer_id = customer.customer_id
	GROUP BY customer.customer_id, customer.first_name, customer.last_name
)
SELECT *
FROM T
WHERE pocet_vyp = (SELECT MAX(pocet_vyp) FROM T)

-- 28
WITH T AS(
	SELECT
		film.film_id, film.title, COUNT(rental.rental_id) AS pocet
	FROM
		film
		LEFT JOIN inventory ON film.film_id = inventory.film_id
		LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
	GROUP BY film.film_id, film.title
)
SELECT *
FROM T
WHERE pocet > (SELECT AVG(pocet) FROM T)