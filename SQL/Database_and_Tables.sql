-- Create Database
CREATE DATABASE d2c_ecommerce_analytics;

-- Use Database
USE d2c_ecommerce_analytics;

-- Table 1: Users
CREATE TABLE users (
    user_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    gender VARCHAR(10),
    city VARCHAR(100),
    signup_date DATE
);

-- Table 2: Products
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    brand VARCHAR(100),
    price DECIMAL(10,2),
    rating DECIMAL(3,2)
);

-- Table 3: Orders
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10),
    order_date DATETIME,
    order_status VARCHAR(20),
    total_amount DECIMAL(10,2),

    CONSTRAINT fk_orders_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

-- Table 4: Order_Items
CREATE TABLE order_items (
    order_item_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    user_id VARCHAR(10),
    quantity INT,
    item_price DECIMAL(10,2),
    item_total DECIMAL(10,2),

    CONSTRAINT fk_orderitems_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_orderitems_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_orderitems_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
); 

-- Table 5: Reviews
CREATE TABLE reviews (
    review_id VARCHAR(10) PRIMARY KEY,
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    user_id VARCHAR(10),
    rating INT,
    review_text TEXT,
    review_date DATETIME,

    CONSTRAINT fk_reviews_orders
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_reviews_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_reviews_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

-- Table 6: Events
CREATE TABLE events (
    event_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10),
    product_id VARCHAR(10),
    event_type VARCHAR(20),
    event_timestamp DATETIME,

    CONSTRAINT fk_events_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id),

    CONSTRAINT fk_events_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- ==========================================================
-- Database Creation Completed Successfully
-- Total Tables: 6
-- Created By: Shubham Lahane
-- ==========================================================