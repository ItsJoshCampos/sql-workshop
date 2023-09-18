
WITH patient_physician_events as (
    select  
        patevnt.patient_event_id
        ,patevnt.patient_id
        ,patevnt.event_id
        ,patevnt.physician_id
        ,patevnt.event_dt_tm
        ,patevnt.location_id
        ,patevnt.room_bed
        ,ROW_NUMBER() OVER(PARTITION BY patevnt.patient_id ORDER BY patevnt.event_dt_tm DESC) physician_rownumber
    from 
        public.patient_event patevnt
    inner join
        executive.inhouse_patients ihp
        on ihp.patient_id = patevnt.patient_id
    where 
        patevnt.physician_id is not null
),
recent_patient_physician as (
    select  
        patient_event_id
        ,patient_id
        ,event_id
        ,physician_id
        ,event_dt_tm
        ,location_id
        ,room_bed
    from 
        patient_physician_events
    where 
        physician_rownumber = 1
)

select 
    patphys.patient_id
    , phys.physician_name
    , phys.npi_number
    --INTO executive.patient_current_physician
from 
    recent_patient_physician patphys
left join
    public.physician phys
    on phys.physician_id = patphys.physician_id

