SELECT customer_id, COUNT(1) FROM rental
GROUP BY customer_id
ORDER BY COUNT(1) DESC;

-- limit(1), limit(1, 1)

SELECT * FROM rental
ORDER BY rental_id desc
LIMIT 2, 2;

-- join 이용하여 사용자 이름 찍기.
SELECT A.first_name, A.last_name, B.customer_id, COUNT(1) cnt
FROM rental B
INNER JOIN customer A
ON A.customer_id = B.customer_id
GROUP BY customer_id
ORDER BY COUNT(1) DESC
LIMIT 1;

-- 가장 적게 빌린 사람의 pk, 이름, 빌린 수
SELECT B.customer_id, A.first_name, A.last_name, COUNT(1) cnt
FROM rental B
INNER JOIN customer A
ON A.customer_id = B.customer_id
GROUP BY customer_id
ORDER BY COUNT(1)
LIMIT 1;

SELECT A.first_name, A.last_name, B.customer_id, COUNT(1) cnt
FROM rental B
INNER JOIN customer A
ON A.customer_id = B.customer_id
GROUP BY customer_id
ORDER BY COUNT(1) DESC
LIMIT 1;

-- 렌탈횟수가 40회 이상인 사람들 pk, 이름, 성, 렌탈수
SELECT A.first_name, A.last_name, B.customer_id, COUNT(1) cnt
FROM rental B
INNER JOIN customer A
ON A.customer_id = B.customer_id
GROUP BY customer_id
HAVING cnt >= 40
ORDER BY cnt;


SELECT customer_id, MAX(amount), MIN(amount), AVG(amount), SUM(amount) / COUNT(amount)
FROM payment
GROUP BY customer_id;

SELECT COUNT(customer_id), 
COUNT(DISTINCT customer_id)
FROM payment;

SELECT * 
FROM rental
WHERE return_date IS NULL;

SELECT COUNT(*), COUNT(return_date), COUNT(1)
FROM rental
WHERE return_date IS NULL;

SELECT max(DATEDIFF(return_date, rental_date))
FROM rental;


-- 제일 늦게 반납한 사람 정보
SELECT B.customer_id, B.first_name, B.last_name
FROM(
	SELECT DISTINCT customer_id
	FROM rental
	WHERE DATEDIFF(return_date, rental_date) = 
	(
		SELECT max(DATEDIFF(return_date, rental_date))
		FROM rental
	)
)A
INNER JOIN customer B
ON A.customer_id = B.customer_id
ORDER BY B.customer_id;


-- 배우의 등급별 출연횟수
SELECT A.actor_id, B.rating, COUNT(1) cnt
FROM film_actor A
INNER JOIN film B
ON A.film_id = B.film_id
GROUP BY A.actor_id, B.rating
ORDER BY A.actor_id;

-- 배우의 카테고리별 출연횟수

SELECT D.actor_id, B.category_id, COUNT(1) cnt
FROM category A
INNER JOIN film_category B
ON A.category_id = B.category_id
INNER JOIN film_actor C
ON C.film_id = B.film_id
INNER JOIN actor D
ON D.actor_id = C.actor_id
GROUP BY D.actor_id, B.category_id;

SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM rental;
SELECT * FROM payment;


-- 연도별 렌탈 횟수 궁금쓰...
SELECT concat(CAST(YEAR(rental_date) AS CHAR), '년') `YEAR`,
		 COUNT(1) AS rental_number
FROM rental
GROUP BY YEAR;


-- 롤업생성
SELECT fa.actor_id, f.rating, COUNT(1)
FROM film_actor fa
INNER JOIN film f
ON fa.film_id = f.film_id 
GROUP BY fa.actor_id, f.rating with ROLLUP;


-- 배우의 등급('G', 'PG')별 출연횟수 궁금함,
-- 출연횟수가 9초과인 actor_id 궁금쓰.
SELECT B.actor_id, A.rating, COUNT(1) cnt
FROM film A
INNER JOIN film_actor B
ON A.film_id = B.film_id
GROUP BY B.actor_id, A.rating
HAVING A.rating IN ('G','PG') AND cnt > 9
ORDER BY cnt;


-- 8-1
SELECT COUNT(*) FROM payment;

-- 8-2
SELECT customer_id, SUM(amount), COUNT(*) 
FROM payment
GROUP BY customer_id;

-- 8-3
SELECT customer_id, SUM(amount), COUNT(*) cnt 
FROM payment
GROUP BY customer_id
HAVING cnt >= 40
ORDER BY customer_id;

