# 📊 Level 1 (Project 2): Real-Time Financial Market Data Pipeline

### "Multi-Asset Ingestion Pipeline: Ingesting Live Crypto Market Data into MySQL Warehouse using SQLAlchemy"

---

## 🎯 Project Overview & Impact
Following the success of Project 1 (Amazon Sales CSV ETL), this project takes a step forward into **Dynamic & Live Data Integration**. This end-to-end pipeline connects directly to a live REST API to fetch volatile financial asset pricing (Bitcoin & Ethereum). The pipeline automates the extraction, transforms the nested structural response into a standardized schema, appends exact database ingestion timestamps (`fetched_at`), and streams the data directly into a production MySQL database using SQLAlchemy.

**Business Value:** This architecture replaces manual file downloads, creating an automated, centralized historical price data warehouse ready for downstream Analytics, Live Dashboarding, or Financial Alerting systems.

---

## ⚙️ Pipeline Flow & Architecture

1. **Extract (REST API & JSON):**
   * Connected to the CoinGecko Public REST API via Python `requests`.
   * Handled live, high-frequency JSON responses containing multi-currency currency pricing data.

2. **Transform (Pandas & Ingestion Timestamping):**
   * Performed JSON normalization to flatten complex nested dictionary key structures.
   * Standardized text formats, dropped potential null boundaries to ensure strict **Data Integrity**.
   * Engineered a dynamic `fetched_at` timestamp column to log exactly when price points entered the warehouse.

3. **Load (SQLAlchemy & Time-Series DB Automation):**
   * Configured `create_engine` via SQLAlchemy to establish robust Python-to-MySQL communication.
   * Optimized the pipeline using the `if_exists='append'` mechanism, allowing continuous historical record accumulation without overlapping existing records.

---

## 🛠️ Tech Stack & Skills Highlight
* **Data Extraction:** Python Requests (REST API Integration)
* **Data Transformation:** Pandas (JSON Normalization, Schema Cleansing)
* **Database Driver & Engine:** SQLAlchemy & PyMySQL
* **Target Storage:** MySQL Relational Database (Time-Series tracking)
* **Metadata Engineering:** Programmatic Timestamp Generation

---

## 📊 How to Verify Data Ingestion
Log into your MySQL Workbench and run this automated query to verify the time-series live data flow:

```sql
SELECT * FROM live_market_prices 
ORDER BY fetched_at DESC 
LIMIT 10;
