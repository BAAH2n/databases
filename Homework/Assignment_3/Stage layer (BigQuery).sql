DROP TABLE IF EXISTS Assignment_3_dwh.stage_customers;
CREATE TABLE Assignment_3_dwh.stage_customers AS
SELECT
    user_id AS customer_id,
    MAX(full_name) AS customer_name,
    MAX(email) AS email
FROM Assignment_3_dwh.users_db
WHERE user_id IS NOT NULL
GROUP BY user_id;

DROP TABLE IF EXISTS Assignment_3_dwh.stage_products;
CREATE TABLE Assignment_3_dwh.stage_products AS
SELECT
    id AS product_id,
    MAX(product_name) AS product_type,
    MAX(design_type) AS faculty_design,
    MAX(size_option) AS size
FROM Assignment_3_dwh.products_db
WHERE id IS NOT NULL 
GROUP BY id;

DROP TABLE IF EXISTS Assignment_3_dwh.stage_sales;
CREATE TABLE Assignment_3_dwh.stage_sales AS
SELECT
    transaction_id,
    MAX(customer_user_id) AS customer_id,
    MAX(product_sku) AS product_id,
    MAX(quantity_sold) AS quantity,
    MAX(total_amount) AS total_price,
    MAX(CAST(transaction_timestamp AS DATE)) AS order_date
FROM Assignment_3_dwh.payments_transactions_db
WHERE 
    transaction_id IS NOT NULL 
    AND customer_user_id IS NOT NULL
    AND product_sku IS NOT NULL
GROUP BY transaction_id; 

DROP TABLE IF EXISTS Assignment_3_dwh.dim_Customer;
CREATE TABLE Assignment_3_dwh.dim_Customer AS
SELECT * FROM Assignment_3_dwh.stage_customers;

DROP TABLE IF EXISTS Assignment_3_dwh.dim_Product;
CREATE TABLE Assignment_3_dwh.dim_Product AS
SELECT * FROM Assignment_3_dwh.stage_products;

DROP TABLE IF EXISTS Assignment_3_dwh.dim_Date;
CREATE TABLE Assignment_3_dwh.dim_Date AS
SELECT
    CAST(FORMAT_DATE('%Y%m%d', order_date) AS INT64) AS date_id,
    order_date AS full_date,
    EXTRACT(DAY FROM order_date) AS day,
    FORMAT_DATE('%B', order_date) AS month_name,
    EXTRACT(YEAR FROM order_date) AS year
FROM Assignment_3_dwh.stage_sales;
