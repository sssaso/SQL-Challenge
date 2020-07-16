-- Query

-- 1. List the following details of each employee: 
	-- employee number, last name, first name, sex, and salary.
SELECT e.emp_no,
	last_name, 
	first_name, 
	sex,
	salary
FROM employees AS e
JOIN salaries AS s ON
e.emp_no = s.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT last_name, 
		first_name,
		hire_date
FROM employees
WHERE hire_date >= '1986-01-01' 
	AND hire_date <= '1986-12-31';

--3. List the manager of each department with the following information: 
	-- department number, department name, the manager's employee number, last name, first name.
SELECT dept_no, 
		(SELECT dept_name
		FROM departments
		WHERE dept_manager.dept_no = departments.dept_no),
		emp_no,
		(SELECT last_name
		 FROM employees
		 WHERE dept_manager.emp_no = employees.emp_no),
		 (SELECT first_name
		 FROM employees
		 WHERE dept_manager.emp_no = employees.emp_no)
FROM dept_manager;

--4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

-- step 1.JOIN employees and dept_emp
-- Step 2. CREATE VIEW  
-- step3. subquery
CREATE VIEW employees_dept AS
SELECT e.emp_no, first_name, last_name, dept_no 
FROM employees AS e
JOIN dept_emp AS d
ON e.emp_no = d.emp_no;

SELECT emp_no,
		first_name,
		last_name,
		(
		SELECT dept_name
		FROM departments
		WHERE departments.dept_no = employees_dept.dept_no
		)
FROM employees_dept;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name,
	last_name,
	sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--6. List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.
CREATE VIEW employees_dept2 AS
SELECT emp_no,
	first_name,
	last_name,
	(
	SELECT dept_name
	FROM departments
	WHERE departments.dept_no = employees_dept.dept_no  
	)
FROM employees_dept
ORDER BY emp_no;

SELECT * 
FROM employees_dept2
WHERE dept_name = 'Sales';
		
--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT * 
FROM employees_dept2
WHERE dept_name = 'Sales'
OR dept_name = 'Development';


--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS count_last_name 
FROM employees
GROUP BY last_name
ORDER BY count_last_name DESC;

/*
## Bonus (Optional)

As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```
* Consult [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql) for more information.
* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://help.github.com/en/github/using-git/ignoring-files](https://help.github.com/en/github/using-git/ignoring-files) for more information.

2. Create a histogram to visualize the most common salary ranges for employees.

3. Create a bar chart of average salary by title.
*/


