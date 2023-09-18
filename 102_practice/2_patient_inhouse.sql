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

