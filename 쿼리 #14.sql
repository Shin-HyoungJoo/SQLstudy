-- 5/15

-- 가장 나중에 가입한 고객의 pk, 이름, 성 출력하시오.
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id = ( 
	SELECT MAX(customer_id)
	FROM customer
);


-- 도시id, 도시명 > India(인도) 
-- 나라가 아닌 나라들의 도시id, 도시명
SELECT city_id, city
FROM city
WHERE country_id <> (
	SELECT country_id FROM country
	WHERE country = 'India'
);


-- Canada, Mexico의 도시id, 도시명을 출력.
SELECT A.city_id, A.city	-- Join
FROM city A
INNER JOIN country B
ON A.country_id = B.country_id
WHERE country IN ('Canada', 'Mexico');

SELECT city_id, city		-- Subquery
FROM city
WHERE country_id in (
	SELECT country_id FROM country
	WHERE country IN ('Canada', 'Mexico')
);


-- all 연산자
SELECT *
FROM customer
WHERE customer_id != ALL(
	SELECT customer_id
	FROM payment
	WHERE amount = 0
);


-- United States, Mexico, Canada에 거주하는 소비자의
-- 렌탈횟수보다 많이 렌탈한 사람들의 고객id, 횟수
SELECT customer_id, COUNT(customer_id)
FROM rental
GROUP BY customer_id
having COUNT(customer_id) > all(
	SELECT COUNT(customer_id) FROM rental
	WHERE customer_id IN (
		SELECT customer_id FROM customer
		WHERE address_id IN
		(
			SELECT address_id FROM address
			WHERE city_id IN(
				SELECT city_id
				FROM city
				WHERE country_id IN (
					SELECT country_id
					FROM country
					WHERE country IN('United States', 'Mexico', 'Canada')
				)
			)
		)
	)
	GROUP BY customer_id
);
	

-- 배우 성이 'MONROE'인 사람이 PG영화등급에 출연했다.
-- 배우id, 영화id가 궁금.
SELECT A.actor_id, C.film_id
FROM actor A
INNER JOIN film_actor B
ON A.actor_id = B.actor_id
INNER JOIN film C
ON C.film_id = B.film_id
WHERE last_name = 'MONROE' AND C.rating = 'PG';

SELECT * FROM actor
WHERE (first_name, last_name) IN
	(
		select first_name, last_name
		FROM actor
		WHERE last_name = 'MONROE'
	);
	

-- case문
SELECT customer_id, active,
	case
		when active = 1
		then '활성화'
		ELSE '비활성화'
	END active_str, 
	if(active = 1, '활성화', '비활성화') active_str2
FROM customer;


-- PG, G 전체이용, NC-17 17세 이상, PG-13 13세 이상,
-- R은 청소년 관람불가
SELECT *,
	case when rating IN ('PG', 'G') then '전체 이용'
		  when rating = 'NC-17' then '17세 이상'
		  when rating = 'PG-13' then '13세 이상'
		  ELSE '청소년 관람불가'
	end raing_str
FROM film;

-- first_name / last_name / num_rentals (active = 0 > 0)
SELECT B.first_name, B.last_name,
 	case when B.active = 1 then COUNT(*)
 		ELSE 0
 	END num_rentals
FROM rental A 
INNER JOIN customer B
ON A.customer_id = B.customer_id
GROUP BY B.first_name, B.last_name;


-- rental테이블에서 2005-05 ~ 08월 각 달의 렌탈 수
SELECT month(rental_date), COUNT(*) 
FROM rental
WHERE month(rental_date) IN (05,06,07,08)
AND year(rental_date) = 2005
GROUP BY month(rental_date);

SELECT date_format(rental_date, '%Y-%m') mon, COUNT(*) cnt
FROM rental
WHERE month(rental_date) BETWEEN 5 AND 8
AND year(rental_date) = 2005
GROUP BY month(rental_date);

SELECT
 SUM(
 	case month(rental_date) when 5 then 1 ELSE 0 end
 ) `2005-05` ,
 SUM(
 	case month(rental_date) when 6 then 1 ELSE 0 end
 ) `2005-06` ,
 SUM(
 	case month(rental_date) when 7 then 1 ELSE 0 end
 ) `2005-07`
 
FROM rental
WHERE month(rental_date) BETWEEN 5 AND 8
AND year(rental_date) = 2005;

