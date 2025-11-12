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


DROP TABLE IF EXISTS Assignment_3_dwh.fct_Sales;
CREATE TABLE Assignment_3_dwh.fct_Sales AS
SELECT
    d.date_id,
    s.customer_id,
    s.product_id,
    s.quantity,
    s.total_price
FROM Assignment_3_dwh.stage_sales AS s
JOIN Assignment_3_dwh.dim_Date AS d ON s.order_date = d.full_date;

SELECT * FROM Assignment_3_dwh.fct_Sales
ORDER BY total_price DESC
LIMIT 3;