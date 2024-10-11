-- 31/100 Days Challenge



-- Create Employee table and insert data
DROP TABLE IF EXISTS Employees3;
CREATE TABLE Employees3(
    id INT,          -- Auto-incrementing ID for each employee
    name VARCHAR(100) NOT NULL,     -- Employee name
    salary NUMERIC(10, 2),          -- Employee salary
    department_id INT,              -- Foreign key linking to Department table
    manager_id INT,                 -- Employee's manager (self-referencing foreign key)
    hire_date DATE NOT NULL        -- Date of hire
);

-- Insert data into Employees table with manually assigned IDs
INSERT INTO Employees3 (id, name, salary, department_id, manager_id, hire_date)
VALUES 
(1, 'Alice', 90000, 1, NULL, '2022-01-15'),    -- Alice is a top-level manager (no manager)
(2, 'Bob', 80000, 2, 1, '2022-02-20'),         -- Bob reports to Alice
(3, 'Charlie', 75000, 2, 1, '2022-03-12'),     -- Charlie reports to Alice
(4, 'David', 85000, 2, 1, '2022-03-25'),       -- David reports to Alice
(5, 'Eve', 95000, 2, 2, '2022-04-01'),         -- Eve reports to Bob
(6, 'Frank', 78000, 2, 2, '2022-04-20'),       -- Frank reports to Bob
(7, 'Grace', 60000, 3, 3, '2022-05-12'),       -- Grace reports to Charlie
(8, 'Heidi', 88000, 3, 1, '2022-06-15'),       -- Heidi reports to Alice
(9, 'Sam', 89000, 3, 2, '2022-05-01');

-- Find the employee details who has salary greater than their managers salary
-- in multiple approach!

select * from Employees3
--Approch 1 by using Correlated queries

select 
   e1.id,
   e1.name,
   e1.salary
from Employees3 as e1
where e1.salary >(select e2.salary from Employees3 e2
                   where e2.id=e1.manager_id)

--Approch 2 by using self join
select 
   e1.id,
   e1.name,
   e1.salary,
   e2.name as manage_name,
   e2.salary as Manager_salary
from Employees3 as e1
join Employees3 as e2
on e1.manager_id=e2.id
where e1.salary>e2.salary