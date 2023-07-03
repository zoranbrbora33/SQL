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


--- ENTERTAINMENT DATABASE ---

/* “1. “Show each agent’s name, the sum of the contract price for the engagements booked,
               and the agent’s total commission.”*/
SELECT agtfirstname || ' ' || agtlastname AS agent, SUM(contractprice) as total_contract,
CAST(SUM(contractprice) * commissionrate AS numeric(10,2)) AS total_commission
FROM agents AS a
INNER JOIN engagements AS e
ON e.agentid = a.agentid
GROUP BY agtfirstname, agtlastname, commissionrate;


--- SCHOOL DATABASE ---

/* “1. “Display by category the category name and the count of classes offered.”*/
SELECT categorydescription, COUNT(classid)
FROM categories cat
INNER JOIN subjects AS s 
ON s.categoryid = cat.categoryid
INNER JOIN classes AS c
ON c.subjectid = s.subjectid
GROUP BY categorydescription;

/* “2. “List each staff member and the count of classes each is scheduled to teach.”*/
SELECT stffirstname AS firstname, stflastname AS lastname, COUNT(fc.classid) AS num_of_classes
FROM staff AS s
INNER JOIN faculty AS f 
ON f.staffid = s.staffid
INNER JOIN faculty_classes AS fc
ON fc.staffid = f.staffid
GROUP BY stffirstname, stflastname
ORDER BY 3 DESC;

/* “3. Challenge: Now solve problem 2 by using a subquery.”*/
SELECT firstname, lastname, num_of_classes
FROM
(SELECT stffirstname AS firstname, stflastname AS lastname, COUNT(fc.classid) AS num_of_classes
FROM staff AS s
FULL OUTER JOIN faculty AS f 
ON f.staffid = s.staffid
FULL OUTER JOIN faculty_classes AS fc
ON fc.staffid = f.staffid
GROUP BY stffirstname, stflastname) AS t
ORDER BY 3 DESC;


--- BOWLING LEAGUE DATABASE ---

/* “1. “Display for each bowler the bowler name and the average of the bowler’s raw game
               scores.”*/
SELECT bowlerfirstname || ' ' || bowlerlastname AS bowler, ROUND(AVG(rawscore), 2) AS avg_raw_score
FROM bowlers AS b
INNER JOIN bowler_scores AS bs
ON bs.bowlerid = b.bowlerid
GROUP BY bowlerfirstname, bowlerlastname
ORDER BY 2 DESC;

/* “2. “Calculate the current average and handicap for each bowler.”*/
SELECT bowlerfirstname, bowlerlastname,
(0.9*(200 - AVG(rawscore)))::integer AS handicap
FROM bowlers AS b
INNER JOIN bowler_scores AS bs
ON bs.bowlerid = b.bowlerid
GROUP BY bowlerfirstname, bowlerlastname
ORDER BY 3;

/* “3. Challenge: “Display the highest raw score for each bowler,” but solve it by using a subquery.”*/
SELECT bowlers.bowlerfirstname, bowlers.bowlerlastname,
(SELECT MAX(rawscore)
FROM bowler_scores AS bs
INNER JOIN bowlers AS b
ON b.bowlerid = bs.bowlerid
WHERE b.bowlerid = bs.bowlerid) AS max_score
FROM bowlers;
