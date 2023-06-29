--- SALES DATABASE ---

/* “1. “List the customers who ordered a helmet together with the vendors who provide helmets.”*/
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


--- ENTERTAINMENT DATABASE ---

/* “1. “Display a combined list of customers and entertainers.”*/
SELECT (custfirstname || ' ' || custlastname) AS people, 'customer' AS role 
FROM customers
UNION ALL
SELECT entstagename, 'entertainer' AS role
FROM entertainers;

/* “2. “Produce a list of customers who like contemporary music together with a list of entertainers
               who play contemporary music.”*/
SELECT c.custfirstname || ' ' || c.custlastname AS full_name, 'customer' AS role,
stylename AS style
FROM customers AS c
INNER JOIN musical_preferences AS mp
ON c.customerid = mp.customerid
INNER JOIN musical_styles AS ms
ON mp.styleid = ms.styleid
WHERE ms.styleid = 10
UNION ALL
SELECT entstagename, 'entertainer' AS role, stylename
FROM entertainers AS e
INNER JOIN entertainer_styles AS es
ON e.entertainerid = es.entertainerid
INNER JOIN musical_styles AS ms
ON es.styleid = ms.styleid
WHERE ms.styleid = 10;


--- SCHOOL DATABASE ---

/* “1. “Create a mailing list for students and staff, sorted by ZIP Code.”*/
SELECT (stffirstname || ' ' || stflastname) AS full_name, stfstreetaddress AS street_address,
stfcity AS city, stfstate AS state, stfzipcode AS zipcode, 
stfareacode AS areacode, stfphonenumber AS phone_number, 'staff' AS role
FROM staff
UNION ALL
SELECT (studfirstname || ' ' || studlastname), studstreetaddress,
studcity, studstate, studzipcode, studareacode, studphonenumber, 'student' AS role
FROM students
ORDER BY 5;


--- BOWLING LEAGUE DATABASE ---

/* “1. “Find the bowlers who had a raw score of 165 or better at Thunderbird Lanes combined
               with bowlers who had a raw score of 150 or better at Bolero Lanes.”*/

--- solution using UNION ---

SELECT *
FROM (SELECT (bowlerlastname || ' ' || bowlerfirstname) AS bowler, rawscore,
	  tourneylocation AS location
	 FROM bowlers AS b
	 INNER JOIN bowler_scores AS bs ON b.bowlerid = bs.bowlerid
	 INNER JOIN tourney_matches AS tm ON bs.matchid = tm.matchid
	 INNER JOIN tournaments AS t ON tm.tourneyid = t.tourneyid
	 WHERE rawscore > 165 AND tourneylocation = 'Thunderbird Lanes') AS bowlers
UNION ALL
SELECT *
FROM (SELECT (bowlerlastname || ' ' || bowlerfirstname) AS bowler, rawscore,
	  tourneylocation AS location
	 FROM bowlers AS b
	 INNER JOIN bowler_scores AS bs ON b.bowlerid = bs.bowlerid
	 INNER JOIN tourney_matches AS tm ON bs.matchid = tm.matchid
	 INNER JOIN tournaments AS t ON tm.tourneyid = t.tourneyid
	 WHERE rawscore > 150  AND tourneylocation = 'Bolero Lanes') AS bowlers
ORDER BY 3, 2;

--- solution with single select statement ---

SELECT bowlerfirstname || ' ' || bowlerlastname AS bowler, rawscore AS score,
tourneylocation AS tournaments
FROM bowlers AS b
INNER JOIN bowler_scores AS bs ON b.bowlerid = bs.bowlerid
INNER JOIN tourney_matches AS tm ON bs.matchid = tm.matchid
INNER JOIN tournaments as t ON tm.tourneyid = t.tourneyid
WHERE (rawscore > 165 AND tourneylocation = 'Thunderbird Lanes')
OR (rawscore > 150 AND tourneylocation = 'Bolero Lanes')
ORDER BY 3, 2;


--- RECIPES DATABASE ---

/* “1. “Display a list of all ingredients and their default measurement amounts together
               with ingredients used in recipes and the measurement amount for each recipe.”*/
SELECT used.ingredientname AS ingredient, used.measurementdescription AS measurement, 'used' AS role
FROM (SELECT  DISTINCT rc.ingredientid, i.ingredientname, m.measurementdescription
	 FROM recipe_ingredients AS rc
	 INNER JOIN ingredients AS i ON rc.ingredientid = i.ingredientid
	 INNER JOIN measurements AS m ON rc.measureamountid = m.measureamountid) AS used
UNION ALL
SELECT i.ingredientname, m.measurementdescription, 'default' AS role
FROM ingredients AS i
LEFT JOIN measurements AS m ON i.measureamountid = m.measureamountid
ORDER BY 3;