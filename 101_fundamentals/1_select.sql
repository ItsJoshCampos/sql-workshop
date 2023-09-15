/* *NOTE: Postgres will require double quotes if a table name or column name has capitalization. 
* best practice to keep all words lowercase
* 
* *NOTE: more time is spent reading code than writing it, so formatting is important!
* SELECT
*   INDENT
* FROM
*   INDENT
*/


/* KEYWORDS REVIEWED IN THIS SECTION
SELECT
FROM
WHERE
DISTINCT
LIMIT
DATE COMPARISON = 
CONCATE OPERATOR ||
AS COLUMN ALIAS
*/


-- 1. select all columns from the patient table
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

-- 2. Retrieve the first name, last name, and dob of all patients.
SELECT first_name, last_name, birth_dt
FROM patient;

-- 3. List all unique facility names in the table.
-- DISTINCT ensures that only unique values are shown.
SELECT DISTINCT facility_id 
FROM patient;

-- 4. List all unique reason_for_visits names in the table.
-- DISTINCT ensures that only unique values are shown.
SELECT DISTINCT reason_for_visit 
FROM patient;

-- 5. Display patient names (both first and last) in reverse order based on first name.
-- Use concatenation operator for build a full_name
-- full name is a column alias using the AS keyword
SELECT first_name, last_name, first_name || ' ' || last_name as full_name
FROM patient 

-- 6. Find all patient details who are born on a date.
SELECT *
FROM patient 
WHERE birth_dt = '1985-07-15';

-- 7. Find all patients who visited for the reason 'Checkup'.
-- chances are, you don't go to a hospital for a 'checkup'
SELECT * 
FROM patient 
WHERE reason_for_visit = 'Checkup';


/* *NOTE: avoid funning queries with a select *
* use column names in order to invoke use of indexes used on table
* indexes will be reviewed in a later section. 
*/
