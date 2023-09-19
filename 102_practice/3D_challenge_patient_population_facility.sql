-- recreate view: executive.vw_patient_population_facility

-- why a view? we don't want to hand off this whole piece of code to run each time, create a view instead.

SELECT 
    fac.facility_name,
    count(pcl.patient_id) AS patient_count
FROM 
    executive.vw_patient_current_location pcl
LEFT JOIN 
    facility fac 
    ON fac.facility_id = pcl.facility_id
GROUP BY 
    fac.facility_name
ORDER BY 
    fac.facility_name;


-- sum add to the vw_inhouse_patients count