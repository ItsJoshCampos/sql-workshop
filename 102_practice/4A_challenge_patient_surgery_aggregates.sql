/* 
    CHALLENGE
    recreate view: executive.vw_surgery_year_month_day
*/

-- why a view? we don't want to hand off this whole piece of code to run each time, create a view instead.



-- Generate Series tool in postgres
select generate_series(date_trunc('month', NOW()), -- Start of series: go to start of today's month
							  NOW(), -- End of series: to up to today
							  interval '1 day'  -- Generate series: by day
	) 
	
select generate_series(date_trunc('month', NOW()), -- Start of series: go to start of today's month
							  NOW(), -- End of series: to up to today
							  interval '1 week'  -- Generate series: by day
	) 





with calendar as (
	-- generate a table from beginning of the month up to today
	select date_trunc('day', calendar.entry) as calendar_day
	from generate_series(date_trunc('month',NOW() - interval '6 month'),
							  NOW(),
							  interval '1 day'
	) as calendar(entry)
),
surgery_by_calendar as (
	-- get all surgery events that took place within our calendar table CTE
	-- event id = 3, surgery
	select 
		pe.patient_id
		, c.calendar_day
	from
		calendar c
	inner join 
		public.patient_event pe
		on c.calendar_day = date(event_dt_tm)
	where 
		event_id = 3
),
surgery_count as (
	select 
		-- extract year and month from timestamp
		extract('year' from calendar_day) as surgery_year
		, extract('month' from calendar_day) as surgery_month
		, calendar_day
		, count(*) as surgery_count_day
	from 
		surgery_by_calendar
	group by 
		calendar_day
)

select * 
from surgery_count


-- bonus, add count by month and year

select
	surgery_year
	, surgery_month
	, calendar_day
	, surgery_count_day
	, sum(surgery_count_day) over (partition by surgery_year, surgery_month) as total_surgeries_month
	, sum(surgery_count_day) over (partition by surgery_year) as total_surgeries_year
from surgery_count




-- --check day
-- select *
-- from public.patient_event 
-- where 
-- 	event_dt_tm >= '2023-09-17'
-- 	and event_dt_tm < '2023-09-19'
-- 	and event_id = 3

-- -- check month
-- select count(*)
-- from public.patient_event 
-- where 
-- 	event_dt_tm >= '2023-08-01'
-- 	and event_dt_tm < '2023-09-01'
-- 	and event_id = 3