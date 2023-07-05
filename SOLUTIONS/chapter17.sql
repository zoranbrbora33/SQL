--- SALES DATABASE ---

/* “1. “Delete products that have never been ordered.”*/
DELETE FROM products
WHERE productnumber NOT IN
(SELECT productnumber
FROM order_details);

/* “2. “Delete employees who haven’t sold anything.”*/
DELETE FROM employees
WHERE employeeid NOT IN
(SELECT employeeid
FROM orders)

/*“3. “Delete any categories that have no products.”*/
DELETE FROM categories
WHERE categoryid IN
(SELECT categoryid
FROM products
WHERE quantityonHand = 0)


--- ENTERTAINMENT DATABASE ---

/*“1. “Delete customers who have never booked an entertainer.”*/
DELETE FROM musical_preferences
WHERE customerid NOT IN
(SELECT customerid
FROM customers);

DELETE 
FROM customers
WHERE customerid NOT IN
(SELECT customerid
FROM engagements);

/* “2. “Delete musical styles that aren’t played by any entertainer.”*/
DELETE FROM musical_preferences
WHERE styleid NOT IN
(SELECT styleid
FROM entertainer_styles);

DELETE FROM
musical_styles
WHERE styleid NOT IN
(SELECT styleid
FROM entertainer_styles);

/* “3. “Delete members who are not part of an entertainment group.”*/
DELETE FROM
members
WHERE memberid NOT IN
(SELECT memberid
FROM entertainers);


--- SCHOOL DATABASE ---

/* “1. “Delete all students who are not registered for any class.”*/
DELETE FROM students
WHERE studentid IN
(SELECT studentid
FROM student_schedules
WHERE studentid NOT IN
	(SELECT studentid
	FROM student_schedules AS sc
	WHERE classstatus  IN (1)));

/* “2. “Delete subjects that have no classes.”*/
DELETE FROM faculty_subjects
WHERE subjectid NOT IN
(SELECT subjectid 
FROM classes);

DELETE subjectid 
FROM subjects
WHERE subjectprereq IS NULL
AND subjectid NOT IN
(SELECT subjectid
FROM classes);