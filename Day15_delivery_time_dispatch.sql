DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS orders;


CREATE TABLE Restaurants1 (
    id int Identity(1,1) PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE Orders1 (
    id int Identity(1,1) PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurants1(id),
    order_time DATETIME,
    dispatch_time DATETIME
);

INSERT INTO Restaurants1 (name, location) VALUES
('Restaurant A', 'Delhi'),
('Restaurant B', 'Delhi'),
('Restaurant C', 'Delhi'),
('Restaurant D', 'Delhi'),
('Restaurant E', 'Delhi');

INSERT INTO Orders1 (restaurant_id, order_time, dispatch_time) VALUES
(1, '2024-07-23 12:00:00', '2024-07-23 12:14:00'),
(1, '2024-07-23 12:30:00', '2024-07-23 12:48:00'),
(1, '2024-07-23 13:00:00', '2024-07-23 13:16:00'),
(2, '2024-07-23 13:30:00', '2024-07-23 13:50:00'),
(2, '2024-07-23 14:00:00', '2024-07-23 14:14:00'),
(3, '2024-07-23 14:30:00', '2024-07-23 14:49:00'),
(3, '2024-07-23 15:00:00', '2024-07-23 15:16:00'),
(3, '2024-07-23 15:30:00', '2024-07-23 15:40:00'),
(4, '2024-07-23 16:00:00', '2024-07-23 16:10:00'),
(4, '2024-07-23 16:30:00', '2024-07-23 16:50:00'),
(5, '2024-07-23 17:00:00', '2024-07-23 17:25:00'),
(5, '2024-07-23 17:30:00', '2024-07-23 17:55:00'),
(5, '2024-07-23 18:00:00', '2024-07-23 18:19:00'),
(1, '2024-07-23 18:30:00', '2024-07-23 18:44:00'),
(2, '2024-07-23 19:00:00', '2024-07-23 19:13:00');

/*
You are given two tables: Restaurants and Orders. After receiving an order, 
each restaurant has 15 minutes to dispatch it. Dispatch times are categorized as follows:

on_time_dispatch: Dispatched within 15 minutes of order received.
late_dispatch: Dispatched between 15 and 20 minutes after order received.
super_late_dispatch: Dispatched after 20 minutes.
Task: Write an SQL query to count the number of dispatched orders in each category for each restaurant.
*/

SELECT * FROM Restaurants1;
SELECT * FROM orders1;

with dispatched_table
as
(
Select 
r.id as restaurant_id,
r.name as restaurant_name,
o.order_time,
o.dispatch_time,
DATEDIFF(MINUTE,o.order_time ,O.dispatch_time) as Time_took_d,
case when DATEDIFF(minute,o.order_time,o.dispatch_time)<=15 then 'on_time_dispatch'
     when DATEDIFF(minute,order_time,dispatch_time) between 15 and 20 then 'late_dispatch'
     else 'super_late_dispatch' 
end  as dispatch_category
from Restaurants1 r
join orders1 o 
on r.id=o.restaurant_id
)
select 
     restaurant_id,
     restaurant_name,
    COUNT(CASE WHEN dispatch_category = 'on_time_dispatch' THEN 1 END) as on_time_dispatch_cnt,
    COUNT(CASE WHEN dispatch_category = 'late_dispatch' THEN 1 END) as late_dispatch_cnt,
    COUNT(CASE WHEN dispatch_category = 'super_late_dispatch' THEN 1 END) as super_late_dispatch_cnt
FROM dispatched_table
GROUP BY 
     restaurant_id,
     restaurant_name