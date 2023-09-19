-- 0. Display facility IDs which have treated more male patients than female patients.
SELECT facility_id, 
       SUM(CASE WHEN sex = 'M' THEN 1 ELSE 0 END) AS male_count, 
       SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END) AS female_count
FROM patient
GROUP BY facility_id
HAVING SUM(CASE WHEN sex = 'M' THEN 1 ELSE 0 END) > SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END);

-- 1. Classify patients based on their age.
-- CASE statements allow for conditional logic in SQL queries.
SELECT patient_id, first_name, last_name, birth_dt,
       CASE 
           WHEN EXTRACT(YEAR FROM age(birth_dt)) BETWEEN 0 AND 18 THEN 'Minor'
           WHEN EXTRACT(YEAR FROM age(birth_dt)) BETWEEN 19 AND 60 THEN 'Adult'
           ELSE 'Senior'
       END AS age_category
FROM patient;

-- 2. Cast the account_number as a VARCHAR and append it to the first_name.
SELECT patient_id, first_name || ' (' || CAST(account_number AS VARCHAR) || ')' AS account_label
FROM patient;

-- 3. Use CASE to label patients based on their reason for visit.'.
-- Clean this up?
SELECT patient_id, first_name, last_name, reason_for_visit,
       CASE 
           WHEN reason_for_visit LIKE '%Consult%' THEN 'Routine'
           WHEN reason_for_visit LIKE '%Sprain%' 
              OR reason_for_visit LIKE '%Fractured%' THEN 'Injury'
           WHEN reason_for_visit LIKE '%Fever%'
              OR reason_for_visit LIKE 'Cough%' THEN 'Illness'
           ELSE 'Miscellaneous'
       END AS visit_type
FROM patient;

-- 4. If middle_name is NULL, replace it with 'No Middle Name Provided' using COALESCE.
WITH NewPats AS (
       SELECT patient_id, first_name, NULL AS middle_name
       FROM patient
)
SELECT patient_id, first_name, COALESCE(middle_name, 'No Middle Name Provided') AS last_name
FROM NewPats;

-- 5. Use a CASE statement to classify patients based on their account_number: <1000 as 'Low', between 1000 and 5000 as 'Medium', >5000 as 'High'.
SELECT patient_id, first_name, last_name, account_number,
       CASE 
           WHEN CAST(account_number AS BIGINT) < 3000000000 THEN 'Low'
           WHEN CAST(account_number AS BIGINT) BETWEEN 3000000000 AND 5000000000 THEN 'Medium'
           ELSE 'High'
       END AS account_class
FROM patient;
