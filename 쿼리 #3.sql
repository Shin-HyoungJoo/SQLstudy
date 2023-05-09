CREATE DATABASE exam;
DROP TABLE person;
DROP TABLE favorite_food;
CREATE TABLE person (
	person_id INT UNSIGNED,
	fname VARCHAR(20),
	lname VARCHAR(20),
	eye_color CHAR(2) CHECK(eye_color IN ('BR', 'BL', 'GR')),
-- eye_color CHAR(2) ENUM('BR', 'BL', 'GR'),
	birth_date DATE,
	street VARCHAR(20),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_codpersone VARCHAR(20),
	PRIMARY KEY (person_id)
);

DESC person;

CREATE TABLE favorite_food(
	person_id INT UNSIGNED,
	food VARCHAR(20),
	PRIMARY KEY(person_id, food),
	FOREIGN KEY(person_id) REFERENCES person(person_id)
);

INSERT INTO person
(
	person_id, fname, lname, birth_date, eye_color
)
VALUES
(
	1, 'William', 'Turnet', '1972-05-27', 'BR'
);

SELECT person_id, fname, lname, birth_date
FROM person;

SELECT *
FROM person;

INSERT INTO favorite_food
( person_id, food )
VALUES
( 1, 'pizza' ),
( 1, 'cookie' ),
( 1, 'nachos' );

DELETE FROM favorite_food;

TRUNCATE favorite_food;	--더빠르게지움

SELECT * FROM favorite_food
FOR XML;

UPDATE person
SET 
fname = '윌리암',
lname = '터너',
country = '대한민국'
WHERE person_id = 1;

INSERT INTO person
SET 
person_id = 2,
fname = '길동',
lname = '홍',
birth_date = '1980-05-27',
eye_color = 'GR';

INSERT INTO person
SET person_id = 3,
fname = '관순',
lname = '유',
birth_date = '1985-07-27',
eye_color = 'RD';

UPDATE person
SET birth_date = STR_TO_DATE('DEC-21-1980', '%b-%d-%Y')
WHERE person_id = 1;

SELECT STR_TO_DATE('DEC-21-1980', '%b-%d-%Y')