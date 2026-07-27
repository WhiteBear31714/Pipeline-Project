from prefect import flow, task
import pandas as pd
import sqlite3
from pathlib import Path

DB_PATH = Path("data/raw/shopdata.db")

@task
def extract_data():
    with sqlite3.connect(DB_PATH) as conn:
        customers = pd.read_sql_query("SELECT * FROM vw_raw_customers", conn)
        orders = pd.read_sql_query("SELECT * FROM vw_raw_orders", conn)
        rates = pd.read_sql_query("SELECT * FROM vw_exchange_rates", conn)

    print(customers.head())
    print(orders.head())
    print(rates.head())

    return {
        "customers": customers,
        "orders": orders,
        "rates": rates
    }

@task
def transform_data(raw_data):

    customers = raw_data["customers"]
    orders = raw_data["orders"]
    rates = raw_data["rates"]

    # Clean Customers
    customers = customers.drop_duplicates(subset=["customer_id"])
    customers["email"] = customers["email"].fillna("unknown@example.com")
    customers["phone"] = customers["phone"].fillna("").str.replace(r"\D", "", regex=True)

    # ลบรายการยอดเงิน <= 0
    orders = orders[orders["total_amount"] > 0].copy()

    # ถ้า currency ว่าง ให้ถือเป็น USD
    orders["currency"] = orders["currency"].fillna("USD")

    # เชื่อม Exchange Rate ตาม Currency และ Order Date
    orders = orders.merge(
        rates,
        how="left",
        left_on=["currency", "order_date"],
        right_on=["currency", "date"]
    )

    # ถ้าไม่มี Exchange Rate ให้ใช้ 1.0
    orders["rate_to_usd"] = orders["rate_to_usd"].fillna(1.0)

    # คำนวณยอดเป็น USD
    orders["usd_amount"] = (
        orders["total_amount"] * orders["rate_to_usd"]
    )

    # ลบคอลัมน์ที่ไม่จำเป็น
    orders = orders.drop(columns=["date", "rate_to_usd"])

    return {
        "customers": customers,
        "orders": orders
    }

@task
def load_data(cleaned_data):

    # ดึงข้อมูลที่ผ่านการ Clean แล้ว
    customers = cleaned_data["customers"]
    orders = cleaned_data["orders"]

    ANALYTICS_DB_PATH = Path("analytics.db")

    with sqlite3.connect(ANALYTICS_DB_PATH) as conn:
        customers.to_sql(
            "dim_customers",
            conn,
            if_exists="replace",
            index=False
        )

        orders.to_sql(
            "fct_orders",
            conn,
            if_exists="replace",
            index=False
        )

    print(f"Loaded {len(customers)} customers")
    print(f"Loaded {len(orders)} orders")
    print("ETL Pipeline completed successfully!")

@flow
def etl_pipeline():
    raw_data = extract_data()
    cleaned_data = transform_data(raw_data)
    load_data(cleaned_data)

if __name__ == "__main__":
    etl_pipeline()