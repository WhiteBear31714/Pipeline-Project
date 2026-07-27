# 📂 Raw Data Source: `shopdata.db`

### 🎯 Business Context & Purpose
This directory stores the **unprocessed source database** (`shopdata.db`) representing an e-commerce platform's transactional system. It serves as the primary **Extract** layer for the `customer-etl-pipeline`.

---

## 📊 Source Database Schema & Data Dictionary

The source SQLite database contains raw customer transaction tables structured as follows:

### 1. `customers` Table
* **`customer_id`** *(VARCHAR/INTEGER)*: Unique identifier for each registered customer.
* **`first_name` / `last_name`** *(TEXT)*: Customer's personal name attributes.
* **`email`** *(TEXT)*: Contact email address.
* **`join_date`** *(DATE/TEXT)*: Registration date of the customer.

### 2. `orders` Table
* **`order_id`** *(VARCHAR/INTEGER)*: Unique identifier for each purchasing transaction.
* **`customer_id`** *(VARCHAR/INTEGER)*: Foreign key connecting to the `customers` table.
* **`order_date`** *(DATETIME)*: Exact timestamp when the order was placed.
* **`amount`** *(NUMERIC)*: Monetary value of the order transaction.

---

## ⚠️ Known Data Quality Challenges (For Pipeline Cleaning)
To simulate real-world data engineering challenges, this raw dataset intentionally contains dirty data that will be cleansed during the **Transform** stage in `pipeline.py`:
* **Missing & Null Values:** Incomplete customer profile fields.
* **Schema Standards:** Inconsistent text casings (uppercase vs. lowercase names/emails).
* **Data Types:** Unformatted date strings requiring standard datetime conversions.

---
*Note: This data is restricted to read-only access. The automated pipeline ingests this file and outputs cleaned target tables into the root `analytics.db` warehouse.*
