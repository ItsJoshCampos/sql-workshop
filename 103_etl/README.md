# Patient History ETL

# Run the ETL

## 1. Create Python Virtual Environment

`python -m venv venv`

## 2. Start Python Virtual Environment

From the `103_etl` directory, run the following for macOS

`source venv/bin/activate`

Your terminal will show the virtual environment name when started.

## 3. Install packages from requirements.txt file

`pip install -r requirements.txt`

## 4. Run Script

`python main.py`


# ETL Sequence

1. Truncate History Table in Database
2. Copy CSV to Dataframe
3. Process data - Mask name
4. Upload Dataframe to Database

# How the patient_feed.csv file is Created

The csv data file contains data from the `public.patient` table with a few intentional modifications:

* New `full_name` column - concatenation of first and last name
* Modified `birth_date` column, timestamp type
* Excludes patients with 'Fever' as `reason_for_visit`

```sql
SELECT 
	facility_name
	,pat.facility_id
	,account_number
	,last_name ||', '|| first_name as full_name
	,pat.birth_dt::timestamp as birth_date
	,sex
	,reason_for_visit
FROM public.patient pat
left join 
	public.facility fac
	on pat.facility_id=fac.facility_id
where
	pat.reason_for_visit <> 'Fever';
```


# Data Analysis using Full Outer Join
## Outer join to identify differences

Once the data is in the database, we can run an outer join to compare it to the existing `public.patient` table.


## Exercise 1
### Flawed join using only account_number, account_number is not unique
```sql
SELECT ph.*, pat.*
FROM public.patient_history_masked ph
full outer join
	public.patient pat
	ON ph.account_number = pat.account_number
WHERE
	ph.reason_for_visit <> pat.reason_for_visit
```

## Exercise 2
### Improved join by adding facility_id, account_number is not unique
```sql
SELECT ph.*, pat.*
FROM public.patient_history_masked ph
full outer join
	public.patient pat
	ON ph.account_number = pat.account_number
	and ph.facility_id = pat.facility_id
WHERE
	ph.reason_for_visit <> pat.reason_for_visit
```

## Exercise 3
### Which patients are missing from the `public.patient_history_masked` table?
```sql
SELECT ph.*, pat.*
FROM public.patient_history_masked ph
full outer join
	public.patient pat
	ON ph.account_number = pat.account_number
	and ph.facility_id = pat.facility_id
WHERE
	ph.account_number is null
```