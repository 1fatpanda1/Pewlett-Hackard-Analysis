--Retrieve emp_no, first_name, and last_name of employees
SELECT emp_no, first_name, last_name
FROM employees;

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT emp_no, title, from_date, to_date
FROM titles;

-- Create a new table using the INTO clause.
-- DROP TABLE emp_named;
SELECT emp_no, birth_date, first_name, last_name
INTO emp_named
FROM employees;

SELECT emp_no, title, from_date, to_date
INTO emp_titled
FROM titles;

-- Join both tables on the primary key.
SELECT em.emp_no,
	em.first_name,
	em.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as em
INNER JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;


------ retrieve the number of employees by their most recent job title who are about to retire
DROP TABLE retiring_titles;

SELECT COUNT(title), title
INTO Retiring_Titles
FROM unique_titles
GROUP BY unique_titles.title
ORDER BY COUNT(title) DESC; 


SELECT * FROM retiring_titles;


-- create a Mentorship Eligibility table 
SELECT DISTINCT ON (em.emp_no) em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as em
	INNER JOIN dept_emp as de
	ON em.emp_no = de.emp_no
	INNER JOIN titles as ti
	ON em.emp_no = ti.emp_no
WHERE (ti.to_date = '9999-01-01') AND (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibility;

