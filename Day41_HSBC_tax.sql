-- Day 41/100 SQL Challenge


DROP TABLE IF EXISTS salaries;
CREATE TABLE Salaries (
    company_id INT, 
    employee_id INT, 
    employee_name VARCHAR(50), 
    salary INT
);

INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES
(1, 1, 'Tony', 2000),
(1, 2, 'Pronub', 21300),
(1, 3, 'Tyrrox', 10800),
(2, 1, 'Pam', 300),
(2, 7, 'Bassem', 450),
(2, 9, 'Hermione', 700),
(3, 7, 'Bocaben', 100),
(3, 2, 'Ognjen', 2200),
(3, 13, 'Nyancat', 3300),
(3, 15, 'Morninngcat', 7777);

/*Problem
Write an SQL query to find the salaries of the employees after applying taxes.

The tax rate is calculated for each company based on the following criteria:

0% If the max salary of any employee in the company is less than 1000$.
24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
49% If the max salary of any employee in the company is greater than 10000$.
Return the result table in any order. Round the salary to the nearest integer.
*/

SELECT * FROM salaries;

With max_salary
as
(
	select 
		company_id,
		max(salary)as max_salary
	from Salaries
	group by company_id 
), 
salary_before_tax
as
(
	select 
		s.company_id,
		s.employee_id,
		s.employee_name,
		s.salary,
		ms.max_salary,
	case when ms.max_salary<1000  then  0.0
		 when ms.max_salary BETWEEN  1000 AND 10000 then 0.24
	else 0.49
	end as tax_slab
	from Salaries as s
	join max_salary as ms
	on s.company_id=ms.company_id
)
select 
   company_id,
   employee_id,
   employee_name,
   ROUND((salary)*(1- tax_slab),0
			) as salary_after_tax
from salary_before_tax