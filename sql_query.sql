create database  food_orders_db ; 
use food_orders_db ; 

select * from food_orders;


-- Total Orders, Average Order Value, Total Revenue, and Profit --

SELECT 
    COUNT(*) AS total_orders,
    ROUND(AVG(`order value`), 2) AS Avg_order_value,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(SUM(profit), 2) as total_profit
FROM
    food_orders;
    

-- Average Delivery Duration by Payment Method  --

SELECT 
    `payment method`,
    ROUND(AVG(delivery_duration_min), 2) AS avg_delivery_duration_min
FROM
    food_orders
GROUP BY 1;


-- Top 10 Restaurants by Total Revenue -- 

SELECT 
    `Restaurant ID`, ROUND(SUM(Revenue), 2) AS total_revenue
FROM
    food_orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Impact of Discounts on Order Value -- 

SELECT 
    ROUND(AVG(Discount_Percent_or_Amount), 2) AS Avg_Discount,
    ROUND(AVG(`order value`), 2) AS Avg_order_value,
    ROUND(SUM(profit), 2) AS total_profit
FROM
    food_orders;
    
    
 -- Refund per Restaurant --
 
SELECT 
    `Restaurant ID`,
    COUNT(*) AS total_orders,
    SUM(`order Value`) AS total_orders,
    ROUND(SUM(`Refunds/Chargebacks`), 2) AS total_refunds
FROM
    food_orders
GROUP BY 1
ORDER BY 4 DESC;


-- Profitability by Payment Method --

SELECT 
    `payment method`,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit
FROM
    food_orders
GROUP BY 1;


 -- Delivery Duration by Order Value Range  --
 
 SELECT 
    CASE
        WHEN `order value` < 200 THEN 'Low (<200)'
        WHEN `order value` BETWEEN 200 AND 500 THEN 'Medium (200-500)'
        ELSE 'High (>500)'
    END AS order_range,
    ROUND(AVG(delivery_duration_min)) AS avg_delivery_time
FROM
    food_orders
GROUP BY 1;

-- Monthly Revenue Trend --

SELECT 
    DATE_FORMAT(`order date and time`, '%Y-%m') AS month,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM
    food_orders
GROUP BY 1;

-- Top 10 Most Profitable Restaurants  -- 

SELECT 
    `restaurant id`, ROUND(SUM(profit), 2) AS total_profit
FROM
    food_orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


-- Average Profit Margin by Restaurant  --

SELECT 
    `restaurant id`,
    ROUND((SUM(profit) / SUM(revenue)) * 100, 2) AS avg_profit_margine
FROM
    food_orders
GROUP BY 1;

 
