# D2C E-Commerce Sales & Customer Analytics

An end-to-end **D2C (Direct-to-Consumer) E-Commerce Analytics** project built using **MySQL, Python, and Power BI** to analyze sales performance, customer behavior, product performance, reviews, and website engagement.

## 📌 Project Overview

This project demonstrates a complete analytics workflow:

**Relational Database → SQL Analysis → Python EDA → Power BI Dashboards → Business Insights**

The objective is to transform raw e-commerce data into meaningful insights that support data-driven business decisions.

## 🎯 Business Problems

The analysis focuses on questions such as:

- How much revenue and how many orders does the business generate?
- Which products, categories, and brands perform best?
- Who are the highest-value and repeat customers?
- How does revenue change over time?
- Which products receive the most reviews and engagement?
- How do customers move through the View → Cart → Purchase journey?
- Which cities contribute most to sales and customers?

## 🗃️ Database Structure

The project uses **6 interconnected relational tables**:

| Table | Purpose |
|---|---|
| `users` | Customer details and signup information |
| `products` | Product, category, brand, price, and rating details |
| `orders` | Customer orders, dates, status, and order value |
| `order_items` | Products and quantities included in each order |
| `reviews` | Customer reviews and product ratings |
| `events` | Website activity such as views, cart actions, and purchases |

### Key Relationships

- `users.user_id` → `orders.user_id`
- `users.user_id` → `reviews.user_id`
- `users.user_id` → `events.user_id`
- `products.product_id` → `order_items.product_id`
- `products.product_id` → `reviews.product_id`
- `products.product_id` → `events.product_id`

The ER diagram is available in `ER_Diagram.png`.

## 🧮 SQL Analysis

More than **80 analytical SQL queries** were developed covering:

- Basic KPIs
- Sales Analysis
- Customer Analysis
- Product Analysis
- Review Analysis
- Event Analysis
- Advanced SQL Analysis

### SQL Concepts Used

- SELECT, WHERE, ORDER BY
- Aggregate Functions
- SUM(), AVG(), COUNT()
- GROUP BY and HAVING
- JOINs
- CASE Statements
- Subqueries
- CTEs
- Window Functions
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- NTILE()
- LAG()
- Views
- Stored Procedures
- User Defined Functions (UDFs)

### Advanced Database Objects

**3 SQL Views**
- Customer Sales Summary
- Product Performance
- Monthly Sales

**3 Stored Procedures**
- Customer Orders
- Category Revenue
- Customer Lifetime Value

**2 User Defined Functions**
- Discount Price
- Revenue Category

## 🐍 Python Analysis

Python was used for data preparation, exploratory data analysis, and visualization.

### Libraries Used

- **Pandas** — data loading, cleaning, transformation, and analysis
- **NumPy** — numerical operations
- **Matplotlib** — data visualization
- **Seaborn** — statistical visualization

### Python Analysis Includes

- Data inspection
- Missing-value checks
- Duplicate checks
- Data cleaning
- Data transformation
- Descriptive statistics
- Sales trend analysis
- Customer behavior analysis
- Product performance analysis
- Review analysis
- Business data visualization

## 📊 Power BI Dashboards

The project includes **4 interactive Power BI dashboards**:

### Dashboard 1 — D2C E-Commerce Sales & Customer Analytics

Focuses on overall business performance, revenue trends, orders, ratings, brands, and order status.

### Dashboard 2 — Customer Analytics

Analyzes customer spending, repeat customers, customer distribution, signup trends, and customer demographics.

### Dashboard 3 — Product & Sales Analytics

Analyzes product sales, revenue contribution, category performance, and product-level performance.

### Dashboard 4 — Website Engagement Analytics

Analyzes customer events and the **View → Cart → Purchase** engagement funnel.

### Power BI Features

- KPI Cards
- Interactive Charts
- Slicers
- Filters
- Trend Analysis
- Category and Brand Analysis
- Customer Analysis
- Business Performance Monitoring

## 💡 Key Business Insights

- Top-selling products contribute significantly to overall revenue.
- Beauty and Electronics are among the strongest-performing categories.
- Repeat customers contribute an important share of revenue.
- Positive reviews dominate overall customer feedback.
- Customer engagement follows a clear **View → Cart → Purchase** journey.
- Revenue and customer performance vary across cities, products, brands, and categories.

## 🛠️ Technologies Used

- MySQL
- SQL
- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Power BI
- DAX
- GitHub

## 👨‍💻 Author

**Shubham Sominath Lahane**

B.Tech Information Technology | Data Analytics

**Skills:** SQL | MySQL | Python | Power BI | Data Visualization
