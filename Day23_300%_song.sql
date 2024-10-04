/*
Question:
Identifying Trending Songs:
Spotify wants to identify songs that have suddenly gained popularity within a week.

Write a SQL query to find the song_id and week_start 
date of all songs that had a play count increase of 
at least 300% from one week to the next. 
Consider weeks starting on Mondays.
*/

select * from spotify
with weekly_plays
as
(
select
    song_id,
	DATEADD(DAY, -(DATEPART(WEEKDAY, play_date) + @@DATEFIRST - 2) % 7, play_date) AS week_start,
	count(*) as play_cnt
from spotify
group by song_id,
	     DATEADD(DAY, -(DATEPART(WEEKDAY, play_date) + @@DATEFIRST - 2) % 7, play_date)
),
prev_plays
as
(select 
    song_id,
	week_start,
	play_cnt,
	LAG(play_cnt) over (partition by song_id order by week_start) as prev_w_play_cnt
from weekly_plays
),
growth_ratio
as
(
select 
   song_id,
   week_start,
   play_cnt,
   prev_w_play_cnt,
   ROUND((play_cnt-prev_w_play_cnt)/prev_w_play_cnt * 100,2) as growth_ratio
from prev_plays
where play_cnt>prev_w_play_cnt
)
SELECT 
     song_id,
     week_start,
	 growth_ratio
FROM growth_ratio    
WHERE growth_ratio > 300;
    
