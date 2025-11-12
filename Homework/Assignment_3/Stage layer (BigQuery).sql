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