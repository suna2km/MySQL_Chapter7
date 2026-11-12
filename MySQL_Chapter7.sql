/********************************************************
Date: 2026-11-12
Name: Suna Aregay
Chapter 7 Assignment
Github URL: https://github.com/suna2km/MySQL_Chapter4
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
