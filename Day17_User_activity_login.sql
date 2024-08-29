DROP TABLE IF EXISTS user_activities;

CREATE TABLE user_activities (
    user_id INT,
    activity VARCHAR(10), -- Either 'Login' or 'Logout'
    activity_time DATETIME
);



INSERT INTO user_activities (user_id, activity, activity_time) VALUES
(1, 'Login', '2024-01-01 08:00:00'),
(1, 'Logout', '2024-01-01 12:00:00'),
(1, 'Login', '2024-01-01 13:00:00'),
(1, 'Logout', '2024-01-01 17:00:00'),
(2, 'Login', '2024-01-01 09:00:00'),
(2, 'Logout', '2024-01-01 11:00:00'),
(2, 'Login', '2024-01-01 14:00:00'),
(2, 'Logout', '2024-01-01 18:00:00'),
(3, 'Login', '2024-01-01 08:30:00'),
(3, 'Logout', '2024-01-01 12:30:00');

SELECT * FROM user_activities


-- Find out each users and productivity time in hour!
-- productivity time = login - logout time
WITH login_logout_time
as
(
select *,
   LAG(activity)over(partition by user_id order by user_id) as prev_activity,
   LAG(activity_time)over(partition by user_id order by user_id) as prev_activity_time
from user_activities
),
Session
as 
(
select 
	user_id,
	prev_activity as login,
	prev_activity_time as login_time,
	activity as logout,
	activity_time as logout_time,
	DATEDIFF(HOUR,prev_activity_time,activity_time) as productivity_time
from login_logout_time
where
	prev_activity='Login'
	AND
	activity='Logout'
)
select 
	USER_ID,
	sum(productivity_time) 
from session
group by USER_ID