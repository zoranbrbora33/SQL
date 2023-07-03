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



--- SCHOOL DATABASE ---

/* “1. “Display by category the category name and the count of classes offered for those
               categories that have three or more classes.”*/
SELECT ca.categorydescription, COUNT(cl.classid) 
FROM categories AS ca
INNER JOIN subjects AS sub
ON sub.categoryid = ca.categoryid
INNER JOIN classes AS cl
ON cl.subjectid = sub.subjectid
GROUP BY ca.categorydescription
HAVING COUNT(cl.classid) >= 3
ORDER BY 2 DESC;

/* “2. “List each staff member and the count of classes each is scheduled to teach for those
               staff members who teach fewer than three classes.”*/
SELECT stffirstname, stflastname, COUNT(classid)
FROM staff AS s
FULL JOIN faculty_classes AS fc
ON s.staffid = fc.staffid
GROUP BY stffirstname, stflastname
HAVING COUNT(classid) < 3;

/* “3. “Show me the subject categories that have fewer than three full professors teaching
               that subject.”*/
SELECT c.categorydescription, 
COUNT(sub.categoryid) AS professors
FROM
(SELECT c.categoryid
FROM faculty AS f
INNER JOIN faculty_categories AS fc
ON f.staffid = fc.staffid
INNER JOIN categories AS c
ON c.categoryid = fc.Categoryid
WHERE f.Title = 'Professor') AS sub
FULL JOIN categories AS c
    ON c.CategoryID = sub.categoryid
GROUP BY c.categorydescription
HAVING COUNT(sub.categoryid) < 3;

/* “4. “Count the classes taught by every staff member.”*/
SELECT s.stffirstname, s.stflastname, COUNT(classid)
FROM staff AS s
LEFT JOIN faculty_classes AS fc
ON fc.staffid = s.staffid
GROUP BY s.stffirstname, s.stflastname
ORDER BY 3 DESC;


--- BOWLING LEAGUE DATABASE ---

/* “1. “Do any team captains have a raw score that is higher than any other member of the
               team?”*/
SELECT b.bowlerfirstname, b.bowlerlastname, MAX(bs.rawscore)
FROM bowlers AS b
INNER JOIN teams AS t
ON t.captainid = b.bowlerid
INNER JOIN bowler_scores AS bs
ON bs.bowlerid = b.bowlerid
GROUP BY b.bowlerfirstname, b.bowlerlastname, bs.bowlerid, b.teamid, b.bowlerid
HAVING MAX(bs.rawscore) > ALL
(SELECT MAX(bs2.rawscore)
FROM bowler_scores AS bs2
INNER JOIN bowlers AS b2
ON bs.bowlerid = bs2.bowlerid
WHERE (b.teamid = b2.teamid) AND (b.bowlerid <> b2.bowlerid));

/* “2. “Display for each bowler the bowler name and the average of the bowler’s raw game
               scores for bowlers whose average is greater than 155.”*/
SELECT b.bowlerfirstname, b.bowlerlastname, ROUND(AVG(bs.rawscore), 2)
FROM bowlers AS b
INNER JOIN bowler_scores AS bs
ON bs.bowlerid = b.bowlerid
GROUP BY b.bowlerfirstname, b.bowlerlastname
HAVING AVG(bs.rawscore) > 155
ORDER BY 3 DESC;

/* “3. “List the last name and first name of every bowler whose average raw score is greater
               than or equal to the overall average score.”*/
SELECT b.bowlerfirstname AS first_name, b.bowlerlastname AS last_name, ROUND(AVG(bs.rawscore), 2) AS avg_score
FROM bowlers AS b
INNER JOIN bowler_scores AS bs
ON bs.bowlerid = b.bowlerid
GROUP BY b.bowlerfirstname, b.bowlerlastname
HAVING AVG(bs.rawscore) > 
(SELECT AVG(rawscore)
FROM bowler_scores);