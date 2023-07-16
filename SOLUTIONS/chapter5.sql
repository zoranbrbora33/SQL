--- SALES DATABASE --

/* “1. “What if we adjusted each product price by reducing it 5 percent?”*/
SELECT wholesaleprice - 5 AS new_price FROM product_vendors;

/* “2. “Show me a list of orders made by each customer in descending date order.”*/
SELECT * FROM orders;

/* “Compile a complete list of vendor names and addresses in vendor name order.”*/
SELECT customerid, orderdate FROM orders
ORDER BY customerid, orderdate DESC;


--- ENTERTAINMENT DATABASE ---

/* “1. “Give me the names of all our customers by city.”*/
SELECT custfirstname || ' ' || custlastname AS full_name, custcity AS city FROM customers
Order BY custcity;

/* “2. “List all entertainers and their Web sites.”*/
SELECT entstagename AS entertainer, entwebpage AS website FROM entertainers;

/* “3. “Show the date of each agent’s first six-month performance review.”*/
SELECT * FROM agents;
SELECT  datehired, datehired + interval '6 months' FROM agents;


--- SCHOOL DATABASE ---

/* “1. “Give me a list of staff members, and show them in descending order of salary.”*/
SELECT stffirstname AS first_name, stflastname AS last_name, salary FROM staff
ORDER BY salary DESC;
 
/* “2. “Can you give me a staff member phone list?”*/
SELECT stffirstname AS first_name, stflastname AS last_name, stfphonenumber AS phone_number FROM staff; 

/* “3. “List the names of all our students, and order them by the cities they live in.”*/
SELECT studfirstname || ' ' || studlastname AS full_name, studcity FROM students
Order BY studcity;

--- BOWLING LEAGUE DATABASE ---

/* “1. “Show next year’s tournament date for each tournament location.”*/
SELECT tourneylocation AS location, 
DATE(tourneydate + INTERVAL '1 year') AS next_year_date, 
tourneydate 
FROM tournaments;

/* “2. “List the name and phone number for each member of the league.”*/
SELECT bowlerfirstname || ' ' || bowlerlastname AS member, bowlerphonenumber AS phone_number FROM bowlers;

/* “3. “Give me a listing of each team’s lineup.”*/
SELECT bowlerfirstname || ' ' || bowlerlastname AS bowler, teamid AS team FROM bowlers
ORDER BY teamid, bowlerfirstname;


--- MY SAMPLE STATEMENTS SOLUTIONS ---

--- SALES DATABASE ---

/* “What is the inventory value of each product?”*/
SELECT productname AS product, 
retailprice * quantityonhand AS inventory_value
FROM products;

/* “How many days elapsed between the order date and the ship date for each order?”*/
SELECT ordernumber, shipdate - orderdate AS days_elapsed
FROM orders;


--- ENTERTAINMENT DATABASE ---

/* “How long is each engagement due to run?”*/
SELECT engagementnumber, 
CAST(CAST(enddate - startdate AS INTEGER) + 1 AS CHARACTER) || 'day(s)' AS due_to_run
FROM engagements;

/* “What is the net amount for each of our contracts?”*/
SELECT contractprice * 0.12 AS our_fee,
contractprice - (contractprice * 0.12) AS net_fee
FROM engagements;


--- SCHOOL DATABASE ---

/* “List how many complete years each staff member has been with the school as of October
               1, 2017, and sort the result by last name and first name.”*/
SELECT stffirstname, stflastname, 
CAST(CAST('2017-10-01' - datehired AS INTEGER) / 365 AS INTEGER)
FROM staff
ORDER BY stflastname, stffirstname;

/* “Show me a list of staff members, their salaries, and a proposed 7 percent bonus for
            each staff member.”*/
SELECT stffirstname AS first_name, 
stflastname AS last_name, salary, salary * 0.07 AS bonus
FROM staff
ORDER BY stflastname;


--- BOWLING DATABASE ---

/* “Display a list of all bowlers and addresses formatted suitably for a mailing list,
               sorted by ZIP Code.”*/
SELECT CONCAT(bowlerlastname,' ', bowlerfirstname) AS bowler,
bowleraddress AS address,
CONCAT(bowlercity, ', ', bowlerstate, ' ', bowlerzip) AS city_zip,
bowlerzip AS zip_code
FROM bowlers;

/* “What was the point spread between a bowler’s handicap and raw score for each match
            and game played?”*/
SELECT bowlerid, matchid, gamenumber, handicapscore, rawscore,
handicapscore - rawscore AS point_difference
FROM bowler_scores;