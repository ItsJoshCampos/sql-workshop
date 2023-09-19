-- recreate view: executive.inhouse_patients

SELECT 
    patient_recent_event.patient_id
FROM 
    executive.patient_recent_event
WHERE 
    patient_recent_event.last_event_rownumber = 1  -- most recent
    AND patient_recent_event.event_id <> 5; -- not discharge event