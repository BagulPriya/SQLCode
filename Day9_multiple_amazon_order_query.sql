DROP TABLE IF EXISTS orders;
CREATE TABLE ORDERS (
    order_id VARCHAR(10),
    customer_id INTEGER,
    order_datetime DATETIME,
    item_id VARCHAR(10),
    order_quantity INTEGER,
    PRIMARY KEY (order_id, item_id)
);

-- Inserting sample data

-- Assuming the ORDERS table is already created as mentioned previously

-- Inserting the provided data
INSERT INTO ORDERS (order_id, customer_id, order_datetime, item_id, order_quantity) VALUES
('O-005', 1, '2023-01-12 11:48:00', 'C005', 1),
('O-005', 1, '2023-01-12 00:48:00', 'C008', 1),
('O-006', 4, '2023-01-16 02:52:00', 'C012', 2),
('O-001', 4, '2023-06-15 04:35:00', 'C004', 3),
('O-007', 1, '2024-07-13 09:15:00', 'C007', 2),
('O-010', 3, '2024-07-13 13:45:00', 'C008', 5),
('O-011', 3, '2024-07-13 16:20:00', 'C006', 2),
('O-012', 1, '2024-07-14 10:15:00', 'C005', 3),
('O-008', 1, '2024-07-14 11:00:00', 'C004', 4),
('O-013', 2, '2024-07-14 12:40:00', 'C007', 1),
('O-009', 3, '2024-07-14 14:22:00', 'C006', 3),
('O-014', 2, '2024-07-14 15:30:00', 'C004', 6),
('O-015', 1, '2024-07-15 05:00:00', 'C012', 4);




DROP TABLE IF EXISTS ITEMS;
CREATE TABLE ITEMS (
    item_id VARCHAR(10) PRIMARY KEY,
    item_category VARCHAR(50)
);

-- Inserting sample data
INSERT INTO ITEMS (item_id, item_category) VALUES
('C004', 'Books'),
('C005', 'Books'),
('C006', 'Apparel'),
('C007', 'Electronics'),
('C008', 'Electronics'),
('C012', 'Apparel');

SELECT * FROM ITEMS;
SELECT * FROM orders;
--drop table ORDERS

-- Amazon Asked Interview Questions
--1. How many units were ordered yesterday?
SELECT sum(order_quantity)as total_units_sold
FROM orders 
WHERE Day(order_datetime) =Day('2024-07-14')

--2. In the last 7 days (including today), how many units were ordered in each category?
SELECT 
sum(o.order_quantity)as total_units_sold,
item_category
FROM orders o
join items i
on o.item_id=i.item_id
where order_datetime BETWEEN '2024-07-09' AND '2024-07-15'
group by item_category

--3. Write a query to get the earliest order_id for all customers for each date they placed an order.
select 
order_id
from (
select 
  *,
  ROW_NUMBER() over(Partition by customer_id,cast(order_datetime as date) order by order_datetime) as r_n
  from orders) as t
  where r_n=1

--4. Write a query to find the second earliest order_id for each customer for each date they placed two or more orders.
with CTE_order
as
(
select * ,
ROW_NUMBER() over (partition by customer_id,cast(order_datetime as date) order by order_datetime) as r_n
from orders
) 
select 
order_id
from CTE_order
where r_n=2
