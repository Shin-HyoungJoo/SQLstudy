-- 5/10

SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_T%S';


-- 고객 중에 이메일값이 5번째에 .이 있고 아이디값 13번째
-- 가 @인 사람

SELECT * FROM customer
WHERE email LIKE '____._______@%';


SELECT * FROM customer
WHERE last_name LIKE 'Q%' or last_name LIKE 'Y%'; 

SELECT * FROM customer
WHERE last_name REGEXP '^[QY]';

SELECT * FROM customer
WHERE last_name REGEXP '[LY]$';

SELECT * FROM customer
WHERE last_name REGEXP '+COB+';

SELECT rental_id, customer_id
FROM rental
WHERE return_date IS NULL;

-- 반납일이 2005-05-01~ 2005-09-01이 아닌 렌탈정보 알고싶다.

SELECT *
FROM rental
WHERE date(return_date) not BETWEEN '2005-05-01' AND '2005-08-31'
OR return_date IS NULL
ORDER BY rental_date DESC;

SELECT *
FROM payment
WHERE amount IN(1.98, 7.98, 9.98);

SELECT *
FROM customer
WHERE last_name LIKE '_A%W%';

SELECT * FROM person;

SELECT A.food, A.person_id, B.person_id, B.fname, B.lname
FROM favorite_food A
INNER join person B		--두 테이블에 있는값만 나오자
ON A.person_id = B.person_id;

SELECT * 
FROM person A		-- from 테이블은 무조건 다나온다(left join)
LEFT JOIN favorite_food B
ON A.person_id = B.person_id;		-- 연결시킬게없다면 NULL뜬다

SELECT A.customer_id, A.first_name, A.last_name, B.address, B.district
FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id;

SELECT A.customer_id, A.first_name, A.last_name, C.city
FROM customer A
INNER JOIN address B
ON A.address_id = B.address_id
INNER JOIN city C
ON B.city_id = C.city_id;

SELECT *
FROM customer
WHERE address_id  in (SELECT address_id
							FROM address
							WHERE district = 'California');

SELECT * FROM customer A
inner JOIN (
	SELECT address_id FROM address
	WHERE district = 'California'
) B
ON A.address_id = B.address_id;




SELECT distinct A.title
FROM film A
INNER JOIN film_actor B
ON A.film_id = B.film_id
INNER JOIN actor C
ON B.actor_id = C.actor_id
WHERE (A.first_name, A.last_name) IN (('CATE', 'MCQUEEN'), ('CUBA', 'BIRCH'));

SELECT * 
FROM film F
INNER JOIN
(
	SELECT B.film_id FROM actor A
	INNER JOIN film_actor B
	ON A.actor_id = B.actor_id
	WHERE (A.first_name, A.last_name) IN (('CATE', 'MCQUEEN'), ('CUBA', 'BIRCH'))
	GROUP BY B.film_id
	HAVING COUNT(*) = 2
) S
ON S.film_id = F.film_id;

SELECT c.first_name, c.last_name, a.address, ct.city
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE a.district = 'California';

SELECT C.title
FROM actor A
INNER JOIN film_actor B
ON A.actor_id = B.actor_id
INNER JOIN film C
ON B.film_id = C.film_id
WHERE A.first_name = 'JOHN';

-- self join
SELECT A.address, B.address, A.city_id 
FROM address A
INNER JOIN address B
ON A.city_id = B.city_id 
WHERE A.address_id <> B.address_id;

-- ON A.city_id = B.city_id AND A.address_id <> B.address_id; 와 같은말.