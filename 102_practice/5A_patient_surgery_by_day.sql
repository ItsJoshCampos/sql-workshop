
with calendar as (
	select date_trunc('day', calendar.entry) as calendar_day
	from generate_series(date_trunc('month',NOW()),
							  NOW(),
							  interval '1 day'
	) as calendar(entry)
),
surgery_by_calendar as (
	select 
		pe.patient_id
		, c.calendar_day
	from
		calendar c
	left join 
		public.patient_event pe
		on c.calendar_day = date(event_dt_tm)
	where 
		event_id = 3
)

select 
	calendar_day
	, count(*) as surgury_count
	into executive.patient_surgery_by_day
from 
	surgery_by_calendar
group by 
	calendar_day











-- --check
-- select *
-- from public.patient_event 
-- where 
-- 	event_dt_tm >= '2023-09-17'
-- 	and event_dt_tm < '2023-09-19'
-- 	and event_id = 3
