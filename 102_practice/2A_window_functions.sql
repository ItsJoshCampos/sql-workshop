
/* Window Functions : Enables data to be divided/ partitioned into a specified window
    COUNT()
*/

-- Our data set of all patient events from the start of the month until NOW
-- NOW() Built in timestamp in postgres
select
	patient_event_id
	, patient_id
	, event_id
	, physician_id
	, event_dt_tm
	, location_id
	, room_bed
from
    public.patient_event
where 
    event_dt_tm > '2023-09-01'
    and event_dt_tm < now()
	
    
-- count of events per patient using group by 
WITH patient_event_count AS (
	select
		patient_id
		, count(*) as total_events
	from
		public.patient_event
	where 
		event_dt_tm > '2023-09-01'
		and event_dt_tm < now()
	group by 
		patient_id
)

select
	pe.patient_event_id
	, pe.patient_id
	, pe.event_id
	, pe.physician_id
	, pe.event_dt_tm
	, pe.location_id
	, pe.room_bed
	, pecount.total_events
from
    public.patient_event pe
left join
	patient_event_count pecount
	on pe.patient_id = pecount.patient_id
where 
    pe.event_dt_tm > '2023-09-01'
    and pe.event_dt_tm < now()
order by 
	pe.patient_id


-- produce same result with windows function without CTE and GROUP
select 
    patient_event_id
	, patient_id
	, event_id
	, physician_id
	, event_dt_tm
	, location_id
	, room_bed
	, COUNT(*) OVER (PARTITION BY patient_id) as total_events
	--, SUM(*) OVER (PARTITION BY patient_id) as total_events
from
    public.patient_event
where 
    event_dt_tm > '2023-09-01'
    and event_dt_tm < now()
order by 
	patient_id



-- Build on example to add SUM functions with total_events column
WITH patient_event_total AS (
	select 
		patient_event_id
		, patient_id
		, event_id
		, physician_id
		, event_dt_tm
		, location_id
		, room_bed
		, COUNT(*) OVER (PARTITION BY patient_id) as total_events
		--, SUM(*) OVER (PARTITION BY patient_id) as total_events
	from
		public.patient_event
	where 
		event_dt_tm > '2023-09-01'
		and event_dt_tm < now()
	-- order by --order by can't be executed in a nested query/CTE
	-- 	patient_id
)

select 
	patient_event_id
	, patient_id
	, event_id
	, physician_id
	, event_dt_tm
	, location_id
	, room_bed
	, total_events
	, SUM(total_events) OVER (PARTITION BY patient_id) as total_events  -- add all events for patient_id
from
	patient_event_total
order by 
	patient_id