
/*
===============================================================================
Script: Database Exploration
===============================================================================
Script Purpose:
    This script explores the database structure and metadata to help understand
    the organization of database objects and the definition of table columns.

Actions Performed:
    - Retrieves a list of tables and views available in the current database.
    - Displays the database catalog, schema, object name, and object type.
    - Retrieves column metadata for the dim_customers table.
    - Displays column names, data types, nullability, and maximum character
      lengths where applicable.

System Views Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS

Usage Notes:
    - Execute this script in the database you want to explore.
    - The results depend on the current database context and the permissions
      of the executing user.
    - The column metadata query filters by table name and may return matching
      tables from multiple schemas if they share the same name.

Note:
    This script only retrieves metadata. It does not create, modify, or delete
    database objects or data.
===============================================================================
*/

-- Retrieve a list of all tables in the database
SELECT
    TABLE_CATALOG,
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- Retrieve all columns for a specific table (dim_customers)
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';
