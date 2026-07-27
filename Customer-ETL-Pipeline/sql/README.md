# 🗄️ SQL Analytics & Data Quality Scripts

### 🎯 Overview & Purpose
This directory contains SQL scripts used in the `customer-etl-pipeline`. The queries are divided into two distinct engineering phases: **Data Quality Exploration (Pre-ETL)** and **Analytical Business Reporting (Post-ETL)**.

---

## 📜 Script Breakdown

### 1. `exploration.sql` (Exploratory Data Analysis & Data Quality Audit)
Executed on the raw database layer (`shopdata.db`) to identify anomalies and inform the data cleaning rules implemented in `pipeline.py`:
* **Data Quality Audits:** Detects missing emails, unformatted phone numbers, and NULL boundaries.
* **Integrity Checks:** Finds duplicated `customer_id` records using `HAVING COUNT(*) > 1`.
* **Pattern Validation:** Flags invalid email formats using `NOT LIKE '%@%.%'`.

### 2. `clv_report.sql` (Customer Lifetime Value Analytics)
Executed on the serving data warehouse layer (`analytics.db`) using the **Star Schema** (`dim_customers` and `fct_orders`):
* **Business Metric:** Calculates total purchase frequency and aggregates lifetime spending in USD (`usd_amount`).
* **Dimensional Joining:** Performs a `LEFT JOIN` between customer dimensions and order facts.
* **Output:** Ranks customers by highest lifetime value (`customer_lifetime_value DESC`) for marketing segmentation.

---

## 📊 Sample Output Query (`clv_report.sql`)

| customer_id | full_name | total_orders | customer_lifetime_value |
| :--- | :--- | :--- | :--- |
| CUST005 | Michael Williams | 42 | 8900.25 |
| CUST002 | Jane Smith | 25 | 3200.00 |
| CUST007 | David Wilson | 15 | 2100.80 |
