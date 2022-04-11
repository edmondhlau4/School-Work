-- This is an alternative solution to fixStatusFunction using three UPDATE statements in a specific order.
-- It's important to do the updates going from 'M" to 'L' to NULL, not in the reverse order or other orders.
-- Since if we update the status in a reverse order, it will modify the statuses we just updated before.
-- That may eventually made all strong customers' statues to 'H'.

CREATE OR REPLACE FUNCTION fixStatusFunction (lowCustomerID integer) RETURNS integer AS $$

    DECLARE
        updatedRows INTEGER := 0;
        totalUpdatedRows INTEGER := 0;

    BEGIN
        
        -- update status 'M' to 'H'
        UPDATE Customers
        SET status = 'H'
        WHERE Customers.status = 'M'
            AND Customers.customerID IN (
                SELECT c.customerID
                FROM customers c, Payments p
                    WHERE c.customerID = p.customerID
                    AND c.customerID >= lowCustomerID
                GROUP BY c.customerID, c.status
                HAVING SUM(p.amountPaid) > c.amountOwed
            );

        GET DIAGNOSTICS updatedRows = ROW_COUNT;
        totalUpdatedRows := updatedRows + totalUpdatedRows;

        -- update status 'L' to 'M'
        UPDATE Customers
        SET status = 'M'
        WHERE Customers.status = 'L'
            AND Customers.customerID IN (
                SELECT c.customerID
                FROM customers c, Payments p
                    WHERE c.customerID = p.customerID
                    AND c.customerID >= lowCustomerID
                GROUP BY c.customerID, c.status
                HAVING SUM(p.amountPaid) > c.amountOwed
            );

        GET DIAGNOSTICS updatedRows = ROW_COUNT;
        totalUpdatedRows := updatedRows + totalUpdatedRows;

        -- update status NULL to 'L'
        UPDATE Customers
        SET status = 'L'
        WHERE Customers.status IS NULL
            AND Customers.customerID IN (
                SELECT c.customerID
                FROM customers c, Payments p
                    WHERE c.customerID = p.customerID
                    AND c.customerID >= lowCustomerID
                GROUP BY c.customerID, c.status
                HAVING SUM(p.amountPaid) > c.amountOwed
            );  
        GET DIAGNOSTICS updatedRows = ROW_COUNT;
        totalUpdatedRows := updatedRows + totalUpdatedRows;

        RETURN totalUpdatedRows;
    END;
    $$ LANGUAGE plpgsql;

