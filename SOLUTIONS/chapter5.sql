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