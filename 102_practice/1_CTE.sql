 
-- Create new patient result set with full_name column
WITH new_pats AS (
    SELECT patient_id, first_name, last_name, first_name ||' '|| last_name as full_name 
    FROM patient
)

-- cannot be run solo, must be run with CTE query body above!
SELECT patient_id, first_name, last_name, full_name
FROM new_pats;