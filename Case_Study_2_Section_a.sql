-- A. Pizza Metrics

-- How many pizzas were ordered?
SELECT COUNT(*) AS ordered_pizzas
FROM customer_orders;
-- 14

-- How many unique customer orders were made?
SELECT COUNT(distinct customer_id) AS customer_count
FROM customer_orders;
-- 5

-- How many successful orders were delivered by each runner?
SELECT runner_id, COUNT(*) AS count_without_cancellation
FROM runner_orders
WHERE cancellation NOT ILIKE '%cancellation%'
OR cancellation IS NULL
GROUP BY runner_id;

-- How many of each type of pizza was delivered?
SELECT pizza_name,
COUNT(*) as Delivered_Pizza
FROM runner_orders AS RO
INNER JOIN customer_orders as CO on RO.order_id = CO.order_id
INNER JOIN pizza_names as PN on PN.pizza_id = CO.pizza_id
WHERE pickup_time <> 'null'
GROUP BY pizza_name
LIMIT 10;

-- How many Vegetarian and Meatlovers were ordered by each customer?
SELECT PIZZA_NAME, customer_id, COUNT(*) AS pizza_count
FROM customer_orders
LEFT JOIN pizza_names as P_N on P_N.pizza_id = customer_orders.pizza_id
GROUP BY P_N.pizza_name, customer_id
ORDER BY customer_id;

-- What was the maximum number of pizzas delivered in a single order?
SELECT order_id, COUNT(*) AS pizza_count
FROM customer_orders
GROUP BY order_id
HAVING COUNT(*) = (
    SELECT MAX(pizza_count)
    FROM (
        SELECT COUNT(*) AS pizza_count
        FROM customer_orders
        GROUP BY order_id
    ) AS subquery
);

-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT 
    CO.customer_id,
    SUM(CASE WHEN (CO.exclusions IS NULL OR CO.exclusions = '' AND CO.exclusions <> 'null') AND (CO.extras IS NULL OR CO.extras = '' AND CO.extras <> 'null') THEN 1 ELSE 0 END) AS no_changes,
    SUM(CASE WHEN (CO.exclusions IS NOT NULL AND CO.exclusions <> '' AND CO.exclusions <> 'null') OR (CO.extras IS NOT NULL AND CO.extras <> '' AND CO.extras <> 'null') THEN 1 ELSE 0 END) AS with_changes
FROM customer_orders AS CO
INNER JOIN runner_orders AS RO ON RO.order_id = CO.order_id
WHERE pickup_time <> 'null'
GROUP BY CO.customer_id;

-- How many pizzas were delivered that had both exclusions and extras?
SELECT COUNT(*) as delivered_pizzas
FROM customer_orders AS CO
INNER JOIN runner_orders AS RO ON RO.order_id = CO.order_id
WHERE (CO.exclusions IS NOT NULL AND CO.exclusions <> '' AND CO.exclusions <> 'null') AND (CO.extras IS NOT NULL AND CO.extras <> '' AND CO.extras <> 'null')
AND pickup_time <> 'null';

-- What was the total volume of pizzas ordered for each hour of the day?
SELECT 
    DATE_PART(HOUR, order_time) AS hour_of_day,
    COUNT(*) AS count_of_orders
FROM customer_orders
GROUP BY DATE_PART(HOUR, order_time)
ORDER BY hour_of_day;

-- What was the volume of orders for each day of the week?
SELECT 
    DAYNAME(order_time) AS day_of_week,
    COUNT(*) AS count_of_orders
FROM customer_orders
GROUP BY 1
ORDER BY day_of_week;

// B. Runner and Customer Experience
// How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT DATEADD('day', 4, DATE_TRUNC(week,DATEADD(day, -4, registration_date))), COUNT(*) as number_of_runners
FROM runners
GROUP BY DATEADD('day', 4, DATE_TRUNC(week,DATEADD(day, -4, registration_date)));

// What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
// Is there any relationship between the number of pizzas and how long the order takes to prepare?
// What was the average distance travelled for each customer?
// What was the difference between the longest and shortest delivery times for all orders?
// What was the average speed for each runner for each delivery and do you notice any trend for these values?
// What is the successful delivery percentage for each runner?