DROP TABLE IF EXISTS user_activity;
CREATE TABLE user_activity (
    user_id INT,
    login_date DATE
);



INSERT INTO user_activity (user_id, login_date) VALUES
(1, '2024-08-01'),
(1, '2024-08-02'),
(1, '2024-08-05'),
(1, '2024-08-07'),
(2, '2024-08-01'),
(2, '2024-08-02'),
(2, '2024-08-03'),
(2, '2024-08-04'),
(2, '2024-08-06'),
(3, '2024-08-01'),
(3, '2024-08-02'),
(3, '2024-08-03'),
(3, '2024-08-07'),
(4, '2024-08-02'),
(4, '2024-08-05'),
(4, '2024-08-07');
-- Given a user_activity table, write a SQL query to find all users who have logged in on at least 3 consecutive days.
select * from user_activity
with cte
as
(
select *,
ROW_NUMBER()over(partition by user_id order by login_date)as r_n,
Day(login_date)-ROW_NUMBER()over(partition by user_id order by login_date)as gr_p
from user_activity
),
cte_2
as
(
select *,
case when gr_p = 0  then 'yes' 
else 'no'
end as grp_flag
from cte
)
select 
user_id
from cte_2
where grp_flag='yes'
group by user_id,grp_flag
having count(1)>=3