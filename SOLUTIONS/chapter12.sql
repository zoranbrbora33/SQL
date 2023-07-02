--- SALES DATABASE ---

/* “1. “What is the average retail price of a mountain bike?”*/
SELECT ROUND(AVG(retailprice), 2) AS avg_price
FROM products
WHERE productname LIKE '%Mountain Bike%';

/* “2. “What was the date of our most recent order?”*/
SELECT MAX(orderdate) 
FROM orders

/* “3. “What was the total amount for order number 8?”*/
SELECT ROUND(SUM(quotedprice * quantityordered), 2) AS total_sum
FROM order_details AS od
INNER JOIN products as p
ON p.productnumber = od.productnumber
WHERE ordernumber = 8;