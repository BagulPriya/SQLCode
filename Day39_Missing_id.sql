-- Day 39/40 SQL Challeng

Create table Customers1 (customer_id int, customer_name varchar(20));
insert into Customers1 (customer_id, customer_name) values ('1', 'Alice');
insert into Customers1 (customer_id, customer_name) values ('4', 'Bob');
insert into Customers1 (customer_id, customer_name) values ('5', 'Charlie');
-- insert into Customers1 (customer_id, customer_name) values ('101', 'John');
-- insert into Customers1 (customer_id, customer_name) values ('99', 'Mike');

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | customer_id   | int     |
-- | customer_name | varchar |
-- +---------------+---------+


-- customer_id is the primary key for this table.
-- Each row of this table contains the name and the id customer.


-- Write an SQL query to find the missing customer IDs. 
-- The missing IDs are ones that are not in the 
-- Customers table but are in the range between 1
-- and the maximum customer_id present in the table.

-- Notice that the maximum customer_id will not exceed 100.

SELECT * FROM Customers1;


























WITH num
AS
( 
  select 1 as id --main member
   UNION ALL
   select 
       id + 1 --recursive member
   from num
   where id < 100
    AND 
	id < (select Max(customer_id) over(order by customer_id) from Customers1 )
)
select id from num
where id<(select customer_id from Customers1)

