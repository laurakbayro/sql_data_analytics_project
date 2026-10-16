```sql
/*
===============================================================================
Date Range Exploration
===============================================================================
Purpose:
    - To identify the earliest and latest order dates in the sales data.
    - To calculate the time span covered by historical sales records.
    - To identify the oldest and youngest customers based on their birthdates.
    - To calculate customer ages using the current date.

SQL Functions Used:
    - MIN(): Returns the minimum value in a column.
    - MAX(): Returns the maximum value in a column.
    - DATEDIFF(): Calculates the difference between two dates.
    - GETDATE(): Returns the current system date and time.
===============================================================================
*/

-- Determine the first and last order dates and the time span in months
SELECT
    MIN(order_date)                                   AS first_order_date,
    MAX(order_date)                                   AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Identify the oldest and youngest customers based on their birthdates
SELECT
    MIN(birthdate)                            AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate)                            AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;
```
