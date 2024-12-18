CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);


INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
(1, 1, '2019-08-01', '2019-08-02'),
(2, 2, '2019-08-02', '2019-08-02'),
(3, 1, '2019-08-11', '2019-08-12'),
(4, 3, '2019-08-24', '2019-08-24'),
(5, 3, '2019-08-21', '2019-08-22'),
(6, 2, '2019-08-11', '2019-08-13'),
(7, 4, '2019-08-09', '2019-08-09');

SELECT * FROM delivery;


-- Problem Statement
-- SQL Query
-- Write an SQL query  to calculate the percentage of immediate orders 
-- among the first orders of all customers. 
-- The result should be rounded to 2 decimal places.

-- Definitions:
-- If the preferred delivery date of the customer is the same as the order date,
-- then the order is classified as "immediate." Otherwise, it is classified as "scheduled."
with orders_cte
as
(
select *,
       ROW_NUMBER() over(Partition by customer_id order by order_date) as Immediate_order
from Delivery
),
first_order
as
(
select *,
       case when order_date=customer_pref_delivery_date then 'Immediate'
	   else 'scheduled'
	   End as order_type
from orders_cte
where Immediate_order=1
)
select round (cast(count(*) as numeric(10,2))/(select count(*) from Delivery)*100,3)as Immediate_order_percentage
from first_order
where order_type='Immediate'