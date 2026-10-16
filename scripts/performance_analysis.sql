```sql
/*
===============================================================================
Performance Analysis (Year-over-Year and Average Comparison)
===============================================================================
Purpose:
    - To evaluate annual sales performance for each product.
    - To compare each product's yearly sales against its average annual sales.
    - To calculate the difference between current sales and the product's average.
    - To identify whether annual sales are above, below, or equal to the average.
    - To compare current-year sales with the previous year's sales.
    - To identify year-over-year sales increases, decreases, or no change.

SQL Functions and Clauses Used:
    - LAG(): Retrieves a value from a previous row within a defined window.
    - AVG() OVER(): Calculates the average within a specified window.
    - PARTITION BY: Divides rows into groups for window calculations.
    - ORDER BY: Defines the order of rows within a window.
    - CASE: Evaluates conditions and returns corresponding results.
    - Common Table Expression (CTE): Defines a temporary named result set.
===============================================================================
*/

/* Analyze annual product sales by comparing each year's performance
   against the product's average annual sales and the previous year's sales. */
WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date)  AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY
        YEAR(f.order_date),
        p.product_name
)
SELECT
    order_year,
    product_name,
    current_sales,
    AVG(current_sales) OVER (PARTITION BY product_name)                 AS avg_sales,
    current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
    CASE
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END                                                                 AS avg_change,
    -- Year-over-Year (YoY) Analysis
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
    CASE
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END                                                                     AS py_change
FROM yearly_product_sales
ORDER BY product_name, order_year;
```
