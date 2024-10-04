DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    item VARCHAR(255) NOT NULL
);

INSERT INTO orders (order_id, item) VALUES
(1, 'Chow Mein'),
(2, 'Pizza'),
(3, 'Veg Nuggets'),
(4, 'Paneer Butter Masala'),
(5, 'Spring Rolls'),
(6, 'Veg Burger'),
(7, 'Paneer Tikka');

select * from orders

-- 29/100 days challenge
/*
Zomato's delivery system encountered an issue where each item's order was swapped with the next item's order. 
Your task is to correct this swapping error and return the proper pairing of order IDs and items. 
If the last item has an odd order ID, it should remain as the last item in the corrected data.
Write an SQL query to correct the swapping error and produce the corrected order pairs.
*/
with new_orders
as
(
select 
   count(*) as total_order
from orders
)
select order_id,
	case when order_id % 2 <> 0 AND order_id <> total_order then order_id + 1
		 when order_id % 2 <> 0 AND order_id = total_order then  order_id
	else order_id - 1
	end  as Correct_order_id,
	item
from new_orders
cross join 
orders
order by  Correct_order_id