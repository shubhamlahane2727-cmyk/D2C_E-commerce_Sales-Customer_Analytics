-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Analytical SQL Queries
-- Section 8: Advanced_SQL
-- ==========================================================

USE d2c_ecommerce_analytics;

-- ==========================================================
-- Query 1: Customer Revenue Ranking
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    ROUND(SUM(o.total_amount),2) AS Revenue,
    RANK() OVER(
        ORDER BY SUM(o.total_amount) DESC
    ) AS Revenue_Rank
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name;

-- ==========================================================
-- Query 2: Running Total Revenue
-- ==========================================================

SELECT
    order_date,
    total_amount,
    SUM(total_amount) OVER(
        ORDER BY order_date
    ) AS Running_Total
FROM orders;

-- ==========================================================
-- Query 3: Monthly Revenue
-- ==========================================================

SELECT
    YEAR(order_date) AS Year,
    MONTH(order_date) AS Month,
    ROUND(SUM(total_amount),2) AS Revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY Year, Month;

-- ==========================================================
-- Query 4: Revenue Contribution Percentage
-- ==========================================================

SELECT
    user_id,
    ROUND(SUM(total_amount),2) AS Revenue,
    ROUND(
        SUM(total_amount)*100/
        (SELECT SUM(total_amount) FROM orders),
        2
    ) AS Revenue_Percentage
FROM orders
GROUP BY user_id
ORDER BY Revenue DESC;

-- ==========================================================
-- Query 5: Top 5 Products in Each Category
-- ==========================================================

WITH ProductRevenue AS
(
SELECT
    p.category,
    p.product_name,
    SUM(oi.item_total) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.category,p.product_name
)

SELECT *
FROM
(
SELECT
    *,
    ROW_NUMBER() OVER(
        PARTITION BY category
        ORDER BY Revenue DESC
    ) AS Ranking
FROM ProductRevenue
)t
WHERE Ranking<=5;

-- ==========================================================
-- Query 6: Top Customer in Each City
-- ==========================================================

WITH CustomerRevenue AS
(
SELECT
    u.city,
    u.user_id,
    u.name,
    SUM(o.total_amount) Revenue
FROM users u
JOIN orders o
ON u.user_id=o.user_id
GROUP BY u.city,u.user_id,u.name
)

SELECT *
FROM
(
SELECT
    *,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY Revenue DESC
    ) AS City_Rank
FROM CustomerRevenue
)t
WHERE City_Rank=1;

-- ==========================================================
-- Query 7: Customer Purchase Frequency
-- ==========================================================

SELECT
    user_id,
    COUNT(order_id) AS Orders,
    DENSE_RANK() OVER(
        ORDER BY COUNT(order_id) DESC
    ) AS Purchase_Rank
FROM orders
GROUP BY user_id;

-- ==========================================================
-- Query 8: Average Days Between Orders
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    ROUND(AVG(DATEDIFF(o.order_date, u.signup_date)), 2) AS Avg_Days_To_Order
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY Avg_Days_To_Order DESC;

-- ==========================================================
-- Query 9: Monthly Revenue Growth
-- ==========================================================

WITH MonthlyRevenue AS
(
    SELECT
        YEAR(order_date) AS Year,
        MONTH(order_date) AS Month,
        SUM(total_amount) AS Revenue
    FROM orders
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    Year,
    Month,
    Revenue,
    COALESCE(
        LAG(Revenue) OVER (ORDER BY Year, Month),
        0
    ) AS Previous_Revenue,
    COALESCE(
        ROUND(
            (Revenue - LAG(Revenue) OVER (ORDER BY Year, Month))
            * 100 /
            LAG(Revenue) OVER (ORDER BY Year, Month),
            2
        ),
        0
    ) AS MoM_Growth_Percentage
FROM MonthlyRevenue;

-- ==========================================================
-- Query 10: Highest Order Value per Customer
-- ==========================================================

SELECT
    user_id,
    MAX(total_amount) Highest_Order_Value
FROM orders
GROUP BY user_id
ORDER BY Highest_Order_Value DESC;

-- ==========================================================
-- Query 11: Customer Order Sequence
-- ==========================================================

SELECT
    user_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER(
        PARTITION BY user_id
        ORDER BY order_date
    ) AS Order_Number
FROM orders;

-- ==========================================================
-- Query 12: Product Revenue Ranking by Category
-- ==========================================================

SELECT
    p.category,
    p.product_name,
    SUM(oi.item_total) Revenue,
    DENSE_RANK() OVER(
        PARTITION BY p.category
        ORDER BY SUM(oi.item_total) DESC
    ) AS Category_Rank
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
GROUP BY p.category,p.product_name;

-- ==========================================================
-- Query 13: Customer Revenue Percentile
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    SUM(o.total_amount) AS Revenue,
    NTILE(4) OVER (
        ORDER BY SUM(o.total_amount) DESC
    ) AS Revenue_Quartile
FROM users u
JOIN orders o
ON u.user_id = o.user_id
GROUP BY u.user_id, u.name;