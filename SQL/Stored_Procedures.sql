-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Stored Procedure 1: Customer Details
-- ==========================================================

USE d2c_ecommerce_analytics;

DELIMITER $$

CREATE PROCEDURE GetCustomerOrders(
IN customer VARCHAR(10)
)
BEGIN

SELECT
order_id,
order_date,
total_amount
FROM orders
WHERE user_id = customer;

END $$

DELIMITER ;


CALL GetCustomerOrders('U000001');

CALL GetCustomerOrders('U004512');

-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Stored Procedure 2: Category Revenue
-- ==========================================================

USE d2c_ecommerce_analytics;

DELIMITER $$

CREATE PROCEDURE GetCategoryRevenue(
IN cat VARCHAR(100)
)
BEGIN

SELECT
p.category,
ROUND(SUM(oi.item_total),2) AS Revenue
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id
WHERE p.category=cat
GROUP BY p.category;

END $$

DELIMITER ;


CALL GetCategoryRevenue('Electronics');

CALL GetCategoryRevenue('Beauty');

-- ==========================================================
-- D2C-Ecommerce-Analytics
-- Stored Procedure 3: Customer Lifetime Value
-- ==========================================================

USE d2c_ecommerce_analytics;

DELIMITER $$

CREATE PROCEDURE CustomerLifetimeValue(
IN customer VARCHAR(10)
)
BEGIN

SELECT
u.name,
ROUND(SUM(o.total_amount),2) AS CLV
FROM users u
JOIN orders o
ON u.user_id=o.user_id
WHERE u.user_id=customer
GROUP BY u.name;

END $$

DELIMITER ;


CALL CustomerLifetimeValue('U000001');

CALL CustomerLifetimeValue('U001254');