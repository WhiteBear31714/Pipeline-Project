# 📊 Level 1 (Project 2): Real-Time Financial Market Data Pipeline

### "Multi-Asset Ingestion Pipeline: Phase 1 - Live Data Extraction from REST API"

---

## 🎯 Project Overview
Following the success of Project 1 (Amazon Sales CSV ETL), this project steps into **Dynamic & Live Data Integration**. This pipeline is designed to connect directly to public financial REST APIs to fetch volatile market pricing. 

Currently, **Phase 1 (Data Extraction)** is complete. The script successfully connects to a live endpoint, authenticates the request, and retrieves high-frequency market prices in a raw JSON format.

---

## ⚙️ Pipeline Progress Checklist
- [x] **Phase 1: Data Extraction (REST API & JSON)**
- [ ] Phase 2: Data Transformation (Pandas & Ingestion Timestamping)
- [ ] Phase 3: Data Loading (SQLAlchemy & MySQL Integration)

---

## 🛠️ Tech Stack & Skills (Current Phase)
* **Data Extraction:** Python Requests Library
* **API Protocol:** REST API Integration
* **Data Format:** JSON (JavaScript Object Notation) Handling

---

### 🚀 Next Steps
The pipeline is currently initialized. In the next iteration, I will implement **Pandas Transformation** to flatten the nested structures, inject active production timestamps (`fetched_at`), and automate data ingestion directly into a MySQL Server using **SQLAlchemy**.
