# Customer ETL Pipeline — Data Engineer Technical Assignment

## Overview

This project was built for the **Data Engineer Technical Assignment** from Digital Storemesh Co., Ltd. (ShopData Inc. case study).

The goal is to migrate legacy order management data into a clean analytics data warehouse. The raw data — exposed through SQLite views — contains historical inconsistencies, missing values, and formatting issues. This pipeline extracts, cleans, and loads the data into an analytical format so the BI team can report on **Customer Lifetime Value (CLV)**.

---

## Project Structure

```
customer-etl-pipeline/
│
├── data/
│   └── raw/
│       └── shopdata.db          # Source database (read-only views)
├── sql/
│   ├── exploration.sql          # Data quality / anomaly exploration queries
│   └── clv_report.sql           # Customer Lifetime Value analytical query
├── tests/
│   └── test_pipeline.py         # Unit tests for transformation logic
├── pipeline.py                  # Prefect ETL flow (Extract -> Transform -> Load)
├── analytics.db                 # Output data warehouse (generated after running the pipeline)
├── requirements.txt             # Python dependencies
├── .gitignore
└── README.md
```

---

## Tech Stack

- **Python 3.12+**
- **Prefect 3.x** — pipeline orchestration (`@task` / `@flow`)
- **pandas** — data cleaning and transformation
- **SQLite** — source (`shopdata.db`) and target (`analytics.db`) storage
- **pytest** — unit testing
- **Git** — version control

---

## How the Project Was Built (Process Timeline)

### 1. Requirement Analysis
Read through the assignment and broke it down into a standard ETL flow:

```
Source DB (SQLite views) → Extract → Transform (Cleaning) → Load → SQL Report (CLV) → Unit Tests
```

### 2. Project Setup
Created the repository structure (`data/`, `sql/`, `tests/`, `pipeline.py`, `requirements.txt`, `README.md`) and placed the provided `shopdata.db` file under `data/raw/`.

### 3. Data Exploration
Opened `shopdata.db` using DB Browser for SQLite to understand the schema, row counts, and relationships between the source views:

- `vw_raw_customers` — customer demographics and contact info
- `vw_raw_orders` — transactional order data
- `vw_exchange_rates` — daily currency exchange rates to USD

Wrote `exploration.sql` using `COUNT()`, `GROUP BY`, `HAVING`, `IS NULL`, and `LIKE` to check for:

- NULL values
- Duplicate records
- Invalid email formats
- Missing/invalid primary keys
- Row counts per table

### 4. Extract
Built the `extract_data()` task in `pipeline.py` using Prefect. It connects to `shopdata.db`, reads the three source views, and loads them into pandas DataFrames.

### 5. Transform
The most time-consuming stage, split into two parts:

**Customers**
- Deduplicated records, keeping the row with the most recent `signup_date`
- Standardized the `phone` column by stripping all non-numeric characters (e.g. `+1 (555) 123-4567` → `15551234567`)
- Filled missing emails with `"unknown@domain.com"`

**Orders**
- Filtered out orders where `total_amount <= 0` (treated as system errors)
- Merged orders with `vw_exchange_rates` on `order_date`/currency
- Calculated `usd_amount`; if a currency was missing or had no matching rate, it was assumed to already be in USD
- Dropped unnecessary columns before returning the cleaned DataFrame

### 6. Load
Created a new SQLite database, `analytics.db`, and wrote the cleaned data using `to_sql()`:

- `customers` → `dim_customers`
- `orders` → `fct_orders`

### 7. Run & Validate the Pipeline
Ran `python pipeline.py` and confirmed that Extract → Transform → Load executed successfully end-to-end. Inspected `analytics.db` to confirm the data was clean and ready for analysis.

### 8. SQL Analytics
Wrote `clv_report.sql` using `JOIN`, `COUNT()`, `SUM()`, `ROUND()`, `GROUP BY`, and `ORDER BY` to calculate Customer Lifetime Value, returning:

- `customer_id`
- `full_name`
- `total_orders_placed`
- `lifetime_value_usd`
- `customer_cohort` (signup year-month, e.g. `2023-01`)

Results are ranked by `lifetime_value_usd` in descending order.

### 9. Testing
Installed `pytest` and wrote `test_pipeline.py` to test the transformation logic in isolation (using dummy data/DataFrames rather than a live database connection), covering functions such as the phone number standardizer and the currency conversion logic.

### 10. Packaging
Created `requirements.txt` (pandas, prefect, pytest) and a `.gitignore`, and organized the repository for submission.

### 11. Documentation
Wrote this README to summarize the project, ETL flow, folder structure, tech stack, how to run it, and expected output.

---

## Pipeline Flow Summary

```text
Requirement Analysis
        │
Project Structure Setup
        │
Database Exploration
        │
Data Quality Check
        │
Extract  (vw_raw_customers, vw_raw_orders, vw_exchange_rates)
        │
Transform (dedupe, clean phone/email, filter invalid orders, convert to USD)
        │
Load  (dim_customers, fct_orders → analytics.db)
        │
Run ETL Pipeline (Prefect flow)
        │
Validate analytics.db
        │
Write CLV SQL Report
        │
Unit Testing (pytest)
        │
Finalize requirements.txt / .gitignore / README.md
        │
Push to GitHub
```

---

## How to Run

1. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

2. **Run the ETL pipeline**
   ```bash
   python pipeline.py
   ```
   This reads from `data/raw/shopdata.db`, cleans the data, and writes `dim_customers` and `fct_orders` tables into `analytics.db`.

3. **Run the unit tests**
   ```bash
   python -m pytest
   ```

4. **Run the CLV report**
   Execute `sql/clv_report.sql` against `analytics.db` using your preferred SQLite client (e.g. DB Browser for SQLite, or the `sqlite3` CLI):
   ```bash
   sqlite3 analytics.db < sql/clv_report.sql
   ```

---

## Data Quality Findings (from `exploration.sql`)

A summary of data quality issues discovered during exploration:

1. **Duplicate customer records** — some customers appear more than once, with the most recent `signup_date` representing the correct/updated record.
2. **Missing/invalid emails** — a portion of records had NULL or malformed email addresses.
3. **Inconsistent phone formatting** — phone numbers were stored in various formats (with symbols, spaces, country codes, etc.) and needed to be standardized to digits only.
4. **Negative or zero order amounts** — a number of orders had `total_amount <= 0`, indicating system errors that needed to be filtered out.
5. **Missing/mismatched currency exchange rates** — some orders referenced currencies or dates with no matching entry in `vw_exchange_rates`.

---

## What I Learned From This Project

- Analyzing requirements thoroughly before writing any code
- Profiling and assessing data quality using SQL
- Building an ETL pipeline with Prefect (`@task`, `@flow`, logging, error handling)
- Using pandas for data cleaning and transformation
- Loading cleaned data into a SQLite-based analytical warehouse
- Writing SQL to calculate business metrics such as Customer Lifetime Value (CLV)
- Writing isolated unit tests with `pytest`
- Structuring a project and its documentation for a professional GitHub submission
