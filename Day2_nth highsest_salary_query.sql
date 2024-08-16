use Hundred_days_sql


DROP TABLE IF EXISTS employees;
CREATE TABLE Employees (
    id int PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50),
    salary DECIMAL(10, 2)
);



INSERT INTO Employees (name, salary) VALUES
('Alice', 60000.00),
('Bob', 75000.00),
('Charlie', 50000.00),
('David', 50000.00),
('Eva', 95000.00),
('Frank', 80000.00),
('Grace', 80000.00),
('Hank', 90000.00),
('Hank', 75000.00);

SELECT * FROM Employees;  
-- Write SQL query to fetch nth highest salary!

WITH salary_ranks
AS
(
SELECT 
     salary,
	 DENSE_RANK() over(order by salary) as dense_rank
From Employees
)
select 
  salary,dense_rank
from salary_ranks
where dense_rank=5

--another way to find the nth highest salary
select * from 
(
SELECT 
     salary,
	 DENSE_RANK() over(order by salary) as dense_rank
From Employees
)t where  dense_rank=3