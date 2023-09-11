-- *NOTE: Postgres will require double quotes if a table name or column name has capitalization. 
-- best practice to keep all words lowercase

-- *NOTE: more time is spent reading code than writing it, so formatting is important!

/* KEYWORDS REVIEWED IN THIS SECTION
SELECT
FROM
WHERE
DISTINCT
LIMIT
LIKE
DATE COMPARISON < 
CONCATE OPERATOR ||
*/


-- 0. select all columns from the patient table
-- always start off with a filter. LIMIT is used to restrict the number of rows returned.
select  
    patient_id
    ,facility_id
    ,account_number
    ,last_name
    ,first_name
    ,birth_dt
    ,sex
    ,reason_for_visit
from 
    public.patient
LIMIT 1000;

-- 1. Retrieve the first name, last name, and dob of all patients.
SELECT first_name, last_name, birth_dt
FROM patient;

-- 2. List all unique facility names in the table.
-- DISTINCT ensures that only unique values are shown.
SELECT DISTINCT facility_id 
FROM patient;

-- 3. List all unique reason_for_visits names in the table.
-- DISTINCT ensures that only unique values are shown.
SELECT DISTINCT reason_for_visit 
FROM patient;

-- 4. Find all patient details who are born on a date.
SELECT *
FROM patient 
WHERE birth_dt = '1985-07-15';

-- 5. Display patient names (both first and last) in reverse alphabetical order based on first name.
SELECT first_name, last_name 
FROM patient 
ORDER BY last_name DESC;

-- 6. Display patient names (both first and last) in reverse order based on first name.
-- Use concatenation operator for build a full_name
SELECT first_name, last_name, first_name || ' ' || last_name as full_name
FROM patient 
ORDER BY last_name;

-- 7. List the details of patients whose first name starts with the letter "A".
-- LIKE is used with a pattern to search for specific strings.
SELECT * 
FROM patient 
WHERE first_name LIKE 'A%';

-- 8. Find all patients who visited for the reason 'Checkup'.
-- chances are, you don't go to a hospital for a 'checkup'
SELECT * 
FROM patient 
WHERE reason_for_visit = 'Checkup';

-- 9. Retrieve the account_number, first name, and last name of patients whose reason for visit contains the word 'fever'.
-- The LIKE operator paired with the '%' wildcard can find any string that contains a specific word or phrase.
SELECT account_number, first_name, last_name
FROM patient
WHERE reason_for_visit LIKE '%fever%';

-- 10. Retrieve the account numbers and birth dates for patients born before January 1, 1990.
SELECT account_number, birth_dt 
FROM patient 
WHERE birth_dt < '1990-01-01';

-- 11. Display details of patients whose last name ends with the letters "son".
SELECT * 
FROM patient 
WHERE last_name LIKE '%son';


/* *NOTE: avoid funning queries with a select *
* use column names in order to invoke use of indexes used on table
* indexes will be reviewed in a later section. 
*/
