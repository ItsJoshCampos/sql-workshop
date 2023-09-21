/* 
    CHALLENGE
    recreate view: executive.inhouse_patients using the executive.patient_recent_event Table 
*/

-- why a view? we don't want to hand off this whole piece of code to run each time, create a view instead.

SELECT *
FROM 
    executive.patient_recent_event

-- table with most recent events orderis already created in executive.patient_recent_event
/* 
    select 
        patient_id
        , event_id
        , event_dt_tm
        , ROW_NUMBER() OVER(partition by patient_id order by event_dt_tm desc) as last_event_rownumber
        --INTO executive.patient_recent_event
    from
        public.patient_event
    where 
        event_dt_tm > '2023-09-01'
        and event_dt_tm < now() 
*/

SELECT 
    patient_recent_event.patient_id
FROM 
    executive.patient_recent_event
WHERE 
    patient_recent_event.last_event_rownumber = 1  -- most recent DESC ordered by event_dt_tm column
    AND patient_recent_event.event_id <> 5; -- not discharge event