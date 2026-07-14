import requests

# 1. กำลังเชื่อมต่อ REST API เพื่อดึงข้อมูลราคาเรียลไทม์ของ Bitcoin และ Ethereum
url = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum&vs_currencies=usd,thb"
print("กำลังเชื่อมต่อ REST API เพื่อดึงข้อมูลราคาเรียลไทม์...")

# 2. ดึงข้อมูลดิบ JSON จาก API 
response = requests.get(url)
raw_json = response.json()

# 3. แสดงข้อมูลดิบ JSON ที่ดึงมาจาก API
print(raw_json)




















