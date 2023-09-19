# Common Table Expressions - CTE

## What is it? 

Temporary result set (IN MEMORY!) that only exists for the life of the query

```sql
-- SYNTAX

WITH < cte_name > AS (
    < query >
)

SELECT *
FROM < cte_name >
```

CTE body must be run with select query in or to work. 

### Benefits?

* Increased readability


CTEs can be chained with comma separated queries. 

```sql

WITH < cte_name_1 > AS (
    < query_1 >
),
< cte_name_2 > AS (
    < query_2 >
)

SELECT *
FROM 
    < cte_name_1 >
INNER JOIN
    < cte_name_2 >
```
