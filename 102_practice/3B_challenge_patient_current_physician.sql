/* 
    CHALLENGE
    recreate view: executive.vw_patient_current_physician
*/

-- why a view? we don't want to hand off this whole piece of code to run each time, create a view instead.


WITH patient_physician_events as (
    select  
        patevnt.patient_event_id
        ,patevnt.patient_id
        ,patevnt.event_id
        ,patevnt.physician_id
        ,patevnt.event_dt_tm
        ,patevnt.location_id
        ,patevnt.room_bed
        -- most recent event
        ,ROW_NUMBER() OVER(PARTITION BY patevnt.patient_id ORDER BY patevnt.event_dt_tm DESC) physician_rownumber
    from 
        public.patient_event patevnt -- all events
    inner join
        executive.vw_inhouse_patients ihp -- inner join to filter only inhouse patients
        on ihp.patient_id = patevnt.patient_id
    where 
        patevnt.physician_id is not null --records with physician
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
        -- filter to most recent event with physician identified
        physician_rownumber = 1
)

select 
    patphys.patient_id
    , phys.physician_name
    , phys.npi_number
from 
    recent_patient_physician patphys
left join
    public.physician phys
    on phys.physician_id = patphys.physician_id


-- rows returned match executive.vw_inhouse_patients view record count