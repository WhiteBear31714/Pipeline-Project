-- ดูข้อมูลทั้งหมด
SELECT * FROM raw_customers;

-- นับจำนวนข้อมูล
SELECT COUNT(*) AS total_customers
FROM raw_customers;

-- ตรวจ NULL Email
SELECT *
FROM raw_customers
WHERE email IS NULL;

-- ดูรูปแบบ Phone
SELECT DISTINCT phone
FROM raw_customers;

-- ตรวจ NULL Phone
SELECT *
FROM raw_customers
WHERE phone IS NULL;

-- ตรวจ Duplicate customer_id
SELECT customer_id, COUNT(*) AS total
FROM raw_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- ตรวจ Email ผิดรูปแบบ
SELECT *
FROM raw_customers
WHERE email NOT LIKE '%@%.%'
   OR email IS NULL;