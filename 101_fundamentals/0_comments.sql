/* 
    Comments are your friend! 
    You'll thank yourself 6 months from now.  
*/

-- Azure Data Studio comment line: cmd+/
-- Azure Data Studio un-comment line: cmd+/

/*
    Azure Data Studio comment multi-line: alt+shift+a
    Azure Data Studio uncomment multi-line: alt+shift+a
*/


-- 0. single line example
select  patient_id
    ,facility_id
    ,account_number
    --,birth_dt
    ,sex
    ,reason_for_visit
from 
    public.patient
LIMIT 1000


-- 1. mutli-line example block of comments
/* 
    This query returns the first 1000 patient_ids
    and accountnumbers where the facilityId=1 
*/
select  patient_id
    ,account_number
from 
    public.patient
where
  facility_id = 1
LIMIT 1000