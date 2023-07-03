--- SALES DATABASE ---

/* “1. “Show me each vendor and the average by vendor of the number of days to deliver products
               that are greater than the average delivery days for all vendors.”*/
SELECT vendor, avg_days_to_deliver
FROM (
  SELECT v.vendname AS vendor, ROUND(AVG(pv.daystodeliver), 0) AS avg_days_to_deliver
  FROM vendors AS v
  INNER JOIN product_vendors AS pv ON pv.vendorid = v.vendorid
  GROUP BY v.vendname
  HAVING AVG(pv.daystodeliver) > (
    SELECT AVG(pv.daystodeliver)
    FROM product_vendors AS pv
  )
) AS sub;

/* “2. “Display for each product the product name and the total sales that is greater than
               the average of sales for all products in that category.”*/
SELECT p.productname AS product, 
SUM(od.quotedprice * od.quantityordered)
FROM products AS p
INNER JOIN order_details AS od
ON od.productnumber = p.productnumber
GROUP BY p.productname, p.categoryid
HAVING SUM(od.quotedprice * od.quantityordered) >
(SELECT AVG(total)
FROM 
(SELECT p2.productname, p2.categoryid, 
SUM(od2.quotedprice * od2.quantityordered) AS total
FROM products AS p2
INNER JOIN order_details AS od2
ON od2.productnumber = p2.productnumber
GROUP BY p2.productname, p2.categoryid) AS avg
WHERE p.categoryid = avg.categoryid)
ORDER BY 2 DESC;

/* “3. “How many orders are for only one product?”*/
SELECT COUNT(total_orders) AS total_orders
FROM
(SELECT ordernumber, COUNT(productnumber) AS total_orders
FROM order_details
GROUP BY ordernumber
HAVING COUNT(productnumber) = 1) AS sub;


--- ENTERTAINMENT DATABASE ---

