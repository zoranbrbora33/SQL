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