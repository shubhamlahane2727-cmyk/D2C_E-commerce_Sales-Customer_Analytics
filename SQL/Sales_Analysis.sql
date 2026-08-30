-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Analytical SQL Queries
-- Section 3: Sales_Analysis
-- ==========================================================

USE d2c_ecommerce_analytics;

-- ==========================================================
-- Query 1: Monthly Revenue Trend
-- ==========================================================

SELECT
    YEAR(order_date) AS Year,
    MONTH(order_date) AS Month,
    ROUND(SUM(total_amount),2) AS Total_Revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY Year, Month;

-- ==========================================================
-- Query 2: Monthly Order Trend
-- ==========================================================

SELECT
    YEAR(order_date) AS Year,
    MONTH(order_date) AS Month,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY Year, Month;

-- ==========================================================
-- Query 3: Top 10 Best-Selling Products
-- ==========================================================

SELECT
    p.product_name,
    SUM(oi.quantity) AS Quantity_Sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- ==========================================================
-- Query 4: Top 10 Revenue-Generating Products
-- ==========================================================

SELECT
    p.product_name,
    ROUND(SUM(oi.item_total),2) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================================
-- Query 5: Category-wise Revenue
-- ==========================================================

SELECT
    p.category,
    ROUND(SUM(oi.item_total),2) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY Revenue DESC;

-- ==========================================================
-- Query 6: Brand-wise Revenue
-- ==========================================================

SELECT
    p.brand,
    ROUND(SUM(oi.item_total),2) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.brand
ORDER BY Revenue DESC;

-- ==========================================================
-- Query 7: Top 10 Cities by Revenue
-- ==========================================================

SELECT
    u.city,
    ROUND(SUM(o.total_amount),2) AS Revenue
FROM orders o
JOIN users u
ON o.user_id = u.user_id
GROUP BY u.city
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================================
-- Query 8: Top 10 Highest Value Orders
-- ==========================================================

SELECT
    order_id,
    total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 10;

-- ==========================================================
-- Query 9: Average Quantity per Order
-- ==========================================================

SELECT
    ROUND(AVG(quantity),2) AS Average_Quantity
FROM order_items;

-- ==========================================================
-- Query 10: Revenue by Order Status
-- ==========================================================

SELECT
    order_status,
    ROUND(SUM(total_amount),2) AS Revenue
FROM orders
GROUP BY order_status
ORDER BY Revenue DESC;

-- ==========================================================
-- Query 11: Top 10 Most Ordered Categories
-- ==========================================================

SELECT
    p.category,
    SUM(oi.quantity) AS Quantity_Sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- ==========================================================
-- Query 12: Average Product Price by Category
-- ==========================================================

SELECT
    category,
    ROUND(AVG(price),2) AS Average_Price
FROM products
GROUP BY category
ORDER BY Average_Price DESC;

