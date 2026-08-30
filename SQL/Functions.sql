-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Function 1: Discount Price
-- ==========================================================

USE d2c_ecommerce_analytics;

DELIMITER $$

CREATE FUNCTION DiscountPrice(
price DECIMAL(10,2),
discount DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN

RETURN price-(price*discount/100);

END $$

DELIMITER ;


SELECT
product_name,
price,
DiscountPrice(price,10) AS Discounted_Price
FROM products;

-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Function 2: Revenue Category
-- ==========================================================

USE d2c_ecommerce_analytics;

DELIMITER $$

CREATE FUNCTION RevenueCategory(
amount DECIMAL(10,2)
)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN

RETURN
CASE
WHEN amount>=1000 THEN 'High'
WHEN amount>=500 THEN 'Medium'
ELSE 'Low'
END;

END $$

DELIMITER ;


SELECT
order_id,
total_amount,
RevenueCategory(total_amount)
FROM orders;