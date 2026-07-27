# ⚡ Prefect Orchestrated ETL Pipeline (`pipeline.py`)

### 🎯 Overview & Architecture
This script defines the core automated ETL orchestration using **Prefect**, an enterprise-grade workflow orchestration framework. It automates the pipeline flow from reading raw views in `shopdata.db`, cleaning and performing currency conversions, to serving dimensional modeled tables into `analytics.db`.

---

## ⚙️ Workflow Breakdown (`@task` & `@flow`)

### 1. `extract_data()` Task
* Connects to SQLite `data/raw/shopdata.db`.
* Ingests raw data from three database views:
  * `vw_raw_customers`
  * `vw_raw_orders`
  * `vw_exchange_rates`

### 2. `transform_data(raw_data)` Task
* **Data Cleaning:** Drops duplicate `customer_id` records and replaces null emails with `unknown@example.com`.
* **Regex Standardizing:** Cleans non-numeric characters from phone numbers (`\D`).
* **Validation & Currency Conversion:**
  * Filters out invalid transactions (`total_amount <= 0`).
  * Fills missing currencies default to `USD`.
  * Merges order records with `vw_exchange_rates` by currency and transaction date.
  * Dynamically computes `usd_amount = total_amount * rate_to_usd`.

### 3. `load_data(cleaned_data)` Task
* Establishes connection to the analytical warehouse `analytics.db`.
* Writes transformed outputs into a **Star Schema / Dimensional Model**:
  * **`dim_customers`**: Standardized customer profiles table.
  * **`fct_orders`**: Transactional fact table with unified USD monetary metrics.

### 4. `etl_pipeline()` Flow
* Acts as the parent DAG/Flow connecting and managing dependencies for Extract ➔ Transform ➔ Load tasks.

---

## 🛠️ How to Run
Ensure `prefect` and `pandas` are installed in your environment:

```bash
pip install prefect pandas
python pipeline.py

