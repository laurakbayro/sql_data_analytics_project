```sql
/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate key business metrics, including sales, quantity, and average price.
    - To measure the total number of orders, products, and customers.
    - To distinguish between all customers and customers who have placed orders.
    - To consolidate key business metrics into a single report for analysis.

SQL Functions Used:
    - SUM(): Calculates the total of numeric values.
    - AVG(): Calculates the average of numeric values.
    - COUNT(): Counts non-NULL values.
    - COUNT(DISTINCT): Counts unique, non-NULL values.
    - UNION ALL: Combines result sets without removing duplicate rows.
===============================================================================
*/

-- Calculate total sales revenue
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales;

-- Calculate the total quantity of items sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales;

-- Calculate the average selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales;

-- Count orders, including and excluding duplicate order numbers
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales;
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales;

-- Count products by product name
SELECT COUNT(product_name) AS total_products FROM gold.dim_products;

-- Count all customers in the customer dimension
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers;

-- Count unique customers who have placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;

-- Generate a consolidated report of key business metrics
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;
```
