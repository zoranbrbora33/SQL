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


--- ENTERTAINMENT DATABASE ---

/* “1. “What is the average salary of a booking agent?”*/
SELECT ROUND(AVG(salary), 2) AS average_salary
FROM agents

/* “2. “Show me the engagement numbers for all engagements that have a contract price greater
               than or equal to the overall average contract price.”*/
SELECT engagementnumber AS engagement
FROM engagements
WHERE contractprice >=
(SELECT AVG(contractprice)
FROM engagements)

/* “3. “How many of our entertainers are based in Bellevue?”*/
SELECT COUNT(*)
FROM entertainers
WHERE entcity = 'Bellevue';

/* “4. “Which engagements occur earliest in October 2017?”*/
SELECT engagementnumber AS engagements
FROM engagements
WHERE startdate IN
(SELECT MIN(startdate)
FROM engagements
WHERE EXTRACT(MONTH FROM startdate) = 10);