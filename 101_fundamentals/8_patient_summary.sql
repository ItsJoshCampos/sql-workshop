
-- build full patient timeline of events
-- event in asc order
-- description of facility, location, event, and physician
SELECT
    fac.facility_name
    ,pat.account_number
    ,patevt.event_dt_tm
    ,loc.location_name
    ,patevt.room_bed
    ,evt.event_name
    ,phys.physician_Name
    ,phys.npi_number
FROM 
    public.patient pat
/* 
    INNER join to the inhouse patients to reduce result to only patients that are in a facility currently
    - remove WHERE to run */
-- INNER JOIN  
--     executive.vw_inhouse_patients ihp
--     ON pat.patient_id = ihp.patient_id
LEFT JOIN
    public.facility fac
    ON fac.facility_id = pat.facility_id
LEFT JOIN
    public.patient_event patevt
    ON patevt.patient_id = pat.patient_id
LEFT JOIN
    public.event evt
    ON patevt.event_id = evt.event_id
LEFT JOIN
    public.physician phys
    on phys.physician_id = patevt.physician_id
LEFT JOIN
    public.location loc
    ON loc.location_id = patevt.location_id
WHERE 
    pat.patient_id = 1
ORDER BY 
    patevt.event_dt_tm