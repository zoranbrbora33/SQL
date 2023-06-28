--- SALES DATABASE ---

/* “. “List the customers who ordered a helmet together with the vendors who provide helmets.”*/
SELECT customer.cust AS name, customer.product, 'customer' AS class
FROM (SELECT (cust.custfirstname || ' ' || cust.custlastname) as cust, p.productname AS product
	 FROM customers AS cust
	 INNER JOIN orders AS ord ON cust.customerid = ord.customerid
	 INNER JOIN order_details AS ord_det ON ord.ordernumber = ord_det.ordernumber
	 INNER JOIN products AS p ON ord_det.productnumber = p.productnumber
	 WHERE p.productname LIKE '%Helmet%') AS customer
UNION
SELECT vendors.vendname, vendors.productname, 'vendor' AS class
FROM (SELECT v.vendname, p.productname
	 FROM vendors AS v
	 INNER JOIN product_vendors AS pv ON v.vendorid = pv.vendorid
	 INNER JOIN products AS p ON pv.productnumber = p.productnumber
	 WHERE p.productname LIKE '%Helmet%') vendors
ORDER BY 3, 1;