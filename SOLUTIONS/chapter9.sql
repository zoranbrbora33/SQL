--- SALES DATABASE ---

/* “1. “Show me customers who have never ordered a helmet.”*/
SELECT (customers.custfirstname || ' ' || customers.custlastname) AS customer
FROM (SELECT orders.customerid, order_details.ordernumber, order_details.productnumber, products.productname
	 FROM orders
	 INNER JOIN order_details ON orders.ordernumber = order_details.ordernumber
	 INNER JOIN products ON order_details.productnumber = products.productnumber
	 WHERE products.productname LIKE '%Helmet%') AS helmet
FULL OUTER JOIN customers
ON helmet.customerid = customers.customerid
WHERE helmet.ordernumber IS NULL;

/* “2. “Display customers who have no sales rep (employees) in the same ZIP Code.”*/
SELECT (custfirstname || ' ' || custlastname) AS customer
FROM customers
LEFT JOIN employees ON customers.custzipcode = employees.empzipcode
WHERE employees.empzipcode IS NULL
ORDER BY custfirstname, custlastname;

/* “3. “List all products and the dates for any orders.”*/
SELECT productname, dates.orderdate
FROM (SELECT  DISTINCT orders.orderdate, order_details.productnumber
	 FROM orders
	 RIGHT JOIN order_details ON orders.ordernumber = order_details.orderNumber) as dates
RIGHT JOIN products ON products.productnumber = dates.productnumber
ORDER BY dates.orderdate;


--- ENTERTAINMENT DATABASE ---

/* “1. “Display agents who haven’t booked an entertainer.”*/
SELECT (jobs.agtfirstname || ' ' || jobs.agtlastname) AS agent
FROM (SELECT e.startdate, agt.datehired, agt.agtfirstname, agt.agtlastname
	 FROM engagements AS e
	 FULL OUTER JOIN agents AS agt ON e.agentid = agt.agentid
	 WHERE e.startdate IS NULL) AS jobs
	
/* “2. “List customers with no bookings.”*/
SELECT (custfirstname || ' ' || custlastname) AS customer
FROM (SELECT c.customerid, e.customerid, c.custfirstname, c.custlastname
	 FROM customers c
	 FULL OUTER JOIN engagements AS e ON c.customerid = e.customerid
	 WHERE e.customerid IS NULL) AS bookings;

/* “3. “List all entertainers and any engagements they have booked.”*/
SELECT gigs.engagementnumber AS gig, gigs.entstagename AS entertainer
FROM (SELECT eng.engagementnumber, ent.entstagename
	 FROM engagements AS eng
	 FULL OUTER JOIN entertainers AS ent
	 ON eng.entertainerid = ent.entertainerid) gigs;


--- SCHOOL DATABASE ---

/* “1. “Show me classes that have no students enrolled.”*/
SELECT subjectname FROM classes
INNER JOIN student_schedules ON classes.classid = student_schedules.classid
INNER JOIN subjects ON classes.subjectid = subjects.subjectid
WHERE classstatus <> 3
ORDER BY subjectname;

/* “2. “Display subjects with no faculty assigned.”*/
SELECT subjectname AS subject FROM faculty_subjects
FULL OUTER  JOIN subjects ON faculty_subjects.subjectid = subjects.subjectid
WHERE faculty_subjects.subjectid IS NULL;

/* “3. “List students not currently enrolled in any classes.”*/
SELECT (studfirstname || ' ' || studlastname) AS students
FROM (SELECT sc.studentid
	 FROM student_class_status AS scs
	 LEFT JOIN student_schedules AS sc ON scs.classstatus = sc.classstatus
	 WHERE scs.classstatusdescription = 'Enrolled') AS not_enrolled
FULL OUTER JOIN students
ON not_enrolled.studentid = students.studentid
WHERE not_enrolled.studentid IS NULL;

/* “4. “Display all faculty and the classes they are scheduled to teach.”*/
SELECT (stffirstname || ' ' || stflastname) AS faculty_member, 
subjects.title, 
subjects.status, subjects.tenured, 
subjects.classid AS class_number, 
subjects.subjectname AS class
FROM (SELECT faculty.staffid, faculty.title, faculty.status, faculty.tenured, fc.classid, subjects.subjectname
	 FROM faculty 
	 INNER JOIN faculty_classes AS fc ON faculty.staffid = fc.staffid
	 LEFT JOIN classes ON fc.classid = classes.classid
	 LEFT JOIN subjects ON classes.subjectid = subjects.subjectid) AS subjects
FULL OUTER JOIN staff ON subjects.staffid = staff.staffid
ORDER BY  (stffirstname || ' ' || stflastname);


--- BOWLING DATABASE ---

/* “1. “Display matches with no game data.”*/
SELECT tourney_matches.matchid AS match, tourney_matches.tourneyid AS tournament_number, 
tourney_matches.lanes, tourney_matches.oddlaneteamid AS odd_lane_team, 
tourney_matches.evenlaneteamid AS even_lane_team
FROM match_games
FULL OUTER JOIN tourney_matches ON match_games.matchid = tourney_matches.matchid
WHERE match_games.matchid IS NULL;

/* “2. “Display all tournaments and any matches that have been played.”*/
SELECT tournaments.tourneylocation, matches.matchid
FROM (SELECT tm.tourneyid, tm.matchid
	 FROM match_games
	 LEFT JOIN tourney_matches AS tm
	 ON match_games.matchid = tm.matchid) AS matches
FULL OUTER JOIN tournaments ON matches.tourneyid = tournaments.tourneyid;


--- RECIPES DATABASE ---

/* “1. “Display missing types of recipes.”*/
SELECT * FROM recipe_classes
LEFT JOIN recipes ON recipe_classes.recipeclassid = recipes.recipeclassid
WHERE recipetitle IS NULL;

/* “2. “Show me all ingredients and any recipes they’re used in.”*/
SELECT ingredient_used.ingredientname AS ingredient, recipes.recipetitle AS recipe
FROM (SELECT ing.ingredientname, ri.recipeid
	 FROM ingredients AS ing
	 LEFT JOIN recipe_ingredients AS ri ON ing.ingredientid = ri.ingredientid) AS ingredient_used
FULL OUTER JOIN recipes ON ingredient_used.recipeid = recipes.recipeid;

/* “3. “List the salad, soup, and main course categories and any recipes.”*/
SELECT recipes.recipetitle AS recipe, recipes.recipeclassdescription AS recipe_description
FROM (SELECT r.recipetitle, rc.recipeclassdescription
	 FROM recipe_classes AS rc
	 FULL JOIN recipes AS r ON rc.recipeclassid = r.recipeclassid
	 WHERE rc.recipeclassid IN (1, 4, 7)) AS recipes
ORDER BY recipes.recipeclassdescription;

/* “4. “Display all recipe classes and any recipes.”*/
SELECT recipe_classes.recipeclassdescription AS recipe_class,
recipetitle AS recipe
FROM recipe_classes
FULL OUTER JOIN recipes ON recipe_classes.recipeclassid = recipes.recipeclassid
ORDER BY recipe_class, recipetitle;