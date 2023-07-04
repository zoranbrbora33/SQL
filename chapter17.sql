--- SALES DATABASE ---

/* “1. “Delete products that have never been ordered.”*/
--- saftey ---
SELECT productnumber 
FROM products
WHERE productnumber NOT IN
(SELECT productnumber
FROM order_details);

--- delete ---
DELETE FROM products
WHERE productnumber NOT IN
(SELECT productnumber
FROM order_details);

/* “2. “Delete employees who haven’t sold anything.”*/
--- safety ---
SELECT *
FROM employees
WHERE employeeid NOT IN
(SELECT employeeid
FROM orders)

--- delete ---
DELETE FROM employees
WHERE employeeid NOT IN
(SELECT employeeid
FROM orders)

/*“3. “Delete any categories that have no products.”*/
--- safety ---
SELECT categoryid FROM categories
WHERE categoryid IN
(SELECT categoryid
FROM products
WHERE quantityonHand = 0)

--- delete ---
DELETE FROM categories
WHERE categoryid IN
(SELECT categoryid
FROM products
WHERE quantityonHand = 0)


--- ENTERTAINMENT DATABASE ---
