-- PROJECT 2: SUPERSTORE SALES ANALYSIS
-- Tool: SQLite / DB Browser for SQLite


-- 1. Classify orders by sales value

SELECT
    "Order ID",
    "Sales",
    CASE
        WHEN "Sales" > 1000 THEN 'Excellent'
        WHEN "Sales" BETWEEN 500 AND 999.99 THEN 'Good'
        WHEN "Sales" BETWEEN 100 AND 499.99 THEN 'Average'
        ELSE 'Poor'
    END AS sales_category
FROM superstore;


-- 2. Classify orders by quantity

SELECT
    "Order ID",
    "Quantity",
    CASE
        WHEN "Quantity" >= 5 THEN 'Bulk Order'
        WHEN "Quantity" BETWEEN 3 AND 4 THEN 'Medium Order'
        ELSE 'Small Order'
    END AS quantity_category
FROM superstore;


-- 3. Classify orders by profit

SELECT
    "Order ID",
    "Profit",
    CASE
        WHEN "Profit" > 100 THEN 'High Profit'
        WHEN "Profit" BETWEEN 1 AND 100 THEN 'Low Profit'
        ELSE 'Loss'
    END AS profit_category
FROM superstore;


-- 4. Show total sales for each month

SELECT
    strftime('%m', "Order Date") AS month,
    SUM("Sales") AS total_sales
FROM superstore
GROUP BY strftime('%m', "Order Date");


-- 5. Show total sales for each year-month

SELECT
    strftime('%Y-%m', "Order Date") AS year_month,
    SUM("Sales") AS total_sales
FROM superstore
GROUP BY strftime('%Y-%m', "Order Date");


-- 6. Find the year-month with the highest total sales

SELECT
    strftime('%Y-%m', "Order Date") AS year_month,
    SUM("Sales") AS total_sales
FROM superstore
GROUP BY strftime('%Y-%m', "Order Date")
ORDER BY total_sales DESC
LIMIT 1;


-- 7. Show total profit for each year

SELECT
    strftime('%Y', "Order Date") AS year,
    SUM("Profit") AS total_profit
FROM superstore
GROUP BY strftime('%Y', "Order Date");


-- 8. Calculate how many days each order took to ship

SELECT
    "Order ID",
    "Order Date",
    "Ship Date",
    julianday("Ship Date") - julianday("Order Date") AS shipping_days
FROM superstore;


-- 9. Show orders with sales above the overall average

SELECT
    "Order ID",
    "Sales"
FROM superstore
WHERE "Sales" > (
    SELECT AVG("Sales")
    FROM superstore
);


-- 10. Show products with profit above the overall average

SELECT
    "Product Name",
    "Profit"
FROM superstore
WHERE "Profit" > (
    SELECT AVG("Profit")
    FROM superstore
);


-- 11. Find the year-month with the highest total profit

SELECT
    strftime('%Y-%m', "Order Date") AS year_month,
    SUM("Profit") AS total_profit
FROM superstore
GROUP BY year_month
ORDER BY total_profit DESC
LIMIT 1;
