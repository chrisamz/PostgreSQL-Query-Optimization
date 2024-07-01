-- denormalization.sql
-- This script applies denormalization techniques to your database schema

-- Example: Combining two tables to reduce JOIN operations

-- Original Tables
-- CREATE TABLE table_a (
--     id SERIAL PRIMARY KEY,
--     column1 VARCHAR(255),
--     column2 VARCHAR(255)
-- );
-- 
-- CREATE TABLE table_b (
--     id SERIAL PRIMARY KEY,
--     a_id INT REFERENCES table_a(id),
--     column3 VARCHAR(255),
--     column4 VARCHAR(255)
-- );

-- Denormalized Table: Combines columns from both table_a and table_b
CREATE TABLE denormalized_table AS
SELECT
    a.id AS a_id,
    a.column1 AS a_column1,
    a.column2 AS a_column2,
    b.id AS b_id,
    b.column3 AS b_column3,
    b.column4 AS b_column4
FROM
    table_a a
JOIN
    table_b b ON a.id = b.a_id;

-- Example: Adding computed columns for performance improvement

-- Original Table
-- CREATE TABLE sales (
--     id SERIAL PRIMARY KEY,
--     product_id INT,
--     quantity INT,
--     unit_price DECIMAL
-- );

-- Denormalized Table with Computed Columns
CREATE TABLE denormalized_sales AS
SELECT
    id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price AS total_price
FROM
    sales;

-- Example: Pre-aggregating data to reduce computation time

-- Original Table
-- CREATE TABLE orders (
--     id SERIAL PRIMARY KEY,
--     customer_id INT,
--     order_date DATE,
--     amount DECIMAL
-- );

-- Denormalized Table with Pre-aggregated Data
CREATE TABLE monthly_sales AS
SELECT
    customer_id,
    DATE_TRUNC('month', order_date) AS month,
    SUM(amount) AS total_amount
FROM
    orders
GROUP BY
    customer_id,
    DATE_TRUNC('month', order_date);

-- Example: Creating a wide table by combining multiple tables

-- Original Tables
-- CREATE TABLE customer (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(255),
--     email VARCHAR(255)
-- );
-- 
-- CREATE TABLE order_summary (
--     id SERIAL PRIMARY KEY,
--     customer_id INT REFERENCES customer(id),
--     total_orders INT,
--     total_spent DECIMAL
-- );
-- 
-- CREATE TABLE last_order (
--     id SERIAL PRIMARY KEY,
--     customer_id INT REFERENCES customer(id),
--     last_order_date DATE
-- );

-- Denormalized Wide Table
CREATE TABLE customer_summary AS
SELECT
    c.id AS customer_id,
    c.name,
    c.email,
    os.total_orders,
    os.total_spent,
    lo.last_order_date
FROM
    customer c
LEFT JOIN
    order_summary os ON c.id = os.customer_id
LEFT JOIN
    last_order lo ON c.id = lo.customer_id;

-- Example: Storing hierarchical data in a denormalized format

-- Original Table
-- CREATE TABLE categories (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(255),
--     parent_id INT REFERENCES categories(id)
-- );

-- Denormalized Table with Hierarchical Data
WITH RECURSIVE category_hierarchy AS (
    SELECT
        id,
        name,
        parent_id,
        name AS full_path
    FROM
        categories
    WHERE
        parent_id IS NULL
    UNION ALL
    SELECT
        c.id,
        c.name,
        c.parent_id,
        ch.full_path || ' > ' || c.name
    FROM
        categories c
    JOIN
        category_hierarchy ch ON c.parent_id = ch.id
)
SELECT
    id,
    name,
    parent_id,
    full_path
INTO
    denormalized_categories
FROM
    category_hierarchy;

-- Example: Flattening a JSONB column into separate columns

-- Original Table
-- CREATE TABLE jsonb_data (
--     id SERIAL PRIMARY KEY,
--     data JSONB
-- );

-- Sample Data
-- INSERT INTO jsonb_data (data) VALUES ('{"key1": "value1", "key2": "value2"}');

-- Denormalized Table with Flattened JSONB Columns
CREATE TABLE denormalized_jsonb_data AS
SELECT
    id,
    data->>'key1' AS key1,
    data->>'key2' AS key2
FROM
    jsonb_data;

-- Example: Materialized View for frequently accessed data

-- Original Query
-- SELECT
--     customer_id,
--     DATE_TRUNC('month', order_date) AS month,
--     SUM(amount) AS total_amount
-- FROM
--     orders
-- GROUP BY
--     customer_id,
--     DATE_TRUNC('month', order_date);

-- Materialized View
CREATE MATERIALIZED VIEW monthly_sales_view AS
SELECT
    customer_id,
    DATE_TRUNC('month', order_date) AS month,
    SUM(amount) AS total_amount
FROM
    orders
GROUP BY
    customer_id,
    DATE_TRUNC('month', order_date);

-- Refresh the materialized view periodically
-- REFRESH MATERIALIZED VIEW monthly_sales_view;
