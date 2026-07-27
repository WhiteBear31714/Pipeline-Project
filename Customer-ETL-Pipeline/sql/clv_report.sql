-- Customer Lifetime Value (CLV) Report
-- Calculates:
-- 1. Total orders per customer
-- 2. Total lifetime value in USD
-- 3. Sort customers by highest lifetime value

SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.usd_amount), 2) AS customer_lifetime_value
FROM dim_customers c
LEFT JOIN fct_orders o
ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.full_name
ORDER BY customer_lifetime_value DESC;