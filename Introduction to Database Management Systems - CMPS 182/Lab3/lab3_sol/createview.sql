CREATE VIEW ClearedPayments AS
      SELECT p.customerID, 
             SUM(p.amountPaid) AS totalClearedPayments
      FROM Payments p
      WHERE p.cleared
      GROUP BY p.customerID;

-- in the WHERE clause
-- p.cleared and p.cleared = TRUE are both acceptable.
-- There are other ways to write p.cleared = TRUE, such as, p.cleared = 't', p.cleared = true,  p.cleared = 'true', 
-- p.cleared = 'y', p.cleared = 'yes', p.cleared = 'on', p.cleared = '1' 


-- Results:
-- lab1test=> \i createview.sql
-- CREATE VIEW

-- query results:
-- SELECT * FROM ClearedPayments;
--  customerid | totalclearedpayments
-- ------------+----------------------
--        1005 |               249.99
--        1006 |               186.08
--        1002 |               364.56
--        1001 |               269.11
--        1004 |               494.40
-- (5 rows)