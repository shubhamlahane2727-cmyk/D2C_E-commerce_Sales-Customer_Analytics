-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Analytical SQL Queries
-- Section 6: Review_Analysis
-- ==========================================================

USE d2c_ecommerce_analytics;

-- ==========================================================
-- Query 1: Total Reviews
-- ==========================================================

SELECT
    COUNT(*) AS Total_Reviews
FROM reviews;

-- ==========================================================
-- Query 2: Average Review Rating
-- ==========================================================

SELECT
    ROUND(AVG(r.rating),2) AS Average_Rating
FROM reviews r;

-- ==========================================================
-- Query 3: Rating Distribution
-- ==========================================================

SELECT
    r.rating,
    COUNT(*) AS Total_Reviews
FROM reviews r
GROUP BY r.rating
ORDER BY r.rating DESC;

-- ==========================================================
-- Query 4: Top 10 Highest Rated Products
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating),2) AS Average_Rating,
    COUNT(r.review_id) AS Total_Reviews
FROM reviews r
JOIN products p
ON r.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.review_id) >= 5
ORDER BY Average_Rating DESC
LIMIT 10;

-- ==========================================================
-- Query 5: Top 10 Lowest Rated Products
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating),2) AS Average_Rating,
    COUNT(r.review_id) AS Total_Reviews
FROM reviews r
JOIN products p
ON r.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.review_id) >= 5
ORDER BY Average_Rating ASC
LIMIT 10;

-- ==========================================================
-- Query 6: Products with Most Reviews
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    COUNT(r.review_id) AS Total_Reviews
FROM reviews r
JOIN products p
ON r.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY Total_Reviews DESC
LIMIT 10;

-- ==========================================================
-- Query 7: Average Rating by Category
-- ==========================================================

SELECT
    p.category,
    ROUND(AVG(r.rating),2) AS Average_Rating
FROM reviews r
JOIN products p
ON r.product_id = p.product_id
GROUP BY p.category
ORDER BY Average_Rating DESC;

-- ==========================================================
-- Query 8: Average Rating by Brand
-- ==========================================================

SELECT
    p.brand,
    ROUND(AVG(r.rating),2) AS Average_Rating
FROM reviews r
JOIN products p
ON r.product_id = p.product_id
GROUP BY p.brand
ORDER BY Average_Rating DESC;

-- ==========================================================
-- Query 9: Monthly Review Trend
-- ==========================================================

SELECT
    YEAR(r.review_date) AS Year,
    MONTH(r.review_date) AS Month,
    COUNT(*) AS Total_Reviews
FROM reviews r
GROUP BY YEAR(r.review_date), MONTH(r.review_date)
ORDER BY Year, Month;

-- ==========================================================
-- Query 10: Top 10 Customers by Reviews
-- ==========================================================

SELECT
    u.user_id,
    u.name,
    COUNT(r.review_id) AS Total_Reviews
FROM reviews r
JOIN users u
ON r.user_id = u.user_id
GROUP BY u.user_id, u.name
ORDER BY Total_Reviews DESC
LIMIT 10;

-- ==========================================================
-- Query 11: Review Sentiment Summary
-- ==========================================================

SELECT
    CASE
        WHEN rating >= 4 THEN 'Positive'
        WHEN rating = 3 THEN 'Neutral'
        ELSE 'Negative'
    END AS Sentiment,
    COUNT(*) AS Total_Reviews
FROM reviews
GROUP BY Sentiment
ORDER BY Total_Reviews DESC;

-- ==========================================================
-- Query 12: Product Review Ranking
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating),2) AS Average_Rating,
    DENSE_RANK() OVER(
        ORDER BY AVG(r.rating) DESC
    ) AS Rating_Rank
FROM reviews r
JOIN products p
ON r.product_id = p.product_id
GROUP BY p.product_id, p.product_name;