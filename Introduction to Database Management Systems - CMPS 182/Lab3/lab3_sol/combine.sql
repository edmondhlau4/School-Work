BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

UPDATE  Customers
SET     custName = n.custName,
        address = n.address,
        joinDate = n.joinDate
FROM    NewCustomers n
WHERE   Customers.customerID = n.customerID;

INSERT INTO Customers
    SELECT  n.customerID, n.custName, n.address, n.joinDate, 0, NULL, 'L'
    FROM    NewCustomers n
    WHERE   NOT EXISTS ( SELECT * 
                            FROM Customers c
                            WHERE c.customerID = n.customerID
                        );

COMMIT;

-- Alternatively
-- START/BEGIN TRANSACTION
-- BEGIN WORK;
-- SET TRANSACTION READ WRITE ISOLATION LEVEL SERIALIZABLE;
-- Or
-- BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- START instead of BEGIN, or WORK instead of TRANSACTION are acceptable
-- COMMIT or COMMIT TRANSACTION are both acceptable


-- Tuple variables can't appear in the SET clause of an UPDATE statement.
-- E.g.
-- UPDATE  Customers c
-- SET     c.custName = n.custName,
--         c.address = n.address,
--         c.joinDate = n.joinDate
-- FROM    NewCustomers n
-- WHERE   c.customerID = n.customerID;

-- Instead, this statement is correct
-- UPDATE  Customers c
-- SET     custName = n.custName,
--         address = n.address,
--         joinDate = n.joinDate
-- FROM    NewCustomers n
-- WHERE   c.customerID = n.customerID;

-- Alternatively, since lastPaidDate has no default and can be NULL, INSERT statement can also be written as,
-- INSERT INTO Customers(customerID, custName, address, joinDate, amountOwed, status)
--     SELECT  n.customerID, n.custName, n.address, n.joinDate, 0, 'L'
--     FROM    NewCustomers n
--     WHERE   NOT EXISTS ( SELECT * 
--                             FROM Customers c
--                             WHERE c.customerID = n.customerID
--                         );

-- The UPDATE should come before the INSERT, since we don't want the inserted tuples to be updated.  The effects will be the same in this case, but there's no need to update the inserted tuples, even if there's no change.
-- Result in PostgreSQL
-- UPDATE 1
-- INSERT 0 3

