-- 1
SELECT email
FROM customer
WHERE active = 0

-- 2
SELECT title, description
FROM film
WHERE rating = 'G'
ORDER BY title DESC

-- 3
SELECT *
FROM payment
WHERE payment_date >= '2006-01-01' AND amount < 2
--WHERE YEAR(payment_date) >= 2006 AND amount < 2

-- 4
SELECT description
FROM film
WHERE rating = 'G' OR rating = 'PG'

-- 5
SELECT description
FROM film
--WHERE rating = 'G' OR rating = 'PG' OR rating = 'PG-13'
WHERE rating IN ('G', 'PG', 'PG-13')

-- 6
SELECT description
FROM film
WHERE rating NOT IN ('G', 'PG', 'PG-13')

-- 7
SELECT *
FROM film
WHERE length > 50 AND (rental_duration = 3 OR rental_duration = 5)

-- 8
SELECT title
FROM film
WHERE (title LIKE '%RAINBOW%' OR title LIKE 'TEXAS%') AND length > 70

-- 9
SELECT title
FROM film
WHERE description LIKE '%And%' AND length BETWEEN 80 AND 90 AND rental_duration % 2 = 1

-- 10
SELECT DISTINCT special_features
FROM film
WHERE replacement_cost BETWEEN 14 AND 16
ORDER BY special_features

-- 12
SELECT *
FROM address
WHERE postal_code IS NOT NULL

-- 13
SELECT DISTINCT customer_id
FROM rental
WHERE return_date IS NULL

-- 14
SELECT
	payment_id, YEAR(payment_date) AS rok,
	MONTH(payment_date) AS mesic, DAY(payment_date) AS den
FROM payment

-- 21
SELECT COUNT(*) AS pocet_filmu
FROM film

-- 22
SELECT COUNT(DISTINCT rating)
from film

-- 23
SELECT
	COUNT(*) AS pocet_vsech,
	COUNT(postal_code) AS pocet_adres_s_psc,
	COUNT(DISTINCT postal_code) AS pocet_ruznych_psc
from address

-- 24
SELECT
	SUM(length) AS soucet,
	MIN(length) AS minimum,
	MAX(length) AS maximum,
	AVG(length) AS prumer
FROM film