DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;

SELECT *
FROM departments;
SELECT *
FROM dept_emp;
SELECT *
FROM dept_manager;
SELECT *
FROM employees;
SELECT *
FROM salaries;
SELECT *
FROM titles;

CREATE TABLE departments (
	dept_no VARCHAR,
	dept_name VARCHAR
);
CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR,
	from_date VARCHAR,	
	to_date VARCHAR
);
CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no INT,
	from_date VARCHAR,
	to_date VARCHAR
);
CREATE TABLE employees (
	emp_no INT,
	birth_date VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date VARCHAR
);
CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	from_date VARCHAR,
	to_date VARCHAR
);
CREATE TABLE titles (
	emp_no INT,
	title VARCHAR,
	from_date VARCHAR,
	to_date VARCHAR
);

--1.List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no;
--2.List employees who were hired in 1986.
SELECT emp_no,last_name,first_name,hire_date
FROM employees
WHERE hire_date LIKE '1986%';
--3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dmd.dm_dept_no as dept_no,dmd.dm_emp_no as emp_no ,e.first_name as first_name,e.last_name as last_name,dmd.d_dept_name as dept_name,dmd.dm_from_date as from_date,dmd.dm_to_date as to_date
FROM 
(
SELECT dm.dept_no as dm_dept_no ,dm.emp_no as dm_emp_no,d.dept_name as d_dept_name,dm.from_date as dm_from_date ,dm.to_date as dm_to_date
FROM dept_manager as dm
INNER JOIN departments as d
ON dm.dept_no = d.dept_no
) as dmd
INNER JOIN employees as e
on dmd.dm_emp_no = e.emp_no;
--4.List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dee.emp_no as emp_no, dee.last_name as last_name, dee.first_name as first_name, d.dept_name as dept_name
FROM
(SELECT de.emp_no as emp_no, de.dept_no as dept_no, e.first_name as first_name, e.last_name as last_name
FROM dept_emp as de
INNER JOIN employees as e
on de.emp_no = e.emp_no) as dee
INNER JOIN departments as d
ON d.dept_no = dee.dept_no
;
--5.List all employees whose first name is "Hercules" and last names begin with "B."
SELECT emp_no,first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dee.emp_no as emp_no, dee.last_name as last_name, dee.first_name as first_name, d.dept_name as dept_name
FROM
(SELECT de.emp_no as emp_no, de.dept_no as dept_no, e.first_name as first_name, e.last_name as last_name
FROM dept_emp as de
INNER JOIN employees as e
on de.emp_no = e.emp_no) as dee
INNER JOIN departments as d
ON d.dept_no = dee.dept_no
WHERE d.dept_name = 'Sales'
;
--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dee.emp_no as emp_no, dee.last_name as last_name, dee.first_name as first_name, d.dept_name as dept_name
FROM
(SELECT de.emp_no as emp_no, de.dept_no as dept_no, e.first_name as first_name, e.last_name as last_name
FROM dept_emp as de
INNER JOIN employees as e
on de.emp_no = e.emp_no) as dee
INNER JOIN departments as d
ON d.dept_no = dee.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
;
--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, count(*) as frequency
FROM employees
GROUP BY last_name;

