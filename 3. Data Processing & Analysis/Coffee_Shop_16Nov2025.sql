-- Identifying the coloumn names and how they are linked ----------------------------------------------------------------------- 
SELECT *
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP
LIMIT 10;

-- Revenue per transaction ------------------------------------------------------------------------------------------------------ 
SELECT transaction_id,
        transaction_qty,
        unit_price,
       transaction_qty*unit_price AS revenue
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP;

-- identifying the total number of sales/transactions made ---------------------------------------------------------------------
SELECT COUNT(transaction_id) AS number_of_transactions
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP;

--COUNT the number of different shops we have in this data -------------------------------------------------------------------- 
SELECT COUNT(DISTINCT store_id) AS number_of_shops
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP;

-- To show us the name of the different store location which is actually 3 different shops ------------------------------------
SELECT DISTINCT store_location, store_id
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP;

--calculating the revenue by store location ----------------------------------------------------------------------------------- 
SELECT store_location,
       SUM(transaction_qty*unit_price) AS revenue
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP
GROUP BY store_location;

-- Earliest time the shops opens ---------------------------------------------------------------------------------------------
SELECT MIN(transaction_time) openig_time
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP;

-- Latest time the shops closes
SELECT MAX(transaction_time) closing_time
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP;

-- Identifying the various time slots and revenue per each store ------------------------------------------------------------
SELECT product_category,
       SUM(transaction_qty*unit_price) AS revenue,
       store_location,
       transaction_date,
       transaction_time,
       CASE
            WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN '01. Morning'
            WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN '02. Aftenoon'
            WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '03. Evening'
            WHEN transaction_time >= '20:00:00' THEN '04. Night'
        END AS time_bucket
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP
WHERE transaction_date>'2023-05-01'
GROUP BY product_category,
         store_location,
         transaction_date,
         time_bucket,
         transaction_time
ORDER BY revenue DESC;

--------------------------------------------------------------------------------------------------------------------
SELECT transaction_date,
    YEAR(transaction_date)As year,
    TO_CHAR(transaction_date,'YYYYMM') As month_id
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP;

--------------------------------------------------------------------------------------------------------------------------
SELECT transaction_date,
        YEAR(transaction_date) As year,
        MONTH(transaction_date)As month,
        MONTHNAME(transaction_date)As month_name,
        DAYOFMONTH(transaction_date) As day_of_month,
        DAYNAME(transaction_date) As day_name,
        CASE
            WHEN day_name NOT IN('sat','Sun') THEN 'weekday'
            ELSE 'weekend'
            END AS day_of_week_classification, 
         SUM(transaction_qty*unit_price) As revenue,
FROM BRIGHTCOFFEESHOP.COFFEE.SHOP
/*GROUP BY product_category,
         store_location,
         --transaction_date,
         time_bucket,
         transaction_time,
         revenue*/
ORDER BY revenue DESC;
-------------------------------------------------------------------------------------------------------------------------------
SELECT product_category,
       SUM(transaction_qty*unit_price) AS revenue,
       store_location,
       transaction_date,
       transaction_time,
       CASE
            WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN '01. Morning'
            WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN '02. Aftenoon'
            WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '03. Evening'
            WHEN transaction_time >= '20:00:00' THEN '04. Night'
        END AS time_bucket,

        YEAR(transaction_date) As year,
        MONTH(transaction_date)As month,
        MONTHNAME(transaction_date)As month_name,
        DAYOFMONTH(transaction_date) As day_of_month,
        DAYNAME(transaction_date) As day_name,
        CASE
            WHEN day_name NOT IN('sat','Sun') THEN 'weekday'
            ELSE 'weekend'
            END AS day_of_week_classification 
        

FROM BRIGHTCOFFEESHOP.COFFEE.SHOP
WHERE transaction_date>'2023-05-01'
GROUP BY product_category,
         store_location,
         transaction_date,
         time_bucket,
         transaction_time
ORDER BY revenue DESC;
-------------------------------------------------------------------------------------------------------
