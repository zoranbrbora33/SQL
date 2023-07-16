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


--- MY SAMPLE STATEMENTS SOLUTIONS ---

--- SALES DATABASE ---

/* “Show me the names of all our vendors.”*/
SELECT vendname AS vendors 
FROM vendors;

/* “What are the names and prices of all the products we carry?”*/
SELECT productname AS product, retailprice AS price 
FROM products;

/* “Which states do our customers come from?”*/
SELECT DISTINCT custstate AS state
FROM customers;


--- ENTERTAINMENT DATABASE ---

/* “List all entertainers and the cities they’re based in, and sort the results by city
               and name in ascending order.”*/
SELECT entstagename AS entertainer, entcity AS city
FROM entertainers
ORDER BY city, entertainer;

/* “Give me a unique list of engagement dates. I’m not concerned with how many engagements
            there are per date.”*/
SELECT DISTINCT startdate 
FROM engagements;


--- SCHOOL DATABASE ---

/* “Can we view complete class information?”*/
SELECT *
FROM classes;

/* “Give me a list of the buildings on campus and the number of floors for each building.
            Sort the list by building in ascending order.”*/
SELECT buildingname AS building, numberoffloors AS num_of_floors
FROM buildings
ORDER BY building;


--- BOWLING DATABASE ---

/* “Where are we holding our tournaments?”*/
SELECT DISTINCT tourneylocation AS tournaments
FROM tournaments;

/* “Give me a list of all tournament dates and locations. I need the dates in descending
               order and the locations in alphabetical order.”*/
SELECT tourneydate AS date,tourneylocation AS location
FROM tournaments
ORDER BY date DESC, location;


--- RECIPES DATABASE ---

/* “What types of recipes do we have, and what are the names of the recipes we have for
               each type? Can you sort the information by type and recipe name?”*/
SELECT recipeclassid AS recipe_id, recipetitle AS recipe
FROM recipes
ORDER BY recipe_id, recipe;

/* “Show me a list of unique recipe class IDs in the recipes table.”*/
SELECT DISTINCT recipeclassid AS recipe_id
FROM recipes
ORDER BY recipe_id;