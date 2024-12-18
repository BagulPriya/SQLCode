-- Day 32/100 Days Challenge
-- 

Drop table Employees4

-- Create Employee table and insert data
DROP TABLE IF EXISTS Employees4;
CREATE TABLE Employees4 (
    id INT,          -- Auto-incrementing ID for each employee
    name VARCHAR(100) NOT NULL,     -- Employee name
    salary NUMERIC(10, 2),          -- Employee salary
    department_id INT,              -- Foreign key linking to Department table
    manager_id INT,                 -- Employee's manager (self-referencing foreign key)
    hire_date DATE NOT NULL        -- Date of hire
);

-- Insert data into Employees table with manually assigned IDs
INSERT INTO Employees4 (id, name, salary, department_id, manager_id, hire_date)
VALUES 
(1, 'Alice', 90000, 1, NULL, '2022-01-15'),    -- Alice is a top-level manager (no manager)
(2, 'Bob', 80000, 2, 1, '2022-02-20'),         -- Bob reports to Alice
(3, 'Charlie', 75000, 2, 1, '2022-03-12'),     -- Charlie reports to Alice
(4, 'David', 85000, 2, 1, '2022-03-25'),       -- David reports to Alice
(5, 'Eve', 95000, 2, 2, '2022-04-01'),         -- Eve reports to Bob
(6, 'Frank', 78000, 2, 2, '2022-04-20'),       -- Frank reports to Bob
(7, 'Grace', 60000, 3, 3, '2022-05-12'),       -- Grace reports to Charlie
(8, 'Heidi', 88000, 3, 1, '2022-06-15'),       -- Heidi reports to Alice
(9,	'Sam',	 89000, 1, 2, '2022-06-15');

--Q1. Write SQL query to find median salary 
-- If we add 1 more record with salary 91,000 what will be median?
select * from Employees4
--record is odd its is to find median
with ordered_salary
as
(
select 
  id,
  name,
  salary,
  Row_number() over(order by salary asc) as sal_asc,
  Row_number() over(order by salary desc) as sal_desc
from Employees4
)
select * 
from ordered_salary
where 
sal_asc-sal_desc=0

--what if record is even we have to find avg then median 
INSERT INTO Employees4 (id, name, salary, department_id, manager_id, hire_date)
VALUES(10,	'Saavi',	 91000, 1, 2, '2022-06-12')

with ordered_salary
as
(
select 
  id,
  name,
  salary,
  Row_number() over(order by salary) as sal_asc,
  Row_number() over(order by salary desc) as sal_desc
from Employees4
)
select 
    avg(salary) as median
from ordered_salary
where 
ABS(sal_asc-sal_desc)=1

--delete from Employees4
--where id=10