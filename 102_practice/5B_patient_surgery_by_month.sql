
with calendar as (
	select extract('year' from calendar.entry) as period_year
		, extract('month' from calendar.entry) as period_month
	from generate_series(date_trunc('month', NOW() - INTERVAL '6 MONTH') ,
							  NOW(),
							  interval '1 Month'
	) as calendar(entry)
),
surgery_by_calendar as (
	select 
		patient_id
		, c.period_year
		, c.period_month
	from
		calendar c
	left join 
		public.patient_event pe
		on c.period_year = extract('year' from event_dt_tm)
		and c.period_month = extract('month' from event_dt_tm)
	where 
		event_id = 3
)

select 
	period_year
	, period_month
	, count(*) as surgury_count
	into executive.patient_surgery_by_month
from 
	surgery_by_calendar
group by 
	period_year
	, period_month











-- --check
-- select count(*)
-- from public.patient_event 
-- where 
-- 	event_dt_tm >= '2023-08-01'
-- 	and event_dt_tm < '2023-09-01'
-- 	and event_id = 3