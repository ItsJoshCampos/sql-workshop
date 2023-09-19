/*     
    ROW_NUMBER(): Unique incrementing sequence of integers, NEVER the same value
    RANK(): Same values in window get the same rank, count previous rank rows + 1
    DENSE_RANK(): Same values in window get the same rank, previous rank + 1
*/




WITH custom_event as (
	select 
		patient_event_id
		, patient_id
		, event_id
		, event_dt_tm
		, date_trunc('day', event_dt_tm) as event_day  -- remove ts to get date only
	from 
		public.patient_event
	where 
        --isolate 1 patient with 6 events
		patient_id = 69219
)
select 
    patient_event_id
	, patient_id
	, event_id
	, event_dt_tm
	, COUNT(*) OVER (PARTITION BY patient_id) as total_events
	--row_number in event timestamp order - get earliest event
	, ROW_NUMBER() OVER (PARTITION BY patient_Id order by event_dt_tm) as event_row_number
	--row_number in event timestamp DESC order - get most recent event
	, ROW_NUMBER() OVER (PARTITION BY patient_Id order by event_dt_tm desc) as event_row_number_desc
	-- rank by patient and day
	, RANK() OVER (PARTITION BY patient_Id order by event_day) as event_rank_by_day
	-- rank by patient and day
	, DENSE_RANK() OVER (PARTITION BY patient_Id order by event_day) as event_rank_by_day
from
    custom_event
-- where criteria moved to cte


