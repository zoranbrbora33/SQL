--- BOWLERS DATABASE ---

/* “1. Show me all the information on our employees.”*/
SELECT * FROM vendors;


/* “2. “Show me a list of cities, in alphabetical order, where our vendors are located, and
               include the names of the vendors we work with in each city.”*/
SELECT vendcity, vendname  from vendors
ORDER BY vendcity;

--- ENTERTINMENT DATABASE ---

/*“1. “Give me the names and phone numbers of all our agents, and list them in last name/first
               name order.”*/
SELECT agtfirstname || ' ' || agtlastname AS full_name, agtphonenumber AS phone_number FROM agents
ORDER BY agtlastname, agtfirstname;

/* “2. "Give me the information on all our engagements.”*/
SELECT * FROM engagements;

/* “3. “List all engagements and their associated start dates. Sort the records by date in
               descending order and by engagement in ascending order.”*/
SELECT engagementnumber, startdate FROM engagements
ORDER BY startdate DESC, engagementnumber ASC;

--- SCHOOL DATABASE ---

/*“1. “Show me a complete list of all the subjects we offer.”*/
SELECT categorydescription AS subjects FROM categories;

/*“2. “What kinds of titles are associated with our faculty?”*/
SELECT DISTINCT title FROM faculty;

/*“3. “List the names and phone numbers of all our staff, and sort them by last name and
               first name.”*/
SELECT  stffirstname || ' ' || stflastname AS full_name, stfphonenumber AS phone_number FROM staff
ORDER BY stflastname, stffirstname;

--- BOWLING LEAGUE DATABASE ---

/*“1. “List all of the teams in alphabetical order.”*/
SELECT teamname FROM teams
ORDER BY teamname ASC;

/*“2. Show me all the bowling score information for each of our members.”*/
SELECT bowlerid, rawscore, handicapscore FROM bowler_scores;

/*“3. “Show me a list of bowlers and their addresses, and sort it in alphabetical order.”*/
SELECT bowlerfirstname || ' ' || bowlerlastname AS full_name, bowleraddress AS address FROM bowlers
ORDER BY bowlerfirstname;

--- RECIPES DATABASE ---

/*“1. “Show me a list of all the ingredients we currently keep track of.”*/
SELECT  ingredientname AS ingredient FROM ingredients;

/*“2. “Show me all the main recipe information, and sort it by the name of the recipe in
               alphabetical order.”*/
SELECT * FROM recipes
ORDER BY recipetitle;

