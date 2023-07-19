--- SALES ORDERS DATABASE ---

/* “1. “Give me the names of all vendors based in Ballard, Bellevue, and Redmond.”*/
SELECT vendname FROM vendors
WHERE vendcity IN ('Ballard', 'Bellevue', 'Redmond')
ORDER BY vendcity;

/* “2. “Show me an alphabetized list of products with a retail price of $125.00 or more.”*/
SELECT productname AS product, retailprice AS price FROM products
WHERE retailprice >= 125
ORDER BY productname ASC;

/* “3. "Which vendors do we work with that don’t have a Web site?”*/
SELECT vendname AS vendor FROM vendors
WHERE vendwebpage IS NULL;


--- ENTERTAINMENT DATABASE ---

/* “1. “Let me see a list of all engagements that occurred during October 2017.”*/
SELECT engagementnumber AS engagement, startdate FROM engagements
WHERE startdate >= '2017-10-01' AND  startdate <= '2017-10-31' 
OR enddate >= '2017-10-01' AND  enddate <= '2017-10-31'; 

/* “2. “Show me any engagements in October 2017 that start between noon and 5 p.m.”*/
SELECT engagementnumber AS engagement, startdate, starttime FROM engagements
WHERE starttime >= '12:00:00' AND starttime <= '17:00:00' 
AND startdate >= '2017-10-01' AND  startdate <= '2017-10-31';

/* “3. “List all the engagements that start and end on the same day.”*/
SELECT engagementnumber AS engagement, startdate, enddate FROM engagements
WHERE startdate = enddate;


--- SCHOOL DATABASE ---

/* “1. “Show me which staff members use a post office box as their address.”*/
SELECT stffirstname || ' ' || stflastname AS staff_member, stfstreetaddress AS post_office_address FROM staff
WHERE stfstreetaddress LIKE '%Box%';

/* “2. “Can you show me which students live outside of the Pacific Northwest?”*/
SELECT studfirstname || ' ' || studlastname as student FROM students
WHERE studstate NOT IN ('WA', 'OR');

/* “3. “List all the subjects that have a subject code starting ‘MUS’.”*/
SELECT subjectname FROM subjects
WHERE subjectcode LIKE 'MUS%';

/* “4. “Produce a list of the ID numbers all the Associate Professors who are employed full
               time.”*/
SELECT staffid AS staff_id, title, status FROM faculty
WHERE title = 'Associate Professor' AND status = 'Full Time';


--- BOWLING LEAGUE DATABASE ---

/* “1. “Give me a list of the tournaments held during September 2017.”*/
SELECT tourneylocation FROM tournaments
WHERE tourneydate BETWEEN '2017-09-01' AND '2017-09-30';

/* “2. “What are the tournament schedules for Bolero, Red Rooster, and Thunderbird Lanes?”*/
SELECT tourneylocation, tourneydate FROM tournaments
WHERE tourneylocation IN ('Bolero Lanes', 'Red Rooster Lanes', 'Thunderbird Lanes')
ORDER BY tourneylocation;

/* “3. “List the bowlers who live on the Eastside (you know—Bellevue, Bothell, Duvall, Redmond,
               and Woodinville) and who are on teams 5, 6, 7, or 8.”*/
SELECT bowlerfirstname || ' ' || bowlerlastname AS bowler FROM bowlers
WHERE bowlercity IN ('Bellevue', 'Bothell', 'Duvall', 'Redmond', 'Woodinville')
AND teamid IN (5, 6, 7, 8);


--- RECIPES DATABASE ---

/* “1. “List all recipes that are main courses (recipe class is 1) and that have notes.”*/
SELECT recipetitle AS main_course FROM recipes
WHERE recipeclassid = 1 AND notes IS NOT NULL;

/* “2. “Display the first five recipes.”*/
SELECT recipetitle AS recipe FROM recipes
LIMIT 5;


--- MY SAMPLE STATEMENTS SOLUTIONS ---

--- SALES DATABASE ---

/* “Show me all the orders for customer number 1001.”*/
SELECT ordernumber 
FROM orders
WHERE customerid = 1001;

/* “Show me an alphabetized list of products with names that begin with ‘Dog’.”*/
SELECT productname
FROM products
WHERE productname LIKE 'Dog%'
ORDER BY productname ASC;


--- ENTERTAINMENT DATBASE ---

/* “Show me an alphabetical list of entertainers based in Bellevue, Redmond, or Woodinville.”*/
SELECT entertainerid AS id, entstagename AS entertainer
FROM entertainers
WHERE entcity IN ('Bellevue', 'Redmond', 'Woodinville')
ORDER BY entstagename ASC;

/* “Show me all the engagements that run for four days.”*/
SELECT * FROM engagements
WHERE CAST(enddate - startdate AS INTEGER) = 3;


--- SCHOOL DATABASE ---

/* “Show me an alphabetical list of all the staff members and their salaries if they
               make between $40,000 and $50,000 a year.”*/
SELECT CONCAT(stffirstname, ' ', stflastname) AS staff
FROM staff
WHERE salary BETWEEN 40000 AND 50000;

/* “Show me a list of students whose last name is ‘Kennedy’ or who live in Seattle.”*/
SELECT CONCAT(studfirstname, ' ', studlastname) AS student
FROM students
WHERE studlastname = 'Kennedy' or studcity = 'Seattle';


--- BOWLING DATABASE ---

/* “List the ID numbers of the teams that won one or more of the first ten matches in
               Game 3.”*/
SELECT winningteamid 
FROM match_games
WHERE gamenumber = 3 AND matchid BETWEEN 1 AND 10;

/* “List the bowlers in teams 3, 4, and 5 whose last names begin with the letter ‘H’.”*/
SELECT CONCAT(bowlerfirstname, ' ', bowlerlastname) AS bowler
FROM bowlers
WHERE teamid IN (3, 4, 5) AND bowlerlastname LIKE 'H%';


--- RECIPES DATABASE ---

/* “List the recipes that have no notes.”*/
SELECT * FROM recipes
WHERE notes IS NULL;

/* “Show the ingredients that are meats (ingredient class is 2) but that aren’t chicken.”*/
SELECT * FROM ingredients
WHERE ingredientclassid = 2 AND ingredientname NOT LIKE '%Chicken%';