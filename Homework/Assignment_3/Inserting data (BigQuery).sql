DROP TABLE IF EXISTS Assignment_3_dwh.users_db;
CREATE TABLE IF NOT EXISTS Assignment_3_dwh.users_db (
    user_id INT64,
    full_name STRING,
    registration_date DATE,
    email STRING
);

INSERT INTO Assignment_3_dwh.users_db (user_id, full_name, registration_date, email)
VALUES
    (101, 'Іван Франко', '2024-01-15', 'ivan.franko@example.com'),
    (102, 'Леся Українка', '2024-02-10', 'lesia.uk@example.com'),
    (103, 'Тарас Шевченко', '2024-03-01', 'taras.sh@example.com'),
    (101, 'Іван Франко (дублікат)', '2024-01-16', 'ivan.franko@example.com'),
    (NULL, 'Невідомий Юзер', '2024-01-17', 'anon@example.com');


DROP TABLE IF EXISTS Assignment_3_dwh.products_db;
CREATE TABLE IF NOT EXISTS Assignment_3_dwh.products_db (
    id STRING,
    product_name STRING,
    design_type STRING,
    size_option STRING,
    current_price NUMERIC
);

INSERT INTO Assignment_3_dwh.products_db (id, product_name, design_type, size_option, current_price)
VALUES
    ('KNU-TSHIRT-RED-M', 'Футболка', 'КНУ (Червоний)', 'M', 350.00),
    (NULL, 'Бракований товар', 'N/A', 'N/A', 0.00),
    ('KPI-HOODIE-BLK-L', 'Худі', 'КПІ (Чорний)', 'L', 800.00),
    ('MOHYLA-CAP-WHT-OS', 'Кепка', 'НаУКМА (Білий)', 'One Size', 250.00);


DROP TABLE IF EXISTS Assignment_3_dwh.payments_transactions_db;
CREATE TABLE IF NOT EXISTS Assignment_3_dwh.payments_transactions_db (
    transaction_id STRING,
    customer_user_id INT64,
    product_sku STRING,
    quantity_sold INT64,
    total_amount NUMERIC,
    transaction_timestamp DATETIME
);

INSERT INTO Assignment_3_dwh.payments_transactions_db (transaction_id, customer_user_id, product_sku, quantity_sold, total_amount, transaction_timestamp)
VALUES
    ('tr_1a2b3c', 101, 'KNU-TSHIRT-RED-M', 1, 350.00, '2024-10-01 10:30:00'),
    ('tr_4d5e6f', 102, 'KPI-HOODIE-BLK-L', 1, 800.00, '2024-10-01 14:45:00'),
    ('tr_7g8h9i', 103, 'MOHYLA-CAP-WHT-OS', 2, 500.00, '2024-10-02 09:15:00'),
    ('tr_1j2k3l', 101, 'KPI-HOODIE-BLK-L', 1, 800.00, '2024-10-03 18:00:00'),
    ('tr_1a2b3c', 101, 'KNU-TSHIRT-RED-M', 1, 350.00, '2024-10-01 10:30:01'),
    ('tr_failed', NULL, 'KNU-TSHIRT-RED-M', 1, 350.00, '2024-10-04 11:00:00');