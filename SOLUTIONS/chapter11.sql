--- SALES DATABASE ---

/* “1. “Display products and the latest date each product was ordered.”*/
SELECT products.productname,
(SELECT MAX(orderdate)
FROM orders) AS order_date
FROM products

/* “2. “List customers who ordered bikes.”*/
SELECT customers.custfirstname, customers.custlastname
FROM customers
WHERE customers.customerid IN
(SELECT orders.customerid FROM orders
INNER JOIN order_details ON order_details.ordernumber = orders.ordernumber
INNER JOIN products ON products.productnumber = order_details.productnumber
WHERE products.productnumber IN (6));

/* “3. “What products have never been ordered?”*/
SELECT productname
FROM products
WHERE products.productnumber NOT IN
(SELECT order_details.productnumber
FROM order_details);


--- ENTERTAINMENT DATABASE ---

/* “1. “Show me all entertainers and the count of each entertainer’s engagements.”*/
SELECT entstagename AS entertainer,
(SELECT COUNT(*) AS num_of_concerts
FROM engagements
WHERE entertainers.entertainerid = engagements.entertainerid)
FROM entertainers
ORDER BY 2 DESC;

/* “2. “List customers who have booked entertainers who play country or country rock.”*/
SELECT  DISTINCT(custfirstname || ' ' || custlastname) AS customer
FROM customers AS c
INNER JOIN engagements AS e ON c.customerid = e.customerid
WHERE e.entertainerid IN
(SELECT es.entertainerid
FROM entertainer_styles AS es
WHERE es.styleid IN (6, 11));

/* “3. “Find the entertainers who played engagements for customers Berg or Hallmark.”*/
SELECT entstagename
FROM entertainers
WHERE entertainers.entertainerid IN -- or using 'some' => WHERE entertainers.entertainerid = SOME
(SELECT e.entertainerid
FROM engagements AS e
INNER JOIN customers ON customers.customerid = e.customerid
WHERE customers.custlastname IN ('Berg', 'Hallmark'));

/* “4. “Display agents who haven’t booked an entertainer.”*/
SELECT (agtfirstname || ' ' || agtlastname) AS agent
FROM agents
WHERE agents.agentid NOT IN
(SELECT e.agentid 
FROM engagements AS e);