
/* KEYWORDS REVIEWED IN THIS SECTION
SELECT
FROM
WHERE
DATE COMPARISON = < >
LIKE
AND
OR
IN
BETWEEN
*/


-- 1. Retrieve details of patients who are male and visited for 'High blood pressure'.
SELECT *
FROM patient 
WHERE sex = 'M' AND reason_for_visit ='High blood pressure';

-- 2. List female patients born after January 1, 1990, but before January 1, 2000.
SELECT *
FROM patient 
WHERE sex = 'F' AND birth_dt > '1990-01-01' AND birth_dt < '2000-01-01';

-- 3. Display details of patients whose last name starts with 'A' or 'B'.
-- The LIKE operator paired with the '%' wildcard can find any string that contains a specific word or phrase.
SELECT *
FROM patient 
WHERE last_name LIKE 'A%' OR last_name LIKE 'B%';

-- 4. Retrieve information on patients who are not associated with facility_id '4' and '5'.
SELECT * 
FROM patient 
WHERE facility_id NOT IN (4, 5);

-- 5. List patients who visited for 'Flu' or 'Fever', and are associated with facility_id '3'.
SELECT * 
FROM patient 
WHERE reason_for_visit IN ('Flu', 'Fever') AND facility_id = 3;

-- 6. Retrieve details of patients born between January 1, 1985, and December 31, 1995, excluding those with reason for visit LIKE 'pain'.
SELECT * 
FROM patient 
WHERE birth_dt BETWEEN '1985-01-01' AND '1995-12-31' AND reason_for_visit LIKE '%pain%';

-- 7. List female patients with the last name 'Smith' or 'Jones' who visited for 'Checkup' or 'Consultation'.
SELECT * 
FROM patient 
WHERE sex = 'F' AND (last_name = 'Smith' OR last_name = 'Jones') AND (reason_for_visit = 'Checkup' OR reason_for_visit = 'Consultation');

-- 8. List the details of patients whose first name starts with the letter "A".
-- LIKE is used with a pattern to search for specific strings.
SELECT * 
FROM patient 
WHERE first_name LIKE 'A%';

-- 9. Display details of patients whose last name ends with the letters "son".
SELECT * 
FROM patient 
WHERE last_name LIKE '%son';