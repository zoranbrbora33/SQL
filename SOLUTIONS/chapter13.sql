--- SALES DATABASE ---

/* “1. “Show me each vendor and the average by vendor of the number of days to deliver products.”*/
SELECT vendname, ROUND(AVG(pv.daystodeliver), 2)
FROM vendors AS v
INNER JOIN product_vendors AS pv
ON pv.vendorid = v.vendorid
GROUP BY vendname
ORDER BY 2 DESC;

/* “2. “Display for each product the product name and the total sales.”*/
SELECT p.productname AS product, SUM(od.quantityordered * od.quotedprice)
from products AS p
INNER JOIN order_details AS od
ON od.productnumber = p.productnumber
GROUP BY product
ORDER BY 2 DESC;

/* “3. “List all vendors and the count of products sold by each.”*/
SELECT v.vendname AS vendor, COUNT(pv.productnumber) AS num_of_products
FROM vendors AS v
INNER JOIN product_vendors AS pv
ON pv.vendorid = v.vendorid
GROUP BY v.vendname
ORDER BY 2 DESC;

/* “4. Challenge: Now solve problem 3 by using a subquery.”*/
SELECT t.vendor, t.num_of_products
FROM
(SELECT v.vendname AS vendor, COUNT(pv.productnumber) AS num_of_products
FROM vendors AS v
INNER JOIN product_vendors AS pv
ON pv.vendorid = v.vendorid
GROUP BY v.vendname) AS t
ORDER BY 2 DESC;


