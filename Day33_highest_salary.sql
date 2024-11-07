-- Day 33/100 Days
-- Q3 .Nth Highest Salary?(with multiple approach)

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
(2, 'Micheal', 80000, 2, 1, '2022-02-20'),         -- Bob reports to Alice
(2, 'Bob', 80000, 2, 1, '2022-02-20'),         -- Bob reports to Alice
(3, 'Charlie', 75000, 2, 1, '2022-03-12'),     -- Charlie reports to Alice
(4, 'David', 85000, 2, 1, '2022-03-25'),       -- David reports to Alice
(5, 'Eve', 95000, 2, 2, '2022-04-01'),         -- Eve reports to Bob
(6, 'Frank', 78000, 2, 2, '2022-04-20'),       -- Frank reports to Bob
(7, 'Grace', 60000, 3, 3, '2022-05-12'),       -- Grace reports to Charlie
(8, 'Heidi', 88000, 3, 1, '2022-06-15');       -- Heidi reports to Alice

--Approch 1 using offset and fetch(limit does not work for sql)
select * 
from Employees4
order by salary desc
offset 0 rows fetch next 3 rows only


--Approch 2 using dense_rank with subquery
Select  
   * 
from 
(select 
	*,
   Dense_rank() over (order by salary desc) as dens_rn
from Employees4)t
where dens_rn=1