# 📦 Amazon Sales ETL Pipeline Project

### 🎯 Overview & Objective
This project is part of an End-to-End Data Pipeline designed to process and manage a large-scale Amazon E-Commerce dataset. The primary objective is to demonstrate data engineering skills in data cleaning, transformation, and automated structured data loading into a relational database management system (RDBMS).

---

### 🛠️ Tech Stack & Tools
* **Language:** Python
* **Libraries:** Pandas
* **Database Management:** MySQL Workbench
* **Data Source:** Amazon E-Commerce Dataset (Processed from a 1,000,000-row raw dataset)

---

### ⚙️ Pipeline Process

1. **Data Extraction & Cleaning (Python/Pandas):**
   * Processed the raw 1,000,000-row dataset (`amazon_ecommerce_1M`).
   * Handled missing values, cleaned anomalies, and standardized column formats.
   * Sampled 50,000 clean records (`amazon_clean_50k.csv`) to optimize database performance.

2. **Data Loading (MySQL):**
   * Imported the cleaned data into the `amazon_intelligence` database using the MySQL Workbench Table Data Import Wizard.
   * Verified successful ingestion, resulting in the production-ready `amazon_clean_50k` table.

---

### 📊 How to Verify Ingested Data
You can query the database directly in MySQL Workbench using the following SQL script to preview the first 100 rows:

```sql
USE amazon_intelligence;
SELECT * FROM amazon_clean_50k LIMIT 100;
