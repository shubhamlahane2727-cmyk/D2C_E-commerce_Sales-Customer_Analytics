-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Analytical SQL Queries
-- Section 4: Customer_Analysis
-- ==========================================================

USE d2c_ecommerce_analytics;

-- ==========================================================
-- Query 1: Top 10 Customers by Revenue
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    ROUND(SUM(o.total_amount),2) AS Total_Spent
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY Total_Spent DESC
LIMIT 10;

-- ==========================================================
-- Query 2: Top 10 Customers by Number of Orders
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    COUNT(o.order_id) AS Total_Orders
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY Total_Orders DESC
LIMIT 10;

-- ==========================================================
-- Query 3: Average Spending per Customer
-- ==========================================================

SELECT
    ROUND(AVG(Customer_Spending),2) AS Average_Customer_Spending
FROM
(
    SELECT
        user_id,
        SUM(total_amount) AS Customer_Spending
    FROM orders
    GROUP BY user_id
) AS CustomerSpend;

-- ==========================================================
-- Query 4: Customer Lifetime Value
-- ==========================================================

SELECT
    user_id,
    ROUND(SUM(total_amount),2) AS Customer_Lifetime_Value
FROM orders
GROUP BY user_id
ORDER BY Customer_Lifetime_Value DESC
LIMIT 10;

-- ==========================================================
-- Query 5: Repeat Customers
-- ==========================================================

SELECT
    user_id,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY user_id
HAVING COUNT(order_id) > 1
ORDER BY Total_Orders DESC;

-- ==========================================================
-- Query 6: One-Time Customers
-- ==========================================================

SELECT
    COUNT(*) AS One_Time_Customers
FROM
(
    SELECT
        user_id
    FROM orders
    GROUP BY user_id
    HAVING COUNT(order_id)=1
) AS OneTime;

-- ==========================================================
-- Query 7: Customer Distribution by City
-- ==========================================================

SELECT
    city,
    COUNT(*) AS Total_Customers
FROM users
GROUP BY city
ORDER BY Total_Customers DESC;

-- ==========================================================
-- Query 8: Top 10 Cities by Customers
-- ==========================================================

SELECT
    city,
    COUNT(*) AS Total_Customers
FROM users
GROUP BY city
ORDER BY Total_Customers DESC
LIMIT 10;

-- ==========================================================
-- Query 9: New Customers by Signup Month
-- ==========================================================

SELECT
    YEAR(signup_date) AS Year,
    MONTH(signup_date) AS Month,
    COUNT(*) AS New_Customers
FROM users
GROUP BY YEAR(signup_date), MONTH(signup_date)
ORDER BY Year, Month;

-- ==========================================================
-- Query 10: Highest Average Order Value by Customer
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    ROUND(AVG(o.total_amount),2) AS Average_Order_Value
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY Average_Order_Value DESC
LIMIT 10;

-- ==========================================================
-- Query 11: Customer Ranking by Revenue
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    ROUND(SUM(o.total_amount),2) AS Revenue,
    RANK() OVER(
        ORDER BY SUM(o.total_amount) DESC
    ) AS Customer_Rank
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name;

-- ==========================================================
-- Query 12: Customer Purchase Frequency
-- ==========================================================

SELECT
    user_id,
    COUNT(order_id) AS Purchase_Frequency
FROM orders
GROUP BY user_id
ORDER BY Purchase_Frequency DESC;