--- SALES DATABASE ---

/* “1. “Display the customers who have never ordered bikes or tires.”*/

--- solution with multiple subqueries ---
SELECT c.customerid, c.custfirstname, c.custlastname
FROM customers AS c
WHERE c.customerid  NOT IN
(SELECT o.customerid 
FROM orders AS o INNER JOIN order_details AS od
ON od.ordernumber = o.ordernumber
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.categoryid = 2)
AND c.customerid  NOT IN
(SELECT o.customerid 
FROM orders AS o INNER JOIN order_details AS od
ON od.ordernumber = o.ordernumber
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.categoryid = 6);

--- simpler solution ---
SELECT c.customerid, c.custfirstname, c.custlastname
FROM customers AS c
WHERE c.customerid NOT IN
(SELECT o.customerid FROM orders AS o
INNER JOIN order_details AS od
ON od.ordernumber = o.ordernumber
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.categoryid  IN (2, 6));

/* “2. “List the customers who have purchased a bike but not a helmet.”*/

--- solution using EXISTS and NOT EXISTS ---
SELECT c.customerid AS id, c.custfirstname AS first_name, c.custlastname AS lastname
FROM customers AS c
WHERE EXISTS
(SELECT o.customerid
FROM orders AS o INNER JOIN order_details AS od
ON od.ordernumber = o.ordernumber
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.productname LIKE '%Bike%'
AND c.customerid = o.customerid)
AND NOT EXISTS
(SELECT o.customerid
FROM orders AS o INNER JOIN order_details AS od
ON od.ordernumber = o.ordernumber
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.productname LIKE '%Helmet%'
AND c.customerid = o.customerid);

--- solution using IN and NOT IN ---
SELECT c.customerid AS id, c.custfirstname AS first_name, c.custlastname AS lastname
FROM customers AS c
WHERE c.customerid IN 
(SELECT o.customerid
FROM orders AS o INNER JOIN order_details AS od
ON od.ordernumber = o.ordernumber
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.productname LIKE '%Bike%')
AND c.customerid NOT IN
(SELECT o.customerid
FROM orders AS o INNER JOIN order_details AS od
ON od.ordernumber = o.ordernumber
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.productname LIKE '%Helmet%');