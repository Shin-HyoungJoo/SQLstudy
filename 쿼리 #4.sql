SHOW TABLES;
SELECT * FROM language;
SELECT NAME nm,
'common1' AS language_usage,
floor(language_id * 3.1415927) AS lang_pi_value,
UPPER(NAME) AS language_name,
NAME + 'man',
CONCAT(NAME, 'man', 'yep') AS another_name
FROM language;

SELECT DISTINCT * FROM film_actor ORDER BY actor_id DESC;

select
	concat(cust.first_name, ' ' , cust.last_name) as full_name
FROM(
	SELECT first_name, last_name, email
	From customer
	WHERE first_name = 'JESSIE'
	)AS cust;