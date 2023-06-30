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