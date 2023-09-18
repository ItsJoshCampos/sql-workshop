select 
    patient_id
    , event_id
    , event_dt_tm
    , ROW_NUMBER() OVER(partition by patient_id order by event_dt_tm desc) as last_event_rownumber
    INTO executive.patient_recent_event
from
    public.patient_event
where event_dt_tm > '2023-09-01'
    and event_dt_tm < now()