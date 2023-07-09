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


--- ENTERTAINMENT DATABASE ---

/* “1. “List the entertainers who play the Jazz, Rhythm and Blues, and Salsa styles.”*/

--- longer solution --- 
SELECT e.entertainerid AS entertainer_id, e.entstagename AS entertainer 
FROM entertainers AS e
WHERE e.entertainerid IN
(SELECT es.entertainerid
FROM entertainer_styles AS es
INNER JOIN musical_styles AS ms
ON ms.styleid = es.styleid
WHERE ms.stylename = 'Jazz')
AND e.entertainerid IN
(SELECT es.entertainerid
FROM entertainer_styles AS es
INNER JOIN musical_styles AS ms
ON ms.styleid = es.styleid
WHERE ms.stylename = 'Rhythm and Blues')
AND e.entertainerid IN
(SELECT es.entertainerid
FROM entertainer_styles AS es
INNER JOIN musical_styles AS ms
ON ms.styleid = es.styleid
WHERE ms.stylename = 'Salsa')

--- shorter solution ---
SELECT e.entertainerid AS entertainer_id, e.entstagename AS entertainer 
FROM entertainers AS e
WHERE e.entertainerid IN
(SELECT es.entertainerid
FROM entertainer_styles AS es
WHERE es.styleid = 15)
AND e.entertainerid IN
(SELECT es.entertainerid
FROM entertainer_styles AS es
WHERE es.styleid = 19)
AND e.entertainerid IN
(SELECT es.entertainerid
FROM entertainer_styles AS es
WHERE es.styleid = 24)

--- solution using GROUP BY and HAVING ---
SELECT e.entertainerid AS entertainer_id, e.entstagename AS entertainer,
COUNT(e.entertainerid) AS num_of_styles
FROM entertainers AS e
INNER JOIN entertainer_styles AS es
ON es.entertainerid = e.entertainerid
INNER JOIN musical_styles AS ms 
ON ms.styleid = es.styleid
WHERE ms.stylename IN ('Jazz', 'Rhythm and Blues', 'Salsa')
GROUP BY e.entertainerid, e.entstagename
HAVING COUNT(e.entertainerid) = 3;

/* “2. “Show the entertainers who did not have a booking in the 90 days preceding May 1,
               2018.”*/
SELECT e.entertainerid AS entertainer_id, e.entstagename AS entertainer
FROM entertainers AS e
WHERE e.entertainerid NOT IN
(SELECT eng.entertainerid
FROM engagements AS eng
WHERE (startdate >= '2018-05-01'::date - INTERVAL '90 days'
AND startdate < '2018-05-01'::date) AND startdate IS NOT NULL);

/* “3. “Display the customers who have not booked Topazz or Modern Dance.”*/
SELECT c.customerid AS customer_id, c.custfirstname AS first_name,
c.custlastname AS lastname 
FROM customers AS c
WHERE c.customerid NOT IN
(SELECT e.customerid
FROM engagements AS e
WHERE e.entertainerid = 1002)
AND c.customerid NOT IN
(SELECT e.customerid
FROM engagements AS e
WHERE e.entertainerid = 1006);

/* “4. “List the entertainers who have performed for Hartwig, McCrae, and Rosales.”*/
SELECT e.entertainerid AS entertainer_id, e.entstagename AS entertainer
FROM entertainers AS e
WHERE EXISTS
(SELECT eng.entertainerid
FROM engagements AS eng
INNER JOIN customers AS c
ON c.customerid = eng.customerid
WHERE c.custlastname LIKE '%Hartwig'
AND e.entertainerid = eng.entertainerid)
AND EXISTS
(SELECT eng.entertainerid
FROM engagements AS eng
INNER JOIN customers AS c
ON c.customerid = eng.customerid
WHERE c.custlastname LIKE '%McCrae'
AND e.entertainerid = eng.entertainerid)
AND EXISTS
(SELECT eng.entertainerid
FROM engagements AS eng
INNER JOIN customers AS c
ON c.customerid = eng.customerid
WHERE c.custlastname LIKE '%Rosales'
AND e.entertainerid = eng.entertainerid);

/* “5A. “Display the customers who have never booked an entertainer.”*/
SELECT c.customerid AS customer_id, c.custfirstname AS first_name, c.custlastname AS last_name 
FROM customers AS c
WHERE c.customerid NOT IN
(SELECT eng.customerid
FROM engagements AS eng);

/* 5B. “Show the entertainers who have no bookings.”*/
SELECT e.entertainerid AS entertainer_id, e.entstagename AS entertainer
FROM entertainers AS e
WHERE e.entertainerid NOT IN
(SELECT eng.entertainerid
FROM engagements AS eng);


--- SCHOOL DATABASE ---

/* “1. “Show students who have a grade of 85 or better in both Art and Computer Science.”*/
SELECT studentid AS student_id, studfirstname AS first_name, 
studlastname AS last_name
FROM students 
WHERE EXISTS
(SELECT student_schedules.studentid
FROM student_schedules
INNER JOIN classes
ON classes.classid = student_schedules.classid
INNER JOIN subjects
ON subjects.subjectid = classes.subjectid
INNER JOIN categories 
ON categories.categoryid = subjects.categoryid
WHERE (categories.categorydescription = 'Art' AND student_schedules.grade >= 85)
AND student_schedules.studentid = students.studentid)
AND EXISTS
(SELECT student_schedules.studentid
FROM student_schedules
INNER JOIN classes
ON classes.classid = student_schedules.classid
INNER JOIN subjects
ON subjects.subjectid = classes.subjectid
INNER JOIN categories 
ON categories.categoryid = subjects.categoryid
WHERE (categories.categorydescription LIKE '%Computer%' AND student_schedules.grade >= 85)
AND student_schedules.studentid = students.studentid);