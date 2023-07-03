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

/* “1. “Show me the entertainers who have more than two overlapped bookings.”*/
SELECT entstagename
FROM entertainers
WHERE entertainerid IN
(SELECT eng1.entertainerid
FROM engagements AS eng1
INNER JOIN engagements AS eng2
ON eng2.entertainerid = eng1.entertainerid
WHERE (eng1.startdate <= eng2.enddate) AND (eng1.enddate >= eng2.startdate)
AND(eng1.engagementnumber <> eng2.engagementnumber)
GROUP BY eng1.entertainerid
HAVING eng1.entertainerid > 2);

/* “2. “Show each agent’s name, the sum of the contract price for the engagements booked,
               and the agent’s total commission for agents whose total commission is more than $1,000.”*/
SELECT agtfirstname, agtlastname, SUM(contractprice) AS total_contract,
ROUND(SUM(contractprice * commissionrate)::integer, 2)
FROM agents AS a
INNER JOIN engagements AS e
ON e.agentid = a.agentid
GROUP BY agtfirstname, agtlastname
HAVING SUM(contractprice * commissionrate) > 1000
ORDER BY 4 DESC;