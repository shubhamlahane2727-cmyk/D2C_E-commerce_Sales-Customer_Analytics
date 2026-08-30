-- ==========================================================
-- D2C-Ecommerce-Analytics
-- View 1: Customer Sales Summary
-- ==========================================================

USE d2c_ecommerce_analytics;

CREATE VIEW vw_customer_sales AS
SELECT
    u.user_id,
    u.name,
    u.city,
    COUNT(o.order_id) AS Total_Orders,
    ROUND(SUM(o.total_amount),2) AS Total_Spent
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name, u.city;


SELECT *
FROM vw_customer_sales;

-- ==========================================================
-- D2C-Ecommerce-Analytics
-- View 2: Product Performance
-- ==========================================================

USE d2c_ecommerce_analytics;

CREATE VIEW vw_product_performance AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.brand,
    SUM(oi.quantity) AS Quantity_Sold,
    ROUND(SUM(oi.item_total),2) AS Revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY
p.product_id,
p.product_name,
p.category,
p.brand;


SELECT *
FROM vw_product_performance;

-- ==========================================================
-- D2C-Ecommerce-Analytics
-- View 3: Monthly Sales
-- ==========================================================

USE d2c_ecommerce_analytics;

CREATE VIEW vw_monthly_sales AS
SELECT
    YEAR(order_date) AS Year,
    MONTH(order_date) AS Month,
    COUNT(order_id) AS Orders,
    ROUND(SUM(total_amount),2) AS Revenue
FROM orders
GROUP BY
YEAR(order_date),
MONTH(order_date);


SELECT *
FROM vw_monthly_sales;