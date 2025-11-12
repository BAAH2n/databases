


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
