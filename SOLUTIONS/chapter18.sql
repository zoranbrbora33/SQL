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

/* “3. “Show me the customer orders that have a bike but do not have a helmet.”*/
SELECT o.ordernumber, o.orderdate, o.shipdate, o.customerid, o.employeeid
FROM orders AS o
WHERE EXISTS
(SELECT od.ordernumber
FROM order_details AS od
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.productname LIKE '%Bike'
AND od.ordernumber = o.ordernumber)
AND NOT EXISTS
(SELECT od.ordernumber
FROM order_details AS od
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.productname  LIKE '%Helmet'
AND od.ordernumber = o.ordernumber)
ORDER BY 1;

/* “4. “Display the customers and their orders that have a bike and a helmet in the same
               order.”*/
SELECT c.customerid AS customer_id, 
(c.custfirstname || ' ' || c.custlastname) AS full_name,
o.ordernumber AS order_number
FROM orders AS o
INNER JOIN customers AS c
ON c.customerid = o.customerid
WHERE EXISTS
(SELECT od.ordernumber
FROM order_details AS od
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.productname LIKE '%Bike'
AND od.ordernumber = o.ordernumber)
AND EXISTS
(SELECT od.ordernumber
FROM order_details AS od
INNER JOIN products AS p
ON p.productnumber = od.productnumber
WHERE p.productname  LIKE '%Helmet'
AND od.ordernumber = o.ordernumber)
ORDER BY 1;

/* “5. “Show the vendors who sell accessories, car racks, and clothing.”*/
SELECT v.vendorid AS vendor_id, v.vendname AS vendor 
FROM vendors AS v
WHERE v.vendorid IN
(SELECT pv.vendorid
FROM product_vendors AS pv
INNER JOIN products AS p 
ON p.productnumber = pv.productnumber
WHERE p.categoryid IN (1))
AND v.vendorid IN
(SELECT pv.vendorid
FROM product_vendors AS pv
INNER JOIN products AS p 
ON p.productnumber = pv.productnumber
WHERE p.categoryid IN (3))
AND v.vendorid IN
(SELECT pv.vendorid
FROM product_vendors AS pv
INNER JOIN products AS p 
ON p.productnumber = pv.productnumber
WHERE p.categoryid IN (5))
ORDER BY 1;