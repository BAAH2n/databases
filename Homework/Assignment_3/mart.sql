DROP TABLE IF EXISTS dim_Customer;
CREATE TABLE dim_Customer AS
SELECT * FROM stage_customers;

DROP TABLE IF EXISTS dim_Product;
CREATE TABLE dim_Product AS
SELECT * FROM stage_products;

DROP TABLE IF EXISTS dim_Date;
CREATE TABLE dim_Date AS
SELECT
    CAST(DATE_FORMAT(order_date, '%Y%m%d') AS SIGNED) AS date_id,
    order_date AS full_date,
    DAY(order_date) AS day,
    MONTHNAME(order_date) AS month_name,
    YEAR(order_date) AS year
FROM stage_sales;


DROP TABLE IF EXISTS fct_Sales;
CREATE TABLE fct_Sales AS
SELECT
    d.date_id,
    s.customer_id,
    s.product_id,
    s.quantity,
    s.total_price
FROM stage_sales AS s
JOIN dim_Date AS d ON s.order_date = d.full_date;

SELECT * FROM fct_Sales
ORDER BY total_price DESC
LIMIT 3;