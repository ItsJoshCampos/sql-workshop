
WITH patient_location_events as (
    select  
        patevnt.patient_event_id
        ,patevnt.patient_id
        ,patevnt.event_id
        ,patevnt.physician_id
        ,patevnt.event_dt_tm
        ,patevnt.location_id
        ,patevnt.room_bed
        ,ROW_NUMBER() OVER(PARTITION BY patevnt.patient_id ORDER BY patevnt.event_dt_tm DESC) location_rownumber
    from 
        public.patient_event patevnt
    inner join
        executive.inhouse_patients ihp
        on ihp.patient_id = patevnt.patient_id
    where 
        patevnt.location_id is not null
),
recent_patient_location as (
    select  
        patient_event_id
        ,patient_id
        ,event_id
        ,physician_id
        ,event_dt_tm
        ,location_id
        ,room_bed
    from 
        patient_location_events
    where 
        location_rownumber = 1
)



select 
    patloc.patient_id
    , loc.facility_id
    , loc.location_name as current_location
    --INTO executive.patient_current_location
from 
    recent_patient_location patloc
left join
    public.location loc
    on loc.location_id = patloc.location_id

