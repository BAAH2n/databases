ReadMe for the DWH Modeling Task Danilova, Hanhalo: 
1) First, at the raw layer, we had three tables: 'users', 'products', and 'payments_transactions'.
2) At the stage layer, we insert data into the star scheme tables 'customers', 'products', and 'sales'. We also clean data from NULLs and GROUP BY some column (user_id, id, transaction_id). Here, we also used the MAX aggregate function
3) At the STAGE (!) layer, we created a dimensions table.
4) Mart layer: selecting the top three largest purchases.
