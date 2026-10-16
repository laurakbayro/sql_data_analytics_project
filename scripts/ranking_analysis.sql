```sql
/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank products according to their generated revenue.
    - To identify the top-performing and lowest-performing products.
    - To compare simple ranking with window ranking functions.
    - To identify the customers generating the highest revenue.
    - To identify customers with the fewest orders.
    - To demonstrate how ranking functions handle ties in the results.

SQL Functions and Clauses Used:
    - TOP: Limits the number of rows returned.
    - RANK(): Assigns ranks based on an ordering criterion, preserving ties.
    - SUM(): Calculates total revenue.
    - COUNT(DISTINCT): Counts unique, non-NULL order numbers.
    - COALESCE(): Replaces NULL values with a specified value.
    - GROUP BY: Groups rows for aggregation.
    - ORDER BY: Sorts the results.
    - LEFT JOIN: Retains all rows from the left table.
===============================================================================
*/

-- Identify the five products generating the highest revenue using TOP
-- Simple Ranking
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Rank products by revenue using a window function
-- This approach allows filtering by rank and retaining ties
SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount)                             AS total_revenue,
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.product_name
) AS ranked_products
WHERE rank_products <= 5;

-- Identify the five products generating the lowest revenue among products with sales
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;

-- Include products with no sales by starting from the product dimension
-- COALESCE assigns zero revenue to products without matching sales records
SELECT TOP 5
    p.product_name,
    COALESCE(SUM(f.sales_amount), 0) AS total_revenue
FROM gold.dim_products p
LEFT JOIN gold.fact_sales f
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;

-- Identify the ten customers generating the highest revenue
SELECT TOP 10
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;

-- Identify the three customers with the fewest distinct orders
SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ;

-- Rank customers by number of distinct orders to identify all customers tied for the lowest count
SELECT *
FROM (
    SELECT
        c.customer_key,
        c.first_name,
        c.last_name,
        COUNT(DISTINCT f.order_number)                        AS total_orders,
        RANK() OVER (ORDER BY COUNT(DISTINCT f.order_number)) AS rank_orders
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON c.customer_key = f.customer_key
    GROUP BY
        c.customer_key,
        c.first_name,
        c.last_name
) AS ranked_customers
WHERE rank_orders = 1;
```
