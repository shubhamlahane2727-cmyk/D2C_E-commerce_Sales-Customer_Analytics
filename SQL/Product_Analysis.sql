-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Analytical SQL Queries
-- Section 5: Product_Analysis
-- ==========================================================

USE d2c_ecommerce_analytics;

-- ==========================================================
-- Query 1: Top 10 Best-Selling Products
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS Quantity_Sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY Quantity_Sold DESC
LIMIT 10;

-- ==========================================================
-- Query 2: Top 10 Revenue-Generating Products
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.item_total),2) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY Revenue DESC
LIMIT 10;

-- ==========================================================
-- Query 3: Lowest Selling Products
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS Quantity_Sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY Quantity_Sold ASC
LIMIT 10;

-- ==========================================================
-- Query 4: Highest Rated Products
-- ==========================================================

SELECT
    product_id,
    product_name,
    rating
FROM products
ORDER BY rating DESC
LIMIT 10;

-- ==========================================================
-- Query 5: Lowest Rated Products
-- ==========================================================

SELECT
    product_id,
    product_name,
    rating
FROM products
ORDER BY rating ASC
LIMIT 10;

-- ==========================================================
-- Query 6: Category-wise Product Count
-- ==========================================================

SELECT
    category,
    COUNT(*) AS Total_Products
FROM products
GROUP BY category
ORDER BY Total_Products DESC;

-- ==========================================================
-- Query 7: Brand-wise Product Count
-- ==========================================================

SELECT
    brand,
    COUNT(*) AS Total_Products
FROM products
GROUP BY brand
ORDER BY Total_Products DESC;

-- ==========================================================
-- Query 8: Average Product Price by Brand
-- ==========================================================

SELECT
    brand,
    ROUND(AVG(price),2) AS Average_Price
FROM products
GROUP BY brand
ORDER BY Average_Price DESC;

-- ==========================================================
-- Query 9: Most Expensive Products
-- ==========================================================

SELECT
    product_id,
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 10;

-- ==========================================================
-- Query 10: Least Expensive Products
-- ==========================================================

SELECT
    product_id,
    product_name,
    price
FROM products
ORDER BY price ASC
LIMIT 10;

-- ==========================================================
-- Query 11: Revenue by Category
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
-- Query 12: Revenue by Brand
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
-- Query 13: Average Rating by Category
-- ==========================================================

SELECT
    category,
    ROUND(AVG(rating),2) AS Average_Rating
FROM products
GROUP BY category
ORDER BY Average_Rating DESC;

-- ==========================================================
-- Query 14: Average Rating by Brand
-- ==========================================================

SELECT
    brand,
    ROUND(AVG(rating),2) AS Average_Rating
FROM products
GROUP BY brand
ORDER BY Average_Rating DESC;

-- ==========================================================
-- Query 15: Product Revenue Ranking
-- ==========================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.item_total),2) AS Revenue,
    RANK() OVER (
        ORDER BY SUM(oi.item_total) DESC
    ) AS Product_Rank
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name;