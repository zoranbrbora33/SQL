--- SALES  DATABASE ---

/* “1. “List customers and the dates they placed an order, sorted in order date sequence.”*/
SELECT custfirstname || ' ' || custlastname AS customer, orderdate AS order_date
FROM customers
INNER JOIN orders
ON customers.customerid = orders.customerid
ORDER BY orderdate;

/* “2. “List employees and the customers for whom they booked an order.”*/
SELECT DISTINCT custfirstname || ' ' || custlastname AS customer, 
empfirstname || ' ' || emplastname AS employee
FROM orders
INNER JOIN customers ON orders.customerid = customers.customerid
INNER JOIN employees ON orders.employeeid = employees.employeeid
ORDER BY empfirstname || ' ' || emplastname;

/* “3. “Display all orders, the products in each order, and the amount owed for each product,
               in order number sequence.”*/
SELECT orders.ordernumber AS order_number, productname AS product, quotedprice AS amount 
FROM orders
INNER JOIN  order_details ON orders.ordernumber = order_details.ordernumber
INNER JOIN products ON order_details.productnumber = products.productnumber;

/*“4. “Show me the vendors and the products they supply to us for products that cost less
               than $100.”*/
SELECT vendname AS vendor, productname AS product
FROM vendors
INNER JOIN product_vendors ON vendors.vendorid = product_vendors.vendorid
INNER JOIN products ON product_vendors.productnumber = products.productnumber
WHERE wholesaleprice < 101;

/* “5. “Show me customers and employees who have the same last name.”*/
SELECT custfirstname || ' ' || custlastname AS customer, 
empfirstname || ' ' || emplastname
FROM customers 
INNER JOIN employees ON customers.custlastname = employees.emplastname;

/* “6. “Show me customers and employees who live in the same city.”*/
SELECT custfirstname || ' ' || custlastname AS customer, 
empfirstname || ' ' || emplastname AS employee , custcity, empcity
FROM customers 
INNER JOIN employees ON customers.custcity = employees.empcity;


--- ENTERTAINMENT DATABASE ---

/* “1. “Display agents and the engagement dates they booked, sorted by booking start date.”*/
SELECT agtfirstname || ' ' || agtlastname, startdate
FROM agents
INNER JOIN engagements
ON agents.agentid = engagements.agentid
ORDER BY startdate;

/* “2. “List customers and the entertainers they booked.”*/
SELECT DISTINCT custfirstname || ' ' || custlastname AS customer,
entstagename AS entertainer
FROM customers
INNER JOIN engagements ON customers.customerid = engagements.customerid
INNER JOIN entertainers ON engagements.entertainerid = entertainers.entertainerid;

/* “3. “Find the agents and entertainers who live in the same postal code.”*/
SELECT agtfirstname || ' ' || agtlastname AS agent,
entstagename AS entertainer, agtzipcode, entzipcode
FROM agents
INNER JOIN entertainers
ON agents.agtzipcode = entertainers.entzipcode;


--- SCHOOL DATABASE ---

/* “1. “Display buildings and all the classrooms in each building.”*/
SELECT buildingname, classroomid 
FROM buildings
INNER JOIN class_rooms
ON buildings.buildingcode = class_rooms.buildingcode;

/* “2. “List students and all the classes in which they are currently enrolled.”*/
SELECT studfirstname || ' ' || studlastname AS student, subjectname AS class
FROM students 
INNER JOIN student_schedules ON students.studentid = student_schedules.studentid
INNER JOIN classes ON student_schedules.classid = classes.classid
INNER JOIN subjects ON classes.subjectid = subjects.subjectid
WHERE classstatus = 1;

/* “3. “List the faculty staff and the subject each teaches.”*/
SELECT stffirstname || ' ' || stflastname AS professor, subjectname AS subject
FROM staff 
INNER JOIN faculty_subjects ON staff.staffid = faculty_subjects.staffid
INNER JOIN subjects ON subjects.subjectid = faculty_subjects.subjectid
ORDER BY stffirstname || ' ' || stflastname;

/* “4. “Show me the students who have a grade of 85 or better in art and who also have a
               grade of 85 or better in any computer course.”*/
SELECT art.student_full_name
FROM
(
  SELECT students.studentid,
  (students.studfirstname || ' ' || students.studlastname) AS student_full_name
  FROM ((students
  INNER JOIN student_schedules ON students.studentid = student_schedules.studentid)
  INNER JOIN classes ON student_schedules.classid = classes.classid)
  INNER JOIN subjects ON classes.subjectid = subjects.subjectid
  WHERE subjects.subjectname LIKE '%Art%'
  AND student_schedules.grade >= 85
) AS art
INNER JOIN
(
  SELECT students.studentid,
  (students.studfirstname || ' ' || students.studlastname) AS student_full_name
  FROM ((students
  INNER JOIN student_schedules ON students.studentid = student_schedules.studentid)
  INNER JOIN classes ON student_schedules.classid = classes.classid)
  INNER JOIN subjects ON classes.subjectid = subjects.subjectid
  WHERE subjects.subjectname LIKE '%Computer%'
  AND student_schedules.grade >= 85
) AS computer
ON art.studentid = computer.studentid


--- BOWLING LEAGUE DATABASE ---

/* “1. “List the bowling teams and all the team members.”*/
SELECT teamname AS team, bowlerfirstname || ' ' || bowlerlastname AS bowler
FROM teams
INNER JOIN bowlers
ON teams.teamid = bowlers.teamid;

/* “2. “Display the bowlers, the matches they played in, and the bowler game scores.”*/
SELECT  bowlerfirstname || ' ' || bowlerlastname AS bowler, rawscore AS score, tourney_matches.matchid AS match
FROM bowlers
INNER JOIN bowler_scores ON bowlers.bowlerid = bowler_scores.bowlerid
INNER JOIN tourney_matches ON bowler_scores.matchid = tourney_matches.matchid;

/* “3. “Find the bowlers who live in the same ZIP Code.”*/
SELECT b1.bowlerfirstname || ' ' || b1.bowlerlastname AS bowler1, 
b2.bowlerfirstname || ' ' || b2.bowlerlastname AS bowler2, b1.bowlerzip, b2.bowlerzip
FROM bowlers b1
INNER JOIN bowlers b2
ON b1.bowlerzip = b2.bowlerzip
WHERE b1.bowlerzip = b2.bowlerzip AND b1.bowlerid <> b2.bowlerid
ORDER BY b1.bowlerfirstname || ' ' || b1.bowlerlastname;


--- RECIPES DATABASE ---

/* “1. “List all the recipes for salads.”*/
SELECT recipetitle AS recipe 
FROM recipes
INNER JOIN recipe_classes ON recipes.recipeclassid = recipe_classes.recipeclassid
WHERE recipeclassdescription = 'Salad';

/* “2. “List all recipes that contain a dairy ingredient.”*/
SELECT DISTINCT recipetitle AS recipe 
FROM recipes
INNER JOIN recipe_ingredients ON recipes.recipeid = recipe_ingredients.recipeid
INNER JOIN ingredients ON recipe_ingredients.ingredientid = ingredients.ingredientid
INNER JOIN ingredient_classes ON ingredients.ingredientclassid = ingredient_classes.ingredientclassid
WHERE ingredientclassdescription = 'Dairy';

/* “3. “Find the ingredients that use the same default measurement amount.”*/
SELECT ing1.ingredientname
FROM ingredients AS ing1
INNER JOIN ingredients AS ing2 ON
(ing1.ingredientid <> ing2.ingredientid) AND (ing1.measureamountid = ing2.measureamountid);

/* “4. “Show me the recipes that have beef and garlic.”*/
SELECT beef.recipetitle
FROM
(
  SELECT recipes.recipeid, recipes.recipetitle
  FROM recipes
  INNER JOIN recipe_ingredients ON recipes.recipeid = recipe_ingredients.recipeid
  WHERE recipe_ingredients.ingredientid = 1
) AS beef

INNER JOIN 
(
  SELECT recipes.recipeid, recipes.recipetitle
  FROM recipes
  INNER JOIN recipe_ingredients ON recipes.recipeid = recipe_ingredients.recipeid
  WHERE recipe_ingredients.ingredientid = 9
) AS garlic
ON beef.recipeid = garlic.recipeid;