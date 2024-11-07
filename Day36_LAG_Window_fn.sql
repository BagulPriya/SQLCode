-- Day 36/100
-- Amazon and Google SQL Problems

Create table  Weather (Id int, RecordDate date, Temperature int);

insert into Weather (Id, RecordDate, Temperature) values ('1', '2015-01-01', '10');
insert into Weather (Id, RecordDate, Temperature) values ('2', '2015-01-02', '25');
insert into Weather (Id, RecordDate, Temperature) values ('3', '2015-01-03', '20');
insert into Weather (Id, RecordDate, Temperature) values ('4', '2015-01-04', '30');

SELECT * FROM weather;

/*
Write an SQL query to find all dates' id with higher temperature compared to its previous dates (yesterday).
*/

with Weather_cte
as
(
select 
   id,
   RecordDate,
   Temperature,
   Lag(Temperature,1) over(order by RecordDate) as prev_temp
from Weather
)
select 
 id,
 RecordDate
from Weather_cte
where Temperature>prev_temp


SELECT cplan.usecounts, cplan.objtype, qtext.text, qplan.query_plan
FROM sys.dm_exec_cached_plans AS cplan
CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS qtext
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qplan
ORDER BY cplan.usecounts DESC



DBCC FREEPROCCACHE