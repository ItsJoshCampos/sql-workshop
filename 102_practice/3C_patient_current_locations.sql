-- recreate view: executive.vw_patient_current_location

-- why a view? we don't want to hand off this whole piece of code to run each time, create a view instead.


WITH patient_location_events as (
    select  
        patevnt.patient_event_id
        ,patevnt.patient_id
        ,patevnt.event_id
        ,patevnt.physician_id
        ,patevnt.event_dt_tm
        ,patevnt.location_id
        ,patevnt.room_bed
        -- most recent event
        ,ROW_NUMBER() OVER(PARTITION BY patevnt.patient_id ORDER BY patevnt.event_dt_tm DESC) location_rownumber
    from 
        public.patient_event patevnt -- events
    inner join
        executive.vw_inhouse_patients ihp -- inner join to filter only inhouse patients
        on ihp.patient_id = patevnt.patient_id
    where 
        patevnt.location_id is not null --records with location
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
        -- filter to most recent event with location identified
        location_rownumber = 1
)



select 
    patloc.patient_id
    , loc.facility_id
    , loc.location_name as current_location
from 
    recent_patient_location patloc
left join
    public.location loc
    on loc.location_id = patloc.location_id

