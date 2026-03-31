--Bright coffee shop code segments
SELECT*
FROM BRIGHT.COFFEE.SHOP;

--Count the total number of transactions
SELECT COUNT(transaction_id) AS total_number_of_transactions
FROM BRIGHT.COFFEE.SHOP;

--Distinguish all store locations
SELECT DISTINCT STORE_ID,
STORE_LOCATION
FROM BRIGHT.COFFEE.SHOP
ORDER BY STORE_ID ASC;


--Calculate shop opening time
SELECT MIN (TRANSACTION_TIME) AS Opening_time
FROM BRIGHT.COFFEE.SHOP;

--Show shop closing time
SELECT MAX (transaction_time) AS Closing_time
FROM BRIGHT.COFFEE.SHOP;

--Opening and closing times
SELECT MIN (transaction_time) AS Opening_time, 
MAX (Transaction_time) AS Closing_time
FROM BRIGHT.COFFEE.SHOP;

--Calculate revenue and determine lowest to highest revenue by store location
SELECT STORE_LOCATION, SUM (Transaction_qty * Unit_price) AS revenue,
CASE
    WHEN revenue = 230057.25 THEN 'Lowest sales'
    WHEN revenue = 232243.91 THEN 'Medium sales'
    WHEN revenue = 236511.17 THEN 'Highest sales'
END AS Sales_ranking_by_store
FROM BRIGHT.COFFEE.SHOP
GROUP BY STORE_LOCATION
ORDER BY Revenue ASC;

--Categorize revenue in groups
SELECT SUM (Transaction_qty * Unit_price) AS revenue,
Store_location, Transaction_date, Transaction_time,
CASE
    WHEN Transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    WHEN Transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
    WHEN Transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN 'Evening'
    WHEN Transaction_time >= '20:00:00' THEN 'Night'
END AS Time_bucket
FROM BRIGHT.COFFEE.SHOP
GROUP BY Product_category,
Store_location,
Transaction_date,
Transaction_time,
Time_bucket
ORDER BY Revenue ASC;

--Calculate sales per season of the year
SELECT 
  Store_location,
  SUM(Transaction_qty * Unit_price) AS Revenue,
  CASE
    WHEN MONTH(Transaction_date) IN (12, 1, 2) THEN 'Summer'
    WHEN MONTH(Transaction_date) IN (3, 4, 5) THEN 'Autumn'
    WHEN MONTH(Transaction_date) IN (6, 7, 8) THEN 'Winter'
    WHEN MONTH(Transaction_date) IN (9, 10, 11) THEN 'Spring'
  END AS Season
FROM BRIGHT.COFFEE.SHOP
WHERE Transaction_date >= '2023-01-01'
GROUP BY Store_location, 
  CASE
    WHEN MONTH(Transaction_date) IN (12, 1, 2) THEN 'Summer'
    WHEN MONTH(Transaction_date) IN (3, 4, 5) THEN 'Autumn'
    WHEN MONTH(Transaction_date) IN (6, 7, 8) THEN 'Winter'
    WHEN MONTH(Transaction_date) IN (9, 10, 11) THEN 'Spring'
  END
ORDER BY  Store_location, Season;

--Test code
SELECT 
  Store_location,
  MONTH(Transaction_date) AS Month,
  SUM(Transaction_qty * Unit_price) AS Revenue
FROM BRIGHT.COFFEE.SHOP
--WHERE Transaction_date >= '2023-01-01'
GROUP BY ALL;
--Store_location, MONTH(Transaction_date);

--Data consisting of categorized data
SELECT 
transaction_date, 
        DAYNAME(transaction_date) AS day_name,
        CASE 
        WHEN day_name IN ('Sat','Sun') THEN 'Weekend'
        ELSE 'Weekday'
        END AS day_classification,
        MONTHNAME(transaction_date) AS month_name,
         -- transaction_time,
         CASE
             WHEN transaction_time BETWEEN '06:00:00' AND '11:59:00' THEN 'Morning'
             WHEN transaction_time BETWEEN '12:00:00' AND '16:59:00' THEN 'Afternoon'
             WHEN transaction_time >='17:00:00' THEN 'Evening'
         END AS time_classification,
          CASE
            WHEN MONTH(Transaction_date) IN (12, 1, 2) THEN 'Summer'
            WHEN MONTH(Transaction_date) IN (3, 4, 5) THEN 'Autumn'
            WHEN MONTH(Transaction_date) IN (6, 7, 8) THEN 'Winter'
            WHEN MONTH(Transaction_date) IN (9, 10, 11) THEN 'Spring'
        END AS Season,
         HOUR (transaction_time) AS hour_of_day,
          store_location,
          product_category,
          product_type,
          product_detail,
          unit_price, 
          transaction_date
          transaction_qty,
  COUNT(DISTINCT transaction_id) AS number_of_sales,
  SUM(transaction_qty*unit_price) AS Revenue
  FROM BRIGHT.COFFEE.SHOP
  GROUP BY ALL;
