# 🚀 Data Engineering Portfolio: My ETL Pipeline Journey

Welcome to my central repository for **Data Engineering** projects! This space is dedicated to showcasing my practical, end-to-end projects, specifically focusing on **ETL (Extract, Transform, Load) Pipelines**, **Workflow Orchestration**, and **Analytical Data Warehousing**.

Every project here serves as concrete evidence of my technical capabilities, problem-solving mindset, and dedication toward becoming a professional Data Engineer.

---

## 🎯 Project Objectives & Core Engineering Principles
* **Proof of Technical Competency:** Applying real-world Data Engineering concepts into functional, scalable Python scripts and workflows.
* **Data Quality & Integrity First:** Practicing robust data cleansing (handling missing boundary values, fixing data types, deduplication, regex pattern standardization, and handling edge cases).
* **End-to-End Delivery & Orchestration:** Building complete, automated pipeline lifecycles—from raw API/file ingestion to workflow orchestration, unit testing, and relational database loading (Star Schema modeling).
* **Production Standards:** Following industry best practices including modular code structure, automated unit testing (`pytest`), environment configuration, and clear technical documentation.

---

## 📂 Repository Directory (Project Index)

As I continue to build and scale production-ready architectures, my engineering milestones are systematically indexed below:

| # | Project Name | Tech Stack | Key Description & Focus | Status |
|---|---|---|---|---|
| 1 | [📦 Amazon Sales ETL Pipeline](./amazon-sales-pipeline) | Python (Pandas), MySQL | High-volume e-commerce CSV ingestion pipeline. Cleaned and structured 1,000,000 raw records down to 50,000 database-ready rows. | ✅ Completed |
| 2 | [📊 Real-Time Financial Market Pipeline](./realtime-financial-market-pipeline) | Python (Requests, Pandas), MySQL, SQLAlchemy | Live multi-asset streaming pipeline connecting to public REST APIs for crypto pricing data with dynamic timestamping. | ✅ Completed |
| 3 | [🛒 Customer Analytics & CLV ETL Pipeline](./customer-etl-pipeline) | Python 3.12+, Prefect 3.x, Pandas, SQLite, Pytest | Production-grade orchestrated pipeline for legacy order migration. Features automated workflow DAGs, Star Schema (`dim`/`fct`), currency normalization, unit testing, and CLV reporting. | ✅ Completed |

---

## 🛠️ Core Technical Skills Demonstrated
* **Languages & Scripting:** Python 3.12+, SQL (Complex Joins, Aggregations, Window Functions, EDA Audits)
* **Pipeline Orchestration:** Prefect 3.x (`@task`, `@flow`, workflow dependency management)
* **Data Transformation & Modeling:** Pandas (Data Cleansing, Regex Standardization, Currency Conversion), Dimensional Modeling (Star Schema: Fact & Dimension tables)
* **Database Management & ORM:** MySQL, SQLite, SQLAlchemy, Database Design
* **Testing & Quality Assurance:** Pytest (Isolated Transformation Unit Testing, Assertion Controls)
* **Version Control & Documentation:** Git, GitHub, Professional Technical Documentation

---

## 🏆 Project Spotlight: Customer Analytics ETL Pipeline
My latest project ([`customer-etl-pipeline`](./customer-etl-pipeline)) demonstrates a complete engineering workflow designed for real-world technical assignments:
1. **Exploration & Quality Audit:** Executed `sql/exploration.sql` to identify schema anomalies, negative amounts, and invalid patterns.
2. **Orchestration with Prefect:** Built modular tasks for Extraction, Cleansing/Currency Normalization (USD conversion), and Loading into `analytics.db`.
3. **Data Warehousing & BI:** Formatted outputs into `dim_customers` and `fct_orders`, delivering an analytical SQL query (`clv_report.sql`) for **Customer Lifetime Value (CLV)** reporting.
4. **Automated Testing:** Covered transformation logic with isolated unit tests using `pytest`.

---

### 🐾 About Me
> "An aspiring Data Engineer who believes in learning by doing. I build robust pipelines to convert raw, chaotic data into clean, structured, and analytics-ready assets." 

*Feel free to explore the individual project folders above to inspect source code, SQL scripts, unit tests, and step-by-step documentation!*
