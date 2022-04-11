-- This solution uses a cursor for updating strong customers' statues 
-- by iterating the cursor through all the Strong Customers.

CREATE OR REPLACE FUNCTION fixStatusFunction (lowCustomerID integer) RETURNS integer AS $$

    DECLARE
        strongCustomerID INTEGER;
        strongCustomerStatus CHAR(1);
        updatedStatus CHAR(1);
        totalUpdatedRows INTEGER := 0;

    -- declare a cursor for strong customers' customerID and status
    DECLARE strongCustomerCursor CURSOR FOR
        SELECT c.customerID, c.status
        FROM customers c, Payments p
            WHERE c.customerID = p.customerID
            AND c.customerID >= lowCustomerID
        GROUP BY c.customerID, c.status
        HAVING SUM(p.amountPaid) > c.amountOwed;

    BEGIN
        OPEN strongCustomerCursor;
        LOOP
            FETCH strongCustomerCursor INTO strongCustomerID, strongCustomerStatus;
            EXIT WHEN NOT FOUND;

            -- If status is 'H', do nothing, otherwise follow the rules to update status.
            
            IF  strongCustomerStatus is NULL  
            THEN    UPDATE  Customers
                    SET     status = 'L'
                    WHERE   Customers.customerID = strongCustomerID;
                    totalUpdatedRows := totalUpdatedRows + 1;
            ELSIF strongCustomerStatus = 'L'  
            THEN    UPDATE  Customers
                    SET     status = 'M'
                    WHERE   Customers.customerID = strongCustomerID;
                    totalUpdatedRows := totalUpdatedRows + 1;
            ELSIF  strongCustomerStatus = 'M'  
            THEN    UPDATE  Customers
                    SET     status = 'H'
                    WHERE   Customers.customerID = strongCustomerID;
                    totalUpdatedRows := totalUpdatedRows + 1;
            END IF;

        END LOOP;

        CLOSE strongCustomerCursor;

        RETURN totalUpdatedRows;
    END;
    $$ LANGUAGE plpgsql;

