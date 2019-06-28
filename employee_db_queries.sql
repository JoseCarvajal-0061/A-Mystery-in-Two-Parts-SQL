-- List the following details of each employee: employee number, last name, first name, gender, and salary.
select employee.emp_no, employee.last_name, employee.first_name, employee.gender
from employees e
cross apply(
		
	select salaries.salary 
	from salaries s 
	where e.emp_no=s.emp_no

	) s

-- List employees who were hired in 1986.

select first_name, last_name, hire_date
from employees 
where hire_date LIKE '1986%'

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

select departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
from departments
inner join dept_manager 
on departments.dept_no=dept_manager.dept_no
inner join employees
on dept_manager.emp_no=employees.emp_no

--List the department of each employee with the following information: employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
join dept_emp
on employees.emp_no=dept_emp.emp_no
join departments 
on dept_emp.dept_no=departments.dept_no

-- List all employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- Used subquerys instead of joins to obtain the same results 

select employees.emp_no, employees.last_name, employees.first_name
from employees
where emp_no in
(
	select emp_no
	from dept_emp 
	where dept_no in
	(
		select dept_no
		from departments
		where dept_name = 'Sales'
	)
);

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join dept_emp
on employees.emp_no=dept_emp.emp_no
inner join departments
on dept_emp.dept_no=departments.dept_no
where departments.dept_name = 'Sales'
or departments.dept_name = 'Development'

-- Used subquerys instead of joins to obtain the same results 

select employees.emp_no, employees.last_name, employees.first_name
from employees
where emp_no in
(
	select emp_no
	from dept_emp 
	where dept_no in
	(
		select dept_no
		from departments
		where dept_name = 'Sales'
        or dept_name = 'Development'
	)
);


-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name. 

select last_name, count(last_name) as "frequency_last_name"
from employees
group by last_name
order by "frequency_last_name" DESC;

