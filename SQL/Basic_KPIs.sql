-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Analytical SQL Queries
-- Section 2: Basic_KPIs
-- ==========================================================

USE d2c_ecommerce_analytics;

-- ==========================================================
-- KPI 1: Total Customers
-- ==========================================================

SELECT COUNT(*) AS Total_Customers
FROM users;

-- ==========================================================
-- KPI 2: Total Products
-- ==========================================================

SELECT COUNT(*) AS Total_Products
FROM products;

-- ==========================================================
-- KPI 3: Total Orders
-- ==========================================================

SELECT COUNT(*) AS Total_Orders
FROM orders;

-- ==========================================================
-- KPI 4: Total Revenue
-- ==========================================================

SELECT
ROUND(SUM(total_amount),2) AS Total_Revenue
FROM orders;

-- ==========================================================
-- KPI 5: Average Order Value (AOV)
-- ==========================================================

SELECT
ROUND(AVG(total_amount),2) AS Average_Order_Value
FROM orders;

-- ==========================================================
-- KPI 6: Total Quantity Sold
-- ==========================================================

SELECT
SUM(quantity) AS Total_Items_Sold
FROM order_items;

-- ==========================================================
-- KPI 7: Total Brands
-- ==========================================================

SELECT
COUNT(DISTINCT brand) AS Total_Brands
FROM products;

-- ==========================================================
-- KPI 8: Total Categories
-- ==========================================================

SELECT
COUNT(DISTINCT category) AS Total_Categories
FROM products;

-- ==========================================================
-- KPI 9: Average Product Rating
-- ==========================================================

SELECT
ROUND(AVG(rating),2) AS Average_Product_Rating
FROM products;

-- ==========================================================
-- KPI 10: Average Customer Review Rating
-- ==========================================================

SELECT
ROUND(AVG(rating),2) AS Average_Review_Rating
FROM reviews;

-- ==========================================================
-- KPI 11: Order Status Distribution
-- ==========================================================

SELECT
order_status,
COUNT(*) AS Total_Orders
FROM orders
GROUP BY order_status
ORDER BY Total_Orders DESC;

-- ==========================================================
-- KPI 12: Revenue by Order Status
-- ==========================================================

SELECT
order_status,
ROUND(SUM(total_amount),2) AS Revenue
FROM orders
GROUP BY order_status
ORDER BY Revenue DESC;