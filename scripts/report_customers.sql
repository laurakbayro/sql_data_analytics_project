```sql
/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - To create a consolidated customer report with key metrics and behavioral insights.

Highlights:
    1. Retrieves customer information, including identifiers, names, and ages.
    2. Classifies customers into age groups and business segments (VIP, Regular, New).
    3. Aggregates customer-level metrics:
       - Total number of orders
       - Total sales revenue
       - Total quantity purchased
       - Total distinct products purchased
       - Customer purchasing lifespan in months
    4. Calculates key performance indicators (KPIs):
       - Recency: Months since the customer's last order
       - Average Order Value (AOV)
       - Average monthly spending
    5. Combines customer demographics, purchasing history, and segmentation
       into a single analytical view.

Data Sources:
    - gold.fact_sales
    - gold.dim_customers

Output:
    - gold.report_customers

SQL Features Used:
    - Common Table Expressions (CTEs)
    - Aggregate functions: COUNT(), SUM(), MIN(), MAX()
    - Date functions: DATEDIFF(), GETDATE()
    - CASE expressions for customer classification
    - CONCAT() for customer name construction
    - LEFT JOIN to combine sales and customer data
===============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_customers
-- =============================================================================
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS

WITH base_query AS(
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
SELECT
    f.order_number,
    f.product_key,
    f.order_date,
    f.sales_amount,
    f.quantity,
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    DATEDIFF(year, c.birthdate, GETDATE()) age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
WHERE order_date IS NOT NULL)

, customer_aggregation AS (
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    COUNT(DISTINCT order_number)                      AS total_orders,
    SUM(sales_amount)                                 AS total_sales,
    SUM(quantity)                                     AS total_quantity,
    COUNT(DISTINCT product_key)                       AS total_products,
    MAX(order_date)                                   AS last_order_date,
    DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY
    customer_key,
    customer_number,
    customer_name,
    age
)
SELECT
    customer_key,
    customer_number,
    customer_name,
    age,
    CASE
        WHEN age IS NULL THEN 'n/a'
        WHEN age < 20 THEN 'Under 20'
        WHEN age between 20 and 29 THEN '20-29'
        WHEN age between 30 and 39 THEN '30-39'
        WHEN age between 40 and 49 THEN '40-49'
        ELSE '50 and above'
    END                                         AS age_group,
    CASE
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END                                         AS customer_segment,
    last_order_date,
    DATEDIFF(month, last_order_date, GETDATE()) AS recency,
    total_orders,
    total_sales,
    total_quantity,
    total_products,
    lifespan,
    -- Calculate average order value (AOV)
    CASE WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_value,
    -- Calculate average monthly spending
    CASE WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_spend
FROM customer_aggregation
```
