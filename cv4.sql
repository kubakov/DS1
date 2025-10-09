-- 1
SELECT film.film_id, film.title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	WHERE film_actor.actor_id = 1
)

SELECT film.film_id, film.title
FROM film
WHERE EXISTS (
	SELECT *
	FROM film_actor
	WHERE film_actor.film_id = film.film_id AND film_actor.actor_id = 1
)

-- 2
SELECT film_id
FROM film_actor
WHERE film_actor.actor_id = 1

-- 3
SELECT film_id, title
FROM film
WHERE
	film_id IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 1
	)
	AND film_id IN (
		SELECT film_id
		FROM film_actor
		WHERE actor_id = 10
	)

-- 4
SELECT film_id, title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	WHERE actor_id = 1 OR actor_id = 10
)

-- 5
SELECT film_id, title
FROM film
WHERE film_id NOT IN (
	SELECT film_id
	FROM film_actor
	WHERE actor_id = 1
)

-- 7 (testy)
SELECT film_id, title
FROM film
WHERE
	film_id IN (
		SELECT film_id
		FROM film_actor
		JOIN actor ON film_actor.actor_id = actor.actor_id
		WHERE actor.first_name = 'PENELOPE' AND actor.last_name = 'GUINESS'
	
	)
	AND film_id IN (
		SELECT film_id
		FROM film_actor
		JOIN actor ON film_actor.actor_id = actor.actor_id
		WHERE actor.first_name = 'CHRISTIAN' AND actor.last_name = 'GABLE'
	)

-- 12
SELECT f1.film_id, f1.title
FROM film f1
WHERE EXISTS (
	SELECT *
	FROM film f2
	WHERE f1.length = f2.length AND f1.film_id != f2.film_id
)

-- 13
SELECT title
FROM film
WHERE length < ANY (
	SELECT film.length
	FROM
		film
		JOIN film_actor ON film.film_id = film_actor.film_id
		JOIN actor ON film_actor.actor_id = actor.actor_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY'
)

SELECT title
FROM film f1
WHERE
	EXISTS (
		SELECT *
		FROM
			film f2
			JOIN film_actor ON f2.film_id = film_actor.film_id
			JOIN actor ON film_actor.actor_id = actor.actor_id
		WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY' AND f1.length < f2.length
	)


--  13 (kratsi nez vsechny filmy)
SELECT title
FROM film
WHERE length < ALL (
	SELECT film.length
	FROM
		film
		JOIN film_actor ON film.film_id = film_actor.film_id
		JOIN actor ON film_actor.actor_id = actor.actor_id
	WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY'
)

SELECT title
FROM film f1
WHERE
	NOT EXISTS (
		SELECT *
		FROM
			film f2
			JOIN film_actor ON f2.film_id = film_actor.film_id
			JOIN actor ON film_actor.actor_id = actor.actor_id
		WHERE actor.first_name = 'BURT' AND actor.last_name = 'POSEY' AND f1.length >= f2.length
	)

-- 15
SELECT DISTINCT f1.film_id, f1.title
FROM
	rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON f1.film_id = i1.film_id
WHERE
	EXISTS(
		SELECT *
		FROM
			rental r2
			JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
		WHERE i1.film_id = i2.film_id AND r1.rental_id != r2.rental_id
	)

-- 16
SELECT DISTINCT f1.film_id, f1.title
FROM
	rental r1
	JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
	JOIN film f1 ON f1.film_id = i1.film_id
WHERE
	EXISTS(
		SELECT *
		FROM
			rental r2
			JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
		WHERE i1.film_id = i2.film_id AND r1.customer_id != r2.customer_id
	)

-- 20 (testy)
SELECT *
FROM actor
WHERE
	NOT EXISTS(
		SELECT *
		FROM
			film_actor
			JOIN film ON film_actor.film_id = film.film_id
		WHERE actor.actor_id = film_actor.actor_id AND film.length >= 180
	)
	AND actor_id IN (SELECT actor_id FROM film_actor)