-- 05/11

SELECT 1 as num, 'abc' as str
UNION
SELECT 9 , 'xyzaa' 
UNION all
SELECT 9 , 'xyzaa';

-- 고객의 이름, 성/배우의 이름, 성 같이 띄워주세요. union 이용
SELECT 'customer' as typ, first_name, last_name
FROM customer
WHERE first_name REGEXP '^J' AND last_name REGEXP '^D'
UNION 
SELECT 'actor', first_name, last_name
FROM actor
where first_name REGEXP '^J' AND last_name REGEXP '^D';

-- 배우, 고객 둘다 이름이(fnm) J로 시작, 성이 D로 시작하는 사람리스트
SELECT T.*
FROM
(
	SELECT 'customer' as typ, first_name, last_name
	FROM customer
	UNION
	SELECT 'actor', first_name, last_name
	FROM actor
) T
WHERE T.first_name REGEXP '^J' AND T.last_name REGEXP '^D';


SELECT T.*
FROM
(
	SELECT 'customer' as typ, first_name, last_name
	FROM customer
	where first_name REGEXP '^J' AND last_name REGEXP '^D'
	UNION
	SELECT 'actor', first_name, last_name
	FROM actor
	where first_name REGEXP '^J' AND last_name REGEXP '^D'
) T;


SELECT T.*
FROM
(
	SELECT 'customer' as typ, first_name, last_name
	FROM customer
	where first_name REGEXP '^J' AND last_name REGEXP '^D'
	UNION
	SELECT 'actor', first_name, last_name
	FROM actor
	where first_name REGEXP '^J' AND last_name REGEXP '^D'
) T
where first_name REGEXP '^J' AND T.last_name REGEXP '^D'
GROUP BY first_name, last_name
HAVING COUNT(*) = 1;		-- (*)과 (1)은 동일, COUNT(*) = 전체행

CREATE TABLE except_a(
	id INT unsigned 
);

CREATE TABLE except_b(
	id INT unsigned 
);

insert INTO except_a
(id)
VALUES
(10), (11), (12), (10), (10); 

insert INTO except_b
(id)
VALUES
(10), (10);

SELECT id FROM except_a
UNION
SELECT id FROM except_b;

-- 실습 6-2, 6-3
SELECT T.* 
FROM
(
	SELECT first_name, last_name 
	FROM actor
	UNION
	SELECT first_name, last_name
	FROM customer
) T
WHERE last_name LIKE 'L%'
ORDER BY last_name;


CREATE TABLE string_tbl(
	char_fld CHAR(30),
	vchar_fld VARCHAR(30),
	text_fld text
);

INSERT INTO string_tbl
(char_fld, vchar_fld, text_fld)
VALUES
(
	'This is char date',
	'This varchar data',
	'This is text date'
);

SELECT *, QUOTE(text_fld) FROM string_tbl;

UPDATE string_tbl
SET vchar_fld = 'This is a piece of extremely long varchar data';

UPDATE string_tbl
SET text_fld = 'This s\'string didn''t WORK, but it does now';


SELECT @@session.sql_mode;

-- SET sql_mode = 'ansi';		-- 범위길이만큼 짜르고 글자넣음

SHOW WARNINGS;

SELECT lname, fname, CONCAT(lname, fname)
FROM person;

SELECT lname, char_LENGTH(lname)
FROM person;

SELECT lname, POSITION('ur' IN lname)
FROM person;

-- 가장먼저 만나는 n의 인덱스를 출력.
SELECT text_fld, POSITION('n' IN text_fld), LOCATE('n', text_fld, 12)
FROM string_tbl;

SELECT '안녕' = '안녕',
		 'abc' = 'ABC', 
		 'abc' = 'cba',
		 STRCMP('abc','ABCC'),
		 STRCMP('acb','ab'); 


SELECT 
	NAME, 
	NAME LIKE '%y',
	NAME REGEXP '^[C]'
FROM category;


SELECT first_name | ' ' | last_name
FROM customer;

SELECT first_name, REPLACE(first_name, 'BA', 'DA') 
FROM customer;

-- 성에서 PH > TH 바꾸고, NI > NA 

SELECT first_name, 
	REPLACE(REPLACE(first_name, 'PH', 'TH'), 'NI', 'NA')
FROM customer
WHERE customer_id = 41;

SELECT 'goodbye world', INSERT('goodbye world', 9, 0, 'cruel '),
INSERT('goodbye 1234 world', POSITION('world' IN 'goodbye 1234 world'), CHAR_LENGTH('world'), 'class');

-- 영화 제목 빈칸에 NICE 추가해주세요.
SELECT title, INSERT(title, POSITION(' ' IN title) ,0 ,' NICE')
FROM film;

SELECT email, 
substring(email, 3), 
SUBSTRING(email, 3, 6), 
SUBSTR(email, 3, 6),
MID(email, 3, 6)
FROM customer;


-- 사용자 이메일 쪼개서 출력 @ 기준으로
SELECT 
substring(email, 1, POSITION('@' IN email)-1) AS name,
substring(email, POSITION('@' IN email)+1) AS email
FROM customer;

SELECT( 38 * 59 ) / (78 - ( 8 * 6 ));

SELECT TRUNCATE(1123.3456, 3), ABS(-10);

SELECT NOW(), CURRENT_DATE(), CURRENT_TIME(),  CURRENT_TIMESTAMP();

SELECT CAST('2023-05-11 16:46:30' AS DATETIME)
, CONVERT('2023-05-11 16:46:30', DATETIME) ;

SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY)
, DATE_ADD(NOW(), INTERVAL '03:27:11' HOUR_SECOND);

SELECT * FROM employees
WHERE emp_no = 10001;

UPDATE employees
SET birth_date = DATE_ADD(birth_date, INTERVAL '2-1' YEAR_MONTH)
WHERE emp_no = 10001;

SELECT CURDATE(), SYSDATE()
 , weekday(NOW())  -- 월0 화1 수2 목3 금4 토5 일6
 , last_day(NOW())
 , DATE_SUB(NOW(), INTERVAL '2' YEAR)
 , EXTRACT(DAY FROM NOW())
 , DATEDIFF('2023-09-20','2023-05-12');
 
 
-- 7-1
SELECT substr('Please find the substring in this string',17,25);

-- 7-2
SELECT ABS(-25.76823), STRCMP(-25.76823, 0), TRUNCATE(-25.76823, 2);

-- 7-3
SELECT month(now());