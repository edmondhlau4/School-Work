-- NOTE
-- the description of queryview tells students that they need to include the query, the results of the query as a comment, the delete statements and the results of the query after the delete as a comment. But they only have to include the query once.


SELECT  c.customerID, c.custName, cleared.totalClearedPayments, COUNT(DISTINCT s.productID) AS numDiffProducts
FROM    Customers c, ClearedPayments cleared, Sales s
WHERE   c.customerID = cleared.customerID 
    AND c.customerID = s.customerID
    AND c.amountOwed < cleared.totalClearedPayments 
GROUP BY c.customerID, c.custName, cleared.totalClearedPayments
HAVING COUNT(DISTINCT s.productID) >= 3;

-- query result before delection:

--  customerid |   custname    | totalclearedpayments | numdiffproducts
-- ------------+---------------+----------------------+-----------------
--        1001 | Ami Maggio    |               269.11 |               5
--        1002 | India Crona   |               364.56 |               5
--        1004 | Elfrieda Kuhn |               494.40 |               3
--        1005 | Laurice Hill  |               249.99 |               3
-- (4 rows)

DELETE FROM Payments 
WHERE       customerID = 1002 
    AND     paidDate = DATE '2018-02-19';

-- After 1st deletion

--  customerid |   custname    | totalclearedpayments | numdiffproducts
-- ------------+---------------+----------------------+-----------------
--        1001 | Ami Maggio    |               269.11 |               5
--        1002 | India Crona   |               352.24 |               5
--        1004 | Elfrieda Kuhn |               494.40 |               3
--        1005 | Laurice Hill  |               249.99 |               3
-- (4 rows)


DELETE FROM Payments 
WHERE   customerID = 1004 
    AND paidDate = DATE '2018-02-04';


-- Run query again
SELECT  c.customerID, c.custName, cleared.totalClearedPayments, COUNT(DISTINCT s.productID) AS numDiffProducts
FROM    Customers c, ClearedPayments cleared, Sales s
WHERE   c.customerID = cleared.customerID 
    AND c.customerID = s.customerID
    AND c.amountOwed < cleared.totalClearedPayments 
GROUP BY c.customerID, c.custName, cleared.totalClearedPayments
HAVING COUNT(DISTINCT s.productID) >= 3;

-- query result after two deletions
--  customerid |   custname   | totalclearedpayments | numdiffproducts
-- ------------+--------------+----------------------+-----------------
--        1001 | Ami Maggio   |               269.11 |               5
--        1002 | India Crona  |               352.24 |               5
--        1005 | Laurice Hill |               249.99 |               3
-- (3 rows)