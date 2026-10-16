```sql
/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To evaluate each product category's contribution to total sales.
    - To calculate the overall sales revenue across all categories.
    - To determine the percentage of total sales contributed by each category.
    - To rank categories according to their sales contribution.

SQL Functions and Clauses Used:
    - SUM(): Calculates total sales by category.
    - SUM() OVER(): Calculates the overall sales total across all categories.
    - CAST(): Converts a value to a specified data type.
    - ROUND(): Rounds a numeric value to a specified number of decimal places.
    - Common Table Expression (CTE): Defines a temporary named result set.
    - LEFT JOIN: Retains all rows from the left table.
    - GROUP BY: Groups sales records by product category.
    - ORDER BY: Sorts categories by total sales in descending order.
===============================================================================
*/

-- Determine each category's contribution to overall sales
WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER ()                                                AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
```
