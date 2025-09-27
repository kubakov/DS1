-- 1
SELECT *
FROM
	city
	JOIN country ON city.country_id = country.country_id

-- 2
SELECT film.title, language.name
FROM
	film
	JOIN language ON film.language_id = language.language_id

-- 5
SELECT
	customer.first_name, customer.last_name,
	address.address, city.city
FROM
	customer
	JOIN address ON customer.address_id = address.address_id
	JOIN city ON address.city_id = city.city_id

-- 6
SELECT
	customer.first_name, customer.last_name, city.city
FROM
	customer
	JOIN address ON customer.address_id = address.address_id
	JOIN city ON address.city_id = city.city_id

-- 8
SELECT
	film.film_id, film.title, actor.first_name, actor.last_name
FROM
	film
	JOIN film_actor ON film.film_id = film_actor.film_id
	JOIN actor ON film_actor.actor_id = actor.actor_id
ORDER BY film.film_id

-- 9
SELECT
	actor.actor_id, actor.first_name, actor.last_name, film.film_id, film.title
FROM
	film
	JOIN film_actor ON film.film_id = film_actor.film_id
	JOIN actor ON film_actor.actor_id = actor.actor_id
ORDER BY actor.actor_id

-- 10
SELECT
	film.title
FROM
	film
	JOIN film_category ON film.film_id = film_category.film_id
	JOIN category ON film_category.category_id = category.category_id
WHERE
	category.name = 'Horror'

-- 11
SELECT 
	store.store_id, staff.first_name, staff.last_name,
	store_addr.address AS store_address, staff_addr.address AS staff_address
FROM
	store
	JOIN staff ON store.manager_staff_id = staff.staff_id
	JOIN address store_addr ON store.address_id = store_addr.address_id
	JOIN address staff_addr ON staff.address_id = staff_addr.address_id

-- 12
SELECT
	film.film_id, film.title,
	film_actor.actor_id, film_category.category_id
FROM
	film
	JOIN film_actor ON film.film_id = film_actor.film_id
	JOIN film_category ON film.film_id = film_category.film_id
ORDER BY film.film_id

-- 13
SELECT DISTINCT
	film_actor.actor_id, film_category.category_id
FROM
	film
	JOIN film_actor ON film.film_id = film_actor.film_id
	JOIN film_category ON film.film_id = film_category.film_id
ORDER BY film_actor.actor_id

-- 14
SELECT DISTINCT
	film.film_id, film.title
FROM
	inventory
	JOIN film ON inventory.film_id = film.film_id

-- 19
SELECT
	language.language_id, language.name AS lang_name, film.film_id, film.title
FROM
	language
	LEFT JOIN film ON language.language_id = film.language_id

-- 20
SELECT 
	film.film_id, film.title,
	language.name AS lang_name,
	orig_lang.name AS orig_lang_name
FROM
	film
	JOIN language ON film.language_id = language.language_id
	LEFT JOIN language orig_lang ON film.original_language_id = orig_lang.language_id

-- 23
SELECT DISTINCT customer.first_name, customer.last_name
FROM
	customer
	JOIN rental ON customer.customer_id = rental.customer_id
	LEFT JOIN payment ON rental.rental_id = payment.rental_id
WHERE payment.payment_id IS NULL

-- 24
SELECT
	film.title, language.name
FROM
	film
	LEFT JOIN language ON
		film.language_id = language.language_id AND
		language.name LIKE 'I%'