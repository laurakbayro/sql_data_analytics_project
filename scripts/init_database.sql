
/*
===============================================================================
Script: Initialize Data Warehouse Database
===============================================================================
Script Purpose:
    This script initializes the DataWarehouseAnalytics database and creates
    the Gold schema and its associated tables.

Actions Performed:
    - Switches the execution context to the master database.
    - Drops the existing DataWarehouseAnalytics database if it exists.
    - Creates a new DataWarehouseAnalytics database.
    - Creates the Gold schema.
    - Creates the customer and product dimension tables.
    - Creates the sales fact table.
    - Truncates the Gold tables before loading data.
    - Loads customer, product, and sales data from external CSV files
      using BULK INSERT.

Database Objects Created:
    - gold.dim_customers
    - gold.dim_products
    - gold.fact_sales

Requirements:
    - Microsoft SQL Server.
    - Permission to create and drop databases and schemas.
    - Access to the CSV files specified in the BULK INSERT statements.
    - Read permissions for the SQL Server service account on the CSV directory.

WARNING:
    This script permanently deletes the existing DataWarehouseAnalytics
    database and all its data before recreating it.
    Do not run this script against a database containing data you need to keep.

Configuration:
    Update the CSV file paths in the BULK INSERT statements to match the
    location of the dataset files on your environment.

Usage:
    Review the database name, destructive operations, and file paths before
    executing this script.
===============================================================================
*/
