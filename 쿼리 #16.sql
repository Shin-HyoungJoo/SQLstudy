CREATE TABLE t_deal (
	id INT UNSIGNED AUTO_INCREMENT,
	deal_date DATE NOT NULL,
	price INT UNSIGNED NOT NULL,
	PRIMARY KEY (id)
);

ALTER TABLE t_deal MODIFY price INT UNSIGNED NOT null default 0;

DROP TABLE t_deal_sub;
CREATE TABLE t_deal_sub (
	deal_id INT UNSIGNED,
	seq INT UNSIGNED,
	provider_cd CHAR(1) NOT NULL,
	parts_id INT UNSIGNED NOT NULL,
	quantity INT unsigned NOT NULL,
	PRIMARY KEY(deal_id, seq),
	FOREIGN KEY(provider_cd) REFERENCES t_provider(cd),
	FOREIGN KEY(parts_id) REFERENCES t_parts(id),
	FOREIGN KEY(deal_id) REFERENCES t_deal(id)
);

CREATE TABLE t_provider (
	cd CHAR(1) PRIMARY KEY,
	nm VARCHAR(10) NOT NULL
);

CREATE TABLE t_parts (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nm VARCHAR(10) NOT NULL,
	price INT UNSIGNED NOT NULL
);

INSERT INTO t_provider
(cd, nm)
VALUES
('C', '찰리');

DELETE FROM t_provider
WHERE cd = 1;

INSERT INTO t_parts
(nm, price)
VALUES
('키보드', 30000);

INSERT INTO t_deal
(deal_date)
VALUES
('2023-10-20'),
('2023-10-20'),
('2023-10-22');

INSERT INTO t_deal_sub
(deal_id, seq, provider_cd, parts_id, quantity)
VALUES
(1, 1, 'A', 1, 10),
(1, 2, 'B', 2, 10),
(1, 3, 'C', 3, 10),
(2, 1, 'A', 1, 20),
(2, 2, 'B', 2, 10),
(3, 1, 'A', 2, 30),
(3, 2, 'C', 3, 5);

DELETE FROM t_deal_sub;

UPDATE t_deal A
INNER JOIN (
	SELECT deal_id, SUM(A.quantity * C.price) total_price
	FROM t_deal_sub A
	INNER join t_parts C
	ON A.parts_id = C.id
	GROUP BY deal_id
) B
ON A.id = B.deal_id
SET A.price = B.total_price;

SELECT B.deal_id '전표번호', 
		 date_format(deal_date, '%m/%d') AS '날짜',
		 D.nm '공급자명', 
		 C.nm '부품명', 
		 C.price '단가', 
		 quantity '수량', 
		 C.price * quantity '금액'
FROM t_deal A
INNER JOIN t_deal_sub B
ON A.id = B.deal_id
INNER JOIN t_parts C
ON B.parts_id = C.id 
INNER JOIN t_provider D
ON B.provider_cd = D.cd
ORDER BY deal_id;

