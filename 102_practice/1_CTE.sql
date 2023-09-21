 


 -- Subquery example -- TRY TO AVOID for readability
SELECT patient_id, first_name, last_name, full_name
FROM (
    SELECT patient_id, first_name, last_name, first_name ||' '|| last_name as full_name 
    FROM patient
    LIMIT 1000
) pats



-- INSTEAD, USE CTEs
-- Create new patient result set with full_name column
WITH new_pats AS (
    SELECT patient_id, first_name, last_name, first_name ||' '|| last_name as full_name 
    FROM patient
    LIMIT 1000
)

-- cannot be run solo, must be run with CTE query body above!
SELECT patient_id, first_name, last_name, full_name
FROM new_pats; -- selecting cols from CTE, works as a table, view, or subquery



