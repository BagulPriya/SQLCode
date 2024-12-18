create table ActorDirector(
actor_id int,
director_id int,
timestamp int
)


insert into ActorDirector values
(1,1,0),
(1,1,1),
(1,1,2),
(1,2,3),
(1,2,4),
(2,1,5),
(2,1,6);

select * from ActorDirector
---write a sql query for a report that provides the pairs(actor_id,director_id)
--where the actor have co-worked with the director at least 3 times
select actor_id,
       director_id
	   --count(*)
from ActorDirector
group by actor_id,director_id
having count(*)>=3