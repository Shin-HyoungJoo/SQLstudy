SELECT title
FROM film
WHERE rating = 'G' AND rental_duration >= 7;
-- 등급이 'G'면서 빌릴 수 있는 기간이 7일 이상인 레코드
-- SELECT from where group having order limit

-- 등급이 'G'면서 빌릴 수 있는 기간이 7일 이상인 레코드
-- 혹은 등급이 'PG-13' 이면서 빌릴 수 있는 기간이 4 미만인 모든레코드
SELECT *
FROM film;

SELECT title, rating, rental_duration
FROM film
WHERE (rating = 'G' AND rental_duration >= 7)
	OR (rating = 'PG-13' AND rental_duration < 4);
	
-- group by

-- group function 그룹함수
-- sum, avg, min, max, count

SELECT * form customer;

SELECT COUNT(*), SUM(active)
, COUNT(*) - SUM(active) 
, MAX(address_id)
, MIN(address_id)
, truncate(AVG(address_id),0)
FROM customer; 

SELECT store_id, COUNT(*)
FROM customer
WHERE active = 1
GROUP BY store_id
HAVING COUNT(*) >= 300
ORDER BY store_id;


-- 3.8.1
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name, first_name;


-- 3.8.2
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name 
	IN('WILLIAMS', 'DAVIS');


-- 3.8.3
SELECT distinct customer_id
FROM rental
WHERE DATE(rental_date) = '2005-07-05'
ORDER BY customer_id;


-- 3.8.4
SELECT c.email, r.return_date
FROM customer c 
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY r.return_date DESC;

SELECT * FROM customer 
where first_name = 'STEVEN'
AND CREATE_date > '2006-01-01';


-- 이름 STEVEN, 생성날짜 2006-1-1 또는 그 이전
SELECT * FROM customer
WHERE first_name = 'STEVEN'
and CREATE_date <= '2006-01-01' ;


-- 이름 STEVEN이 아니고 생성날짜 2006-1-1 이후
SELECT * FROM customer
WHERE first_name != 'STEVEN'
and CREATE_date > '2006-01-01' ;


-- 이름은 STEVEN이 아니거나 성이 YOUNG인 사람중에
-- 생성날짜가 2006-1-1 이후인 사람들
SELECT * FROM customer
WHERE (first_name != 'STEVEN' OR last_name = 'YOUNG')
and CREATE_date > '2006-01-01';


-- 이름은 STEVEN이 아니거나 성이 YOUNG아닌 사람중에
-- 생성날짜가 2006-1-1 이후인 사람들
SELECT * FROM customer
WHERE (first_name != 'STEVEN' or last_name != 'YOUNG')
and CREATE_date > '2006-01-01';


-- file_id:762 인 rental_duration보다 짧은 영화만
-- 알고 싶다.

SELECT * FROM film
WHERE rental_duration < (SELECT rental_duration
									FROM film
									WHERE film_id =762);
									
-- 2005-06-14일날 렌탈을 한 사람들의 이메일을 알고 싶다.

SELECT distinct c.email
FROM customer c 
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE DATE(r.rental_date) = '2005-06-14'
ORDER BY c.email;


-- 2004, 2005년 제외한 렌탈정보 알고싶다.

SELECT * FROM rental
-- WHERE !(DATE(rental_date) >= '2004-01-01' 
-- and DATE(rental_date) <= '2005-12-31'); 
-- WHERE YEAR(rental_date) NOT BETWEEN '2004' and '2005';

-- WHERE YEAR(rental_date) NOT IN (2004,2005);


-- 2005-06-14 ~ 16 사이의 렌탈정보 알고 싶다.
WHERE date(rental_date) BETWEEN '2005-06-14' AND '2005-06-16';


-- 고객 성이 'FA' 와 'FR' 사이에 속하는 사람이 알고 싶다.
SELECT * FROM customer
WHERE last_name BETWEEN 'FA' AND 'FS';


-- 영화 등급이 G 혹은 PG 인 영화정보 알고싶다.
SELECT * FROM film
WHERE rating IN('G','PG');


-- 제목에 PET이 포함된 영화와 같은 등급을 가진 영화가 궁금하다.
SELECT title 
FROM film
WHERE rating IN (
	SELECT distinct rating 
	FROM film
	WHERE title LIKE '%PET%'
	);


-- 등급이 'PG-13', 'R', 'NC-17'이 아닌 영화 정보 알고 싶다.\
SELECT title 
FROM film
WHERE rating not IN('PG-13', 'R', 'NC-17');