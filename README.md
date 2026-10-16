# SQL Data Warehouse and Analytics Project

**Author:** Laura Rubio Caballero

## Overview

This project demonstrates the development of a SQL-based Data Warehouse and analytical reporting layer using Microsoft SQL Server. It focuses on exploring business data, analyzing sales performance, and transforming raw business information into meaningful insights through SQL queries and analytical views.

The project includes data exploration, business metrics, time-based analysis, customer and product segmentation, and reporting.

## Objectives

- Explore and understand customer, product, and sales data.
- Analyze key business metrics, including revenue, quantity sold, orders, and customers.
- Identify sales trends and changes over time.
- Evaluate product and customer performance.
- Apply SQL techniques to support business intelligence and data-driven decision-making.
- Build analytical views that consolidate business information into customer and product reports.

## Data Architecture

The analytical layer follows a dimensional modeling approach, organizing data into customer and product dimensions and a sales fact view.

- **`gold.dim_customers`** — Customer attributes and demographic information.
- **`gold.dim_products`** — Product attributes, categories, and cost information.
- **`gold.fact_sales`** — Sales transactions and associated measures.
- **`gold.report_customers`** — Customer-level metrics, purchasing behavior, and segmentation.
- **`gold.report_products`** — Product-level metrics, sales performance, and segmentation.

## Technologies Used

- **Microsoft SQL Server** — Database engine.
- **SQL Server Management Studio (SSMS)** — SQL development and database management.
- **T-SQL** — Data exploration, aggregation, transformations, and analytical reporting.
- **Git and GitHub** — Version control and project documentation.

## Project Contents

### Data Exploration

The exploration scripts demonstrate different techniques for understanding and analyzing the data:

| Script | Description |
|---|---|
| `02_dimensions_exploration.sql` | Explores unique customer countries and product combinations. |
| `03_date_range_exploration.sql` | Examines date ranges and customer birthdates. |
| `04_measures_exploration.sql` | Calculates key business metrics. |
| `05_magnitude_analysis.sql` | Analyzes customers, products, revenue, and quantities across dimensions. |
| `06_ranking_analysis.sql` | Ranks products and customers by business performance. |
| `07_change_over_time_analysis.sql` | Examines monthly sales trends. |
| `08_cumulative_analysis.sql` | Calculates cumulative sales and running averages. |
| `09_performance_analysis.sql` | Compares yearly product sales with historical averages and previous years. |
| `10_part_to_whole_analysis.sql` | Measures each product category's contribution to total sales. |
| `11_data_segmentation.sql` | Segments products by cost and customers by spending and purchasing history. |

### Analytical Reports

| Script | Description |
|---|---|
| `12_report_customers.sql` | Creates a customer report with demographic information, purchasing metrics, and customer segments. |
| `13_report_products.sql` | Creates a product report with sales metrics, performance segments, and revenue indicators. |

## Key SQL Concepts

This project applies a range of SQL techniques, including:

- Aggregate functions: `SUM()`, `AVG()`, `COUNT()`, `MIN()`, and `MAX()`.
- Joins: `LEFT JOIN`.
- Common Table Expressions (CTEs).
- Window functions: `RANK()`, `LAG()`, and aggregate functions with `OVER()`.
- Date functions: `DATEDIFF()`, `DATETRUNC()`, `YEAR()`, `MONTH()`, and `GETDATE()`.
- Conditional logic with `CASE`.
- Data segmentation and ranking.
- Cumulative calculations and year-over-year comparisons.
- Analytical views for customer and product reporting.

## Business Insights

The analytical queries are designed to help answer questions such as:

- Which product categories generate the most revenue?
- Which products and customers contribute most to sales?
- How do sales change over time?
- How does each category contribute to total revenue?
- Which customers qualify as VIP, Regular, or New under the defined segmentation rules?
- Which products are classified as high, mid-range, or low performers?
- How do customer purchasing patterns and product sales performance vary?

## Getting Started

### Prerequisites

- Microsoft SQL Server.
- SQL Server Management Studio (SSMS).
- Access to the database objects referenced by the scripts.

### Execution

1. Clone or download this repository.
2. Open SQL Server Management Studio and connect to your SQL Server instance.
3. Select the database containing the `gold` schema and its associated objects.
4. Execute the exploration scripts in order, beginning with `02_dimensions_exploration.sql`.
5. Review the analytical results and execute the customer and product reporting scripts as appropriate.

**Note:** The scripts depend on existing database objects in the `gold` schema. Ensure that the required tables and views are available before running them. Execution order and dependencies may vary depending on your database setup.

## Project Status

The repository contains SQL scripts for exploratory analysis, business metrics, customer and product segmentation, and analytical reporting.

Additional documentation and improvements may be incorporated as the project evolves.

## Author

**Laura Rubio Caballero**

This project reflects my continued development in SQL, data analytics, database design, and business intelligence.

---

*Built with SQL Server and T-SQL.*
