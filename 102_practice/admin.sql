CREATE SCHEMA IF NOT EXISTS executive
    AUTHORIZATION postgres; --add users for access



-- create latest event of patients table
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




-- Create view
CREATE OR REPLACE VIEW executive.inhouse_patients
 AS
    SELECT 
        patient_recent_event.patient_id
    FROM 
        executive.patient_recent_event
    WHERE 
        patient_recent_event.last_event_rownumber = 1 AND patient_recent_event.event_id <> 5;

ALTER TABLE executive.inhouse_patients
    OWNER TO postgres;



--remove discharges to generate inhouse patients
select 
    patient_id
    , event_id
    , event_dt_tm
    , ROW_NUMBER() OVER(partition by patient_id order by event_dt_tm desc) as last_event_rownumber
    , patient_event_id
--delete
from
    public.patient_event
where event_dt_tm > '2023-09-12'
    and event_dt_tm < '2023-09-18'
    and event_id = 5
