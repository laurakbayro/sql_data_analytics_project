```sql
/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group products into cost ranges and analyze their distribution.
    - To segment customers according to their spending and customer history.
    - To distinguish VIP, Regular, and New customers using defined business rules.
    - To count the number of customers in each segment.

SQL Functions and Clauses Used:
    - CASE: Assigns records to segments based on specified conditions.
    - SUM(): Calculates total customer spending.
    - MIN(): Retrieves the earliest order date.
    - MAX(): Retrieves the latest order date.
    - DATEDIFF(): Calculates the time difference between two dates.
    - COUNT(): Counts non-NULL values.
    - GROUP BY: Groups records by segment.
    - Common Table Expression (CTE): Defines a temporary named result set.
    - LEFT JOIN: Retains all rows from the left table.
===============================================================================
*/

/* Segment products into cost ranges and count the number of products in each range. */
WITH product_segments AS (
    SELECT
        product_key,
        product_name,
        cost,
        CASE
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM gold.dim_products
)
SELECT
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

/*
Segment customers according to their spending and the duration of their
purchasing history:
    - VIP: At least 12 months of purchasing history and total spending above 5,000.
    - Regular: At least 12 months of purchasing history and total spending of 5,000 or less.
    - New: Purchasing history spanning less than 12 months.

Then count the customers assigned to each segment.
*/
WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(order_date)     AS first_order,
        MAX(order_date)     AS last_order,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT
        customer_key,
        CASE
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;
```
