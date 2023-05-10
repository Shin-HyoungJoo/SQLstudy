-- 직원 남녀 숫자 알고 싶음.
SELECT gender, count(*) AS gender_count
FROM employees
GROUP BY gender;

-- 사번, 이름, 성, 현재 부서 어딘지 알고 싶다.
SELECT * from employees;

SELECT distinct e.emp_no, e.first_name, e.last_name, dp.dept_name
FROM employees e
INNER JOIN dept_emp d
ON e.emp_no = d.emp_no
INNER JOIN titles t
ON e.emp_no = t.emp_no
INNER JOIN departments dp
ON dp.dept_no = d.dept_no
WHERE d.to_date = '9999-01-01';

SELECT B.emp_no, B.first_name, B.last_name, A.dept_no, C.dept_name
FROM dept_emp A
INNER JOIN employees B
on A.emp_no = B.emp_no
INNER JOIN departments C
ON A.dept_no = C.dept_no
WHERE A.to_date = '9999-01-01';