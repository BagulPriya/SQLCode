use Hundred_days_sql
CREATE TABLE employees1 (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Manager_ID INT
);


INSERT INTO employees1 (Emp_ID, Emp_Name, Manager_ID) VALUES
(1, 'John', 3),
(2, 'Philip', 3),
(3, 'Keith', 7),
(4, 'Quinton', 6),
(5, 'Steve', 7),
(6, 'Harry', 5),
(7, 'Gill', 8),
(8, 'Rock', NULL);

select * from employees1
select e1.Emp_ID,
e1.Emp_Name,
e1.Manager_ID,
e2.Emp_ID,
e2.Emp_Name as Manager_name
from  employees1 e1
join employees1 e2
on e1.Manager_ID=e2.Emp_ID
