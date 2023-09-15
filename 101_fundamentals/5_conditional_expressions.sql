-- 9. Display facility IDs which have treated more male patients than female patients.
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

-- 2. Check if the facility_id is missing and replace it with a default value using COALESCE.
-- COALESCE returns the first non-NULL value in the list.
SELECT patient_id, first_name, COALESCE(facility_id, 'Default Facility') AS facility
FROM patient;

-- 3. Convert any 'Unknown' values in the sex column to NULL using NULLIF.
-- NULLIF returns NULL if two expressions are equal, otherwise, it returns the first expression.
SELECT patient_id, first_name, last_name, NULLIF(sex, 'Unknown') AS sex
FROM patient;

-- 4. Cast the account_number as a VARCHAR and append it to the first_name.
SELECT patient_id, first_name || ' (' || CAST(account_number AS VARCHAR) || ')' AS account_label
FROM patient;

-- 5. Use CASE to label patients based on their reason for visit: 'Checkup' as 'Routine', 'Flu' as 'Illness', others as 'Miscellaneous'.
SELECT patient_id, first_name, last_name, reason_for_visit,
       CASE 
           WHEN reason_for_visit = 'Checkup' THEN 'Routine'
           WHEN reason_for_visit = 'Flu' THEN 'Illness'
           ELSE 'Miscellaneous'
       END AS visit_type
FROM patient;

-- 6. If last_name is NULL, replace it with 'No Last Name Provided' using COALESCE.
SELECT patient_id, first_name, COALESCE(last_name, 'No Last Name Provided') AS last_name
FROM patient;

-- 7. Convert any NULL values in the sex column to 'Not Provided' using COALESCE.
SELECT patient_id, first_name, last_name, COALESCE(sex, 'Not Provided') AS sex
FROM patient;

-- 8. Check if reason_for_visit is 'Flu' and change it to NULL, otherwise leave it as it is using NULLIF.
SELECT patient_id, first_name, last_name, NULLIF(reason_for_visit, 'Flu') AS reason_for_visit
FROM patient;

-- 9. Cast birth_dt to VARCHAR and combine it with the first_name.
SELECT patient_id, first_name || ': ' || CAST(birth_dt AS VARCHAR) AS name_and_birth
FROM patient;

-- 10. Use a CASE statement to classify patients based on their account_number: <1000 as 'Low', between 1000 and 5000 as 'Medium', >5000 as 'High'.
SELECT patient_id, first_name, last_name, account_number,
       CASE 
           WHEN account_number < 1000 THEN 'Low'
           WHEN account_number BETWEEN 1000 AND 5000 THEN 'Medium'
           ELSE 'High'
       END AS account_class
FROM patient;
