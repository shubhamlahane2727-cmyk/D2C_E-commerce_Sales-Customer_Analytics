-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Analytical SQL Queries
-- Section 1: Database Validation
-- ==========================================================

USE d2c_ecommerce_analytics

-- ==========================================================
-- Query 1: Total Records
-- ==========================================================

SELECT COUNT(*) AS Total_Users
FROM users;

SELECT COUNT(*) AS Total_Products
FROM products;

SELECT COUNT(*) AS Total_Orders
FROM orders;

SELECT COUNT(*) AS Total_Order_Items
FROM order_items;

SELECT COUNT(*) AS Total_Reviews
FROM reviews;

SELECT COUNT(*) AS Total_Events
FROM events;

-- ==========================================================
-- Query 2: Check Duplicate Users
-- ==========================================================

SELECT user_id, COUNT(*) AS Duplicate_Count
FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;

-- ==========================================================
-- Query 3: Check Duplicate Products
-- ==========================================================

SELECT product_id, COUNT(*) AS Duplicate_Count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- ==========================================================
-- Query 4: Check Duplicate Orders
-- ==========================================================

SELECT order_id, COUNT(*) AS Duplicate_Count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- ==========================================================
-- Query 5: Check Missing Values in Users
-- ==========================================================

SELECT
COUNT(*) AS Total_Rows,
SUM(name IS NULL) AS Missing_Name,
SUM(email IS NULL) AS Missing_Email,
SUM(city IS NULL) AS Missing_City
FROM users;

-- ==========================================================
-- Query 6: Check Missing Values in Products
-- ==========================================================

SELECT
SUM(product_name IS NULL) AS Missing_Product_Name,
SUM(category IS NULL) AS Missing_Category,
SUM(price IS NULL) AS Missing_Price
FROM products;

-- ==========================================================
-- Query 7: Order Status Distribution
-- ==========================================================

SELECT
order_status,
COUNT(*) AS Total_Orders
FROM orders
GROUP BY order_status
ORDER BY Total_Orders DESC;



