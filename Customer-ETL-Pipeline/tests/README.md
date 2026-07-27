# 🧪 Automated Pipeline Testing (`tests/`)

### 🎯 Overview & Purpose
This directory contains automated unit test cases built with **Pytest** to ensure data pipeline reliability and data quality assertion before running in production environments.

---

## ⚙️ Test Case Breakdown (`test_pipeline.py`)

* **`test_extract_data()`**:
  * Utilizes `extract_data.fn()` to bypass Prefect task orchestration and test the core extraction logic directly.
  * **Assertions:** Asserts that the extraction result is a valid data dictionary containing all expected database views:
    * `customers` DataFrame
    * `orders` DataFrame
    * `rates` DataFrame

---

## 🛠️ How to Execute Tests
Run Pytest from the root `Customer-ETL-Pipeline` directory:

```bash
pytest tests/
