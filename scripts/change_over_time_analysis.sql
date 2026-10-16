```sql
/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To analyze trends and changes in key business metrics over time.
    - To examine monthly sales performance and customer activity.
    - To compare different SQL Server date functions for time-based aggregation.
    - To support time-series analysis by organizing data into monthly periods.

SQL Functions Used:
    - YEAR(): Extracts the year from a date.
    - MONTH(): Extracts the month number from a date.
    - DATETRUNC(): Truncates a date to the beginning of a specified period.
    - FORMAT(): Converts a date into a formatted string.
    - SUM(): Calculates the total of numeric values.
    - COUNT(DISTINCT): Counts unique, non-NULL values.
    - GROUP BY: Groups records by the specified time period.
    - ORDER BY: Sorts the results chronologically or alphabetically, depending on the data type.
===============================================================================
*/

-- Analyze monthly sales performance using YEAR() and MONTH()
SELECT
    YEAR(order_date)             AS order_year,
    MONTH(order_date)            AS order_month,
    SUM(sales_amount)            AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity)                AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- Aggregate sales metrics by month using DATETRUNC()
SELECT
    DATETRUNC(month, order_date) AS order_date,
    SUM(sales_amount)            AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity)                AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);

-- Aggregate sales metrics using FORMAT() to display dates as year and abbreviated month
-- Note: FORMAT() returns text. In this query, the yyyy-MMM format sorts chronologically
-- because the year appears first, followed by the abbreviated month.
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount)              AS total_sales,
    COUNT(DISTINCT customer_key)   AS total_customers,
    SUM(quantity)                  AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');
```
