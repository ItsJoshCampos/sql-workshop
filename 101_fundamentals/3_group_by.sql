
/* KEYWORDS REVIEWED IN THIS SECTION
SELECT
FROM
WHERE
GROUP BY
COUNT
SUM
DISTINCT
MAX
MIN
AVG
*/


-- 1. Find the number of patients for each facility.
-- GROUP BY is used to aggregate data based on one or more columns.
SELECT facility_id, COUNT(patient_id) AS number_of_patients 
FROM patient 
GROUP BY facility_id;

-- 2. Identify facilities with more than 10 patients.
SELECT facility_id, COUNT(patient_id) AS patient_count 
FROM patient 
GROUP BY facility_id 
HAVING COUNT(patient_id) > 10;

-- 3. Determine the number of male and female patients in each facility.
SELECT facility_id, 
       sex, 
       COUNT(patient_id) AS gender_count 
FROM patient 
GROUP BY facility_id, sex;

-- 4. List reasons for visit that have been cited by more than 5 patients.
SELECT reason_for_visit, COUNT(patient_id) AS number_of_occurrences 
FROM patient 
GROUP BY reason_for_visit 
HAVING COUNT(patient_id) > 5;

-- 5. Identify facilities that have treated more female patients than male patients.
SELECT facility_id, 
       SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END) AS female_count 
FROM patient 
GROUP BY facility_id 
HAVING SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END) > COUNT(patient_id) / 2;

-- 6. Retrieve the number of patients with the same birth date.
SELECT birth_dt, COUNT(patient_id) AS patient_count 
FROM patient 
GROUP BY birth_dt 
HAVING COUNT(patient_id) > 1;

-- 7. Find reasons for visit from facilities with more than 3 different patients citing the same reason.
SELECT facility_id, reason_for_visit, COUNT(DISTINCT patient_id) AS patient_count 
FROM patient 
GROUP BY facility_id, reason_for_visit 
HAVING COUNT(DISTINCT patient_id) > 3;

-- 8. Determine the total number of patients born in each year.
SELECT EXTRACT(YEAR FROM birth_dt) AS birth_year, COUNT(patient_id) AS patient_count 
FROM patient 
GROUP BY EXTRACT(YEAR FROM birth_dt) 
ORDER BY birth_year;

-- 9. List last names that are shared by more than 3 patients.
SELECT last_name, COUNT(patient_id) AS name_count 
FROM patient 
GROUP BY last_name 
HAVING COUNT(patient_id) > 3;

-- 10. Find the most common reason for visit in each facility.
-- Using a subquery to retrieve the most common reason.
WITH ReasonCounts AS (
  SELECT facility_id, reason_for_visit, COUNT(*) as cnt
  FROM patient
  GROUP BY facility_id, reason_for_visit
)
SELECT facility_id, reason_for_visit 
FROM ReasonCounts 
WHERE (facility_id, cnt) IN (SELECT facility_id, MAX(cnt) 
                             FROM ReasonCounts 
                             GROUP BY facility_id);
