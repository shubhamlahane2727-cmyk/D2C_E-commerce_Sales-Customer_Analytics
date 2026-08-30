-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Analytical SQL Queries
-- Section 7: Event_Analysis
-- ==========================================================

USE d2c_ecommerce_analytics;

-- ==========================================================
-- Query 1: Total Events
-- ==========================================================

SELECT
    COUNT(*) AS Total_Events
FROM events;

-- ==========================================================
-- Query 2: Event Distribution
-- ==========================================================

SELECT
    event_type,
    COUNT(*) AS Total_Events
FROM events
GROUP BY event_type
ORDER BY Total_Events DESC;

-- ==========================================================
-- Query 3: Monthly Event Trend
-- ==========================================================

SELECT
    YEAR(event_timestamp) AS Year,
    MONTH(event_timestamp) AS Month,
    COUNT(*) AS Total_Events
FROM events
GROUP BY YEAR(event_timestamp), MONTH(event_timestamp)
ORDER BY Year, Month;

-- ==========================================================
-- Query 4: Most Viewed Products
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    COUNT(*) AS Total_Views
FROM events e
JOIN products p
ON e.product_id = p.product_id
WHERE e.event_type = 'view'
GROUP BY p.product_id, p.product_name
ORDER BY Total_Views DESC
LIMIT 10;

-- ==========================================================
-- Query 5: Most Added-to-Cart Products
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    COUNT(*) AS Cart_Count
FROM events e
JOIN products p
ON e.product_id = p.product_id
WHERE e.event_type = 'cart'
GROUP BY p.product_id, p.product_name
ORDER BY Cart_Count DESC
LIMIT 10;

-- ==========================================================
-- Query 6: Most Purchased Products
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    COUNT(*) AS Purchase_Count
FROM events e
JOIN products p
ON e.product_id = p.product_id
WHERE e.event_type = 'purchase'
GROUP BY p.product_id, p.product_name
ORDER BY Purchase_Count DESC
LIMIT 10;

-- ==========================================================
-- Query 7: Top 10 Active Users
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    COUNT(*) AS Total_Events
FROM events e
JOIN users u
ON e.user_id = u.user_id
GROUP BY u.user_id, u.name
ORDER BY Total_Events DESC
LIMIT 10;

-- ==========================================================
-- Query 8: Event Count by Category
-- ==========================================================

SELECT
    p.category,
    COUNT(*) AS Total_Events
FROM events e
JOIN products p
ON e.product_id = p.product_id
GROUP BY p.category
ORDER BY Total_Events DESC;

-- ==========================================================
-- Query 9: Conversion Funnel
-- ==========================================================

SELECT
    event_type,
    COUNT(*) AS Total_Events,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM events),
        2
    ) AS Percentage
FROM events
GROUP BY event_type
ORDER BY Percentage DESC;

-- ==========================================================
-- Query 10: Product Engagement Ranking
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    COUNT(*) AS Total_Interactions,
    RANK() OVER(
        ORDER BY COUNT(*) DESC
    ) AS Engagement_Rank
FROM events e
JOIN products p
ON e.product_id = p.product_id
GROUP BY p.product_id, p.product_name;