-- Find the customerID and name of each customer who bought at least two different products at the same North region store. No duplicates should appear in your result.

SELECT DISTINCT c.customerID, c.custName
FROM Customers c, Sales s1, Sales s2, Stores st
WHERE c.customerID = s1.customerID
  AND c.customerID = s2.customerID
  AND s1.productID <> s2.productID
  AND st.storeID = s1.storeID
  AND st.storeID = s2.storeID
  AND st.region = 'North';

-- DISTINCT is necessary in above solution.

-- c.customerID, s1.customerID and s2.customerID all should be equal, so any two of the
-- conditions c.customerID = s1.customerID, c.customerID = s2.customerID and 
-- s1.customerID = s2.customerID will work; having all 3 is redundant, but okay.

-- st.storeID, 1.storeID and s2.storeID and all should be equal, so any two of the
-- conditions st.storeID = s1.storeID, st.storeID = s1.storeID and 
-- s1.storeID = s2.storeID will work; having all 3 is redundant, but okay.

-- Joining with the Products table to check that there are products with the specified
-- productID values for s1.productID and s2.productID is unnecessary but okay.



-- There are many alternative solutions.  Here are some of them.

SELECT c.customerID, c.custName
FROM Customers c
WHERE EXISTS
         ( SELECT *
           FROM Sales s1, Sales s2, Stores st
           WHERE c.customerID = s1.customerID
             AND c.customerID = s2.customerID
             AND s1.productID <> s2.productID
             AND st.storeID = s1.storeID
             AND st.storeID = s2.storeID
             AND st.region = 'North' );

-- DISTINCT is not necessary in this alternative solution.


SELECT DISTINCT c.customerID, c.custName
FROM Customers c, Stores st
WHERE st.region = 'North'
  AND EXISTS
         ( SELECT *
           FROM Sales s1, Sales s2
           WHERE c.customerID = s1.customerID
             AND c.customerID = s2.customerID
             AND s1.productID <> s2.productID 
             AND st.storeID = s1.storeID
             AND st.storeID = s2.storeID );

-- DISTINCT is necessary in above alternative solution, because customer might have
-- bought 2 different products in multiple North region stores.


SELECT c.customerID, c.custName
FROM Customers c
WHERE c.customerID IN
         ( SELECT s1.customerID
           FROM Sales s1, Sales s2, Stores st
           WHERE s1.customerID = s2.customerID
             AND s1.productID <> s2.productID
             AND st.storeID = s1.storeID
             AND st.storeID = s2.storeID
             AND st.region = 'North' );

-- Could SELECT s2.customerID (instead of s1.customerID) in subquery of this solution.
-- DISTINCT is not necessary in this alternative solution.

-- There also are solutions using "= ANY", and solution with nested subqueries.

-- Finally, here's a solution that uses GROUP BY.

SELECT c.customerID, c.custName
FROM Customers c, Sales s, Stores st
WHERE c.customerID = s.customerID
  AND st.storeID = s.storeID
  AND st.region = 'North'
GROUP BY c.customerID, c.custName, st.storeID
HAVING COUNT(DISTINCT s.productID) >= 2;

-- Credit will be given if you GROUP BY just c.customerID, st.storeID, for reasons
-- discussed at the end of Lecture 6.
-- But you must GROUP BY s.storeID (as well as c.customerID) for answer to be correct.






