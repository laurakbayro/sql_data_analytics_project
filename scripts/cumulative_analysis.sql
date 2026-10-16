```sql
/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate cumulative sales totals over time.
    - To analyze monthly sales trends using running totals that reset each year.
    - To track annual sales performance through cumulative aggregation.
    - To calculate a running average of annual average prices.
    - To demonstrate the use of window functions for time-based analysis.

SQL Functions Used:
    - DATETRUNC(): Truncates dates to the beginning of a specified period.
    - SUM(): Calculates total sales.
    - AVG(): Calculates average prices.
    - SUM() OVER(): Computes cumulative totals across a defined window.
    - AVG() OVER(): Computes a running average across a defined window.
    - PARTITION BY: Divides rows into groups and restarts the calculation for each group.
    - ORDER BY: Defines the sequence in which window calculations are performed.
===============================================================================
*/

-- Calculate total sales per month and a running total that restarts each year
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (PARTITION BY YEAR(order_date) ORDER BY order_date) AS running_total_sales
FROM
(
    SELECT
        DATETRUNC(month, order_date) AS order_date,
        SUM(sales_amount)            AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
) t;

-- Calculate total sales per year, cumulative sales over time,
-- and the running average of annual average prices
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
    AVG(avg_price) OVER (ORDER BY order_date)   AS moving_average_price
FROM
(
    SELECT
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount)           AS total_sales,
        AVG(price)                  AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t
```
