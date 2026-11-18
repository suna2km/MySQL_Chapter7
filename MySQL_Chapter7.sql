/********************************************************
Date: 2026-11-12
Name: Suna Aregay
Chapter 7 Assignment
Github URL: https://github.com/suna2km/MySQL_Chapter7
*********************************************************/
/*************************************************************
Query 1: WHERE subquery returning one value
Write a query that uses a subquery in the WHERE clause to count
the number of payments that are greater than the average.
**************************************************************/
SELECT COUNT(amount) AS payments_above_avg
FROM payment
WHERE amount > 
    (SELECT AVG(amount) AS payments_above_avg 
     FROM payment)
ORDER BY amount;
/*************************************************************
Query 2: WHERE clause using IN operator subquery returning a list
2.A Write a query that uses a subquery in the WHERE clause using the IN operator to displays all payments for
customers associated with store id 2. Order by customer id and payment date.
2.B Rewrite the query to use a INNER JOIN (default join type) instead of a subquery
**************************************************************/
-- 2.A
SELECT customer_id, payment_date, amount
FROM payment
WHERE customer_id IN 
    (SELECT customer_id
     FROM customer
     WHERE store_id = 2)
ORDER BY customer_id, payment_date;
-- 2.B
SELECT p.customer_id, p.payment_date, p.amount
FROM payment p JOIN customer c
	ON p.customer_id = c.customer_id
WHERE store_id = 2
ORDER BY customer_id, payment_date;
/*************************************************************
Query 3: WHERE clause using the ALL operator subquery returning a list
3.A Write a query that uses a subquery in the WHERE clause using the ALL operator to display all customer's payments
where the amount is greater than all of customer 1's payments. Order by customer id and payment date.
3.B Rewrite the query to use a subquery using the MAX aggerated function instead of ALL operator.
**************************************************************/
-- 3.A
SELECT customer_id, payment_date, amount
FROM payment
WHERE amount > ALL 
    (SELECT amount
     FROM payment
     WHERE customer_id = 1)
ORDER BY customer_id, payment_date;
-- 3.B
SELECT customer_id, payment_date, amount
FROM payment
WHERE amount >
    (SELECT MAX(amount)
     FROM payment
     WHERE customer_id = 1)
ORDER BY customer_id, payment_date;
/*************************************************************
Query 4: WHERE correlated subquery running multiple times (once for each outer row)
4.A Write a query that uses the AVG aggerated function to display each customer's 
average amount paid.
4.B Write a query that uses a correlated subquery in the WHERE clause to count all customer's payments greater than
the customer's average payment.
**************************************************************/
-- 4.A
SELECT customer_id, AVG(amount)
FROM payment
GROUP BY customer_id     
ORDER BY customer_id;
-- 4.B
SELECT p.customer_id, COUNT(*)
FROM payment p
WHERE p.amount >
	(SELECT AVG(p2.amount)
     FROM payment p2
     WHERE p.customer_id = p2.customer_id)
GROUP BY p.customer_id;
/*************************************************************
Query 5: WHERE subquery using EXISTS operator returning a Boolean value
NOTE: create a new customer so that there is at least one customer without a payment
5.A Write a query that uses a subquery in the WHERE clause with the NOT EXISTS operator for customers who do not
have any payments. Order by customer id.
5.B Rewrite the query to use a LEFT JOIN instead of a subquery
**************************************************************/
-- 5.A
SELECT customer_id, first_name, last_name
FROM customer c
WHERE NOT EXISTS
    (SELECT * 
     FROM payment p
     WHERE c.customer_id = p.customer_id)
ORDER BY c.customer_id;
-- 5.B
SELECT c.customer_id, first_name, last_name
FROM customer c
	LEFT JOIN payment p
		ON c.customer_id = p.customer_id
WHERE payment_id IS NULL
ORDER BY customer_id;
