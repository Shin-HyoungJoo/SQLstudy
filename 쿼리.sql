-- 주석ghuyhuhuhuhuhuhuhu
/*
asdasdas
*/
CREATE TABLE t_test(
		id BIGINT UNSIGNED AUTO_INCREMENT
	, nm VARCHAR(100) NOT NULL
	, jumin CHAR(9) NOT null
	, age INT NOT NULL
	, addr VARCHAR(200)
	, created_at DATETIME DEFAULT NOW()
	, PRIMARY KEY(id)
);
DROP TABLE t_test;

INSERT INTO t_test
(nm, jumin, age, addr)
VALUES
('제임스','951216012', 25, '샌프란시스코시');

INSERT t_test
SET nm = '떼껄룩'
, jumin = '101100101'
, age = 21
, addr = '경북';


-- Read(Select문)

SELECT * FROM t_test;

SELECT nm, jumin FROM t_test;

SELECT nm, jumin AS '주민번호' from t_test;

SELECT * FROM t_test 
WHERE nm = '제임스';

SELECT * FROM t_test 
WHERE nm = '신사임당' AND addr =  "이세계";

SELECT * FROM t_test 
WHERE age = 25 or age = 27;

SELECT * FROM t_test 
WHERE age IN(25,27);

SELECT * FROM t_test 
WHERE nm LIKE '%제%';
-- %제% = "제" 글자 앞뒤로 뭐가 오든 상관없다. *과 비슷한 의미

-- U(update문)

UPDATE t_test 
SET nm = '유관순' 
WHERE id = 2;

UPDATE t_test
SET age = 22
, addr = '부산시'
WHERE id = 3;

-- delete

DELETE FROM t_test
where id = 2;

