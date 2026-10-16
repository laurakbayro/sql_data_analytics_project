
/*
===============================================================================
Script: Dimensions Exploration
===============================================================================
Script Purpose:
    This script explores the customer and product dimension views in the
    Gold Layer to understand the available business attributes and their
    distinct values.

Actions Performed:
    - Retrieves the unique countries represented in the customer dimension.
    - Retrieves the unique combinations of product categories, subcategories,
      and product names from the product dimension.
    - Sorts the results to make the distinct values easier to review.

Views Explored:
    - gold.dim_customers
    - gold.dim_products

SQL Concepts Used:
    - SELECT DISTINCT: Retrieves unique values or combinations of values.
    - ORDER BY: Sorts the results by the specified columns.

Usage Notes:
    - Execute this script in the database containing the Gold Layer views.
    - Use the results to explore customer geography and product classifications.
    - The queries return distinct values, not counts of customers or products.

Note:
    This script only retrieves and displays data. It does not modify database
    objects or records.
===============================================================================
*/

-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT
    country
FROM gold.dim_customers
ORDER BY country;

-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM gold.dim_products
ORDER BY category, subcategory, product_name;
