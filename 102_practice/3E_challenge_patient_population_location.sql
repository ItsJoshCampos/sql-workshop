-- recreate view: executive.vw_patient_population_location

-- why a view? we don't want to hand off this whole piece of code to run each time, create a view instead.

SELECT 
    fac.facility_name,
    pcl.current_location,
    count(pcl.patient_id) AS patient_count
FROM 
    executive.vw_patient_current_location pcl
LEFT JOIN 
    public.facility fac 
    ON fac.facility_id = pcl.facility_id
GROUP BY 
    fac.facility_name
    , pcl.current_location
ORDER BY 
    fac.facility_name
    , pcl.current_location;


-- sum add to the vw_inhouse_patients count