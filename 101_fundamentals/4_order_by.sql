
/* 
    KEYWORDS REVIEWED IN THIS SECTION
    ORDER BY: Sort the result in ASCending or DESCending order.
    DESC
*/

-- 0. Retrieve all patient names (first and last) and birth dates, ordered by birth date from oldest to newest.
SELECT first_name, last_name, birth_dt 
FROM patient 
ORDER BY birth_dt;

-- 1. Display the first 5 facility IDs with the highest number of patients.
-- GROUP BY is essential when using aggregates and the HAVING clause.
SELECT facility_id, COUNT(patient_id) AS patient_count 
FROM patient 
GROUP BY facility_id 
HAVING COUNT(patient_id) > 5
ORDER BY patient_count DESC  --why can i use alias in the order by?
LIMIT 5;

-- 2. List the details of male patients, ordered by last name in descending order.
SELECT * 
FROM patient 
WHERE sex = 'M' 
ORDER BY last_name DESC;

-- 3. Retrieve reasons for visit that have occurred more than 3 times, ordered by frequency.
SELECT reason_for_visit, COUNT(*) AS visit_count
FROM patient
GROUP BY reason_for_visit
HAVING COUNT(*) > 3
ORDER BY visit_count DESC;

-- 4. Display the first name, last name, and birth date of patients, ordered first by gender and then by birth date.
SELECT first_name, last_name, sex, birth_dt 
FROM patient 
ORDER BY sex, birth_dt;

-- 5. Identify facilities that have seen more than one female patient.
SELECT facility_id, COUNT(patient_id) AS female_patient_count 
FROM patient 
WHERE sex = 'F' 
GROUP BY facility_id 
HAVING COUNT(patient_id) > 1;

-- 6. List last names of patients that appear more than once, in alphabetical order.
SELECT last_name, COUNT(*) AS name_count 
FROM patient 
GROUP BY last_name 
HAVING COUNT(*) > 1 
ORDER BY last_name;

-- 7. Retrieve the top 3 most common reasons for visit.
SELECT reason_for_visit, COUNT(*) AS reason_count 
FROM patient 
GROUP BY reason_for_visit 
ORDER BY reason_count DESC 
LIMIT 3;

-- 8. List the names of patients born after 1990, ordered from youngest to oldest.
SELECT first_name, last_name, birth_dt 
FROM patient 
WHERE birth_dt > '1990-01-01' 
ORDER BY birth_dt DESC;
