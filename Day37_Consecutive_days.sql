Create table Logs (Id int, Num int);

insert into Logs (Id, Num) values ('1', '1');
insert into Logs (Id, Num) values ('2', '1');
insert into Logs (Id, Num) values ('3', '1');
insert into Logs (Id, Num) values ('4', '2');
insert into Logs (Id, Num) values ('5', '1');
insert into Logs (Id, Num) values ('6', '2');
insert into Logs (Id, Num) values ('7', '2');

-- Write an SQL query to find all numbers that appear at least three times consecutively.
-- Return the result table in any order.
select 
   id
from 
(
    select *,
       Lag(num,1) over(order by id) as prev_num,
	    Lag(num,2) over(order by id) as second_prev_num
from Logs
) as sub_query
where Num =prev_num
      AND
	  prev_num = second_prev_num