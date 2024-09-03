DROP TABLE IF EXISTS cinemas;
CREATE TABLE cinemas
    (id int identity (1,1), seat_id INT);

INSERT INTO cinemas(seat_id)
VALUES
    (1),
    (0),
    (0),
    (1),
    (1),
    (1),
    (0);
-- Write a SQL query to find the id where the seat is empty
-- and both the seat immediately before and immediately after it are also empty


-- 1 ---> empty
-- 0 ---> full

select * from cinemas
select 
    id,
	seat_id
from
(
select *,
   Lag(seat_id) over(order by id) as prev_seat_id,
   Lead(seat_id) over(order by id) as next_seat_id
from cinemas
)as t1
where seat_id=1
	  AND
	  prev_seat_id=1
	  AND
	  next_seat_id=1
