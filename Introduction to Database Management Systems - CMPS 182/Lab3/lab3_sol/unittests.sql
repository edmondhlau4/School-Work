-- These are examples of correct unit tests, but there are many other unit tests that would be okay.
-- For each unit test that violates the constraint, students are supposed to use illegal values for that specific attribute, so that the RI constraint is violated.

INSERT INTO Sales VALUES (112, 1001, 1, DATE '2018-01-12', 10, 2);
/* 
    Unit test for
        a) The productID field in Sells should reference the productID primary key Products.
            ALTER TABLE Sales ADD FOREIGN KEY (productID) REFERENCES Products(productID);
        This test case focuses on field 'productID'. Any integer within the range of 100-111 is a legal value. Students should use illegal values for productID.
        The other fields should use legal values. 
        Should return an ERROR.
            ERROR:  insert or update on table "sales" violates foreign key constraint "sales_productid_fkey"
            DETAIL:  Key (productid)=(112) is not present in table "products".
*/


INSERT INTO Sales VALUES (101, 1099, 1, DATE '2018-01-17', 10, 2);
/*
    Unit test for
        b) The customerID field in Sales should reference the customerID primary key in Customers.
            ALTER TABLE Sales ADD FOREIGN KEY (customerID) REFERENCES Customers(customerID);
        This test case focuses on field 'customerID'. Any Integer in the range of 1001-1006 and 1101-1103 is a legal value. 
        Students should use illegal values for customerID. The other fields should use legal values. 
        Should return an ERROR.
            ERROR:  insert or update on table "sales" violates foreign key constraint "sales_customerid_fkey"
            DETAIL:  Key (customerid)=(1099) is not present in table "customers".
*/



INSERT INTO Sales VALUES (101, 1001, 5, DATE '2018-01-17', 10, 2);
/*
    Unit test for
        c) The storeID field in Sales should reference the storeID primary key in Stores.
            ALTER TABLE Sales ADD FOREIGN KEY (storeID) REFERENCES Stores(storeID);
        This test case focuses on field 'storeID'. Any integer within the range of 1-4 is a legal value. Students should use illegal values for storeID.
        The other fields should use legal values. 
        The other fields should be valid values. 
        Should return an ERROR.
            ERROR:  insert or update on table "sales" violates foreign key constraint "sales_storeid_fkey"
            DETAIL:  Key (storeid)=(5) is not present in table "stores".
*/


INSERT INTO Sales VALUES (101, 1001, 1, DATE '2018-01-02', 10, 2);
/*
    Unit test for
        d) The dayDate field in Sales should reference the dayDate primary key in Days.
            ALTER TABLE Sales ADD FOREIGN KEY (dayDate) REFERENCES Days(dayDate);
        This test case focuses on field 'dayDate'. Any date within the set of dayDate in Days is a legal value. Students should use illegal values for dayDate.
        The other fields should be valid values. 
            SELECT DISTINCT daydate FROM Days ORDER BY dayDate;
            daydate
            ------------
            2018-01-01
            2018-01-04
            2018-01-06
            2018-01-11
            2018-01-12
            2018-01-13
            2018-01-14
            2018-01-15
            2018-01-16
            2018-01-17
            2018-01-18
            2018-01-19
            2018-01-20
            2018-01-21
            2018-01-22
            2018-01-23
            2018-01-24
            2018-01-25
            2018-01-26
            2018-01-30
            (20 rows)
        Should return an ERROR.
            ERROR:  insert or update on table "sales" violates foreign key constraint "sales_daydate_fkey"
            DETAIL:  Key (daydate)=(2018-01-02) is not present in table "days".
*/

INSERT INTO Payments VALUES (1099, 'Stephen Curry', DATE '2018-02-12', 249.99, TRUE);
/*
    Unit test for
        e) The customerID field in Payments should reference the customerID primary key in Customers.
            ALTER TABLE Payments ADD FOREIGN KEY (customerID) REFERENCES Customers(customerID);
        This test case focuses on field 'customerID'. Any Integer within the range 1001-1006 and 1101-1103 is a legal value. Students should use illegal values for customerID.
            paidDate can not be NULL, custName, amountPaid, cleared can be NULL.
        Should return an ERROR.
            ERROR:  insert or update on table "payments" violates foreign key constraint "payments_customerid_fkey"
            DETAIL:  Key (customerid)=(1099) is not present in table "customers".
*/

/*
    Unit tests for 
        1. amountOwed must be greater than or equal to zero. name: owed_is_not_negative
        ALTER TABLE Customers ADD CONSTRAINT owed_is_not_negative CHECK (amountOwed >= 0);
*/
UPDATE  Customers
SET     amountOwed = 12
WHERE   CustomerID = 1001;
-- UPDATE 1
UPDATE  Customers
SET     amountOwed = -1
WHERE   CustomerID = 1001;
-- ERROR:  new row for relation "customers" violates check constraint "owed_is_not_negative"
-- DETAIL:  Failing row contains (1001, Ami Maggio, 650 Kessler Common, 2017-09-07, -1.00, 2018-03-11, H).


/*
    Unit tests for 
        2. In Sales, revenue isn’t an attribute, but it’s equal to paidPrice * quantity, and those are attributes of Sales. This constraint says that revenue must be at least 10.00
        ALTER TABLE Sales ADD CHECK (paidPrice * quantity >= 10);
*/
UPDATE  Sales
SET     paidPrice = 12,
        quantity = 2
WHERE   productID = 101
AND     CustomerID = 1001
AND     storeID = 1
AND     dayDate = DATE '2018-01-16';
-- UPDATE 1
UPDATE  Sales
SET     paidPrice = 1,
        quantity = 2
WHERE   productID = 101
AND     CustomerID = 1001
AND     storeID = 1
AND     dayDate = DATE '2018-01-16';
-- ERROR:  new row for relation "sales" violates check constraint "sales_check"
-- DETAIL:  Failing row contains (101, 1001, 1, 2018-01-16, 1.00, 2).


/*
    Unit tests for 
       3. In Customers, if lastPaidDate is NULL then status must be ‘L’.
        ALTER TABLE Customers ADD CHECK ( lastPaidDate is NOT NULL OR status = 'L' );
*/
UPDATE  Customers
SET     status = 'L'
WHERE   CustomerID = 1001;
-- UPDATE 1
UPDATE  Customers
SET     lastPaidDate = NULL,
        status = 'H'
WHERE   CustomerID = 1002;
-- ERROR:  new row for relation "customers" violates check constraint "customers_check"
-- DETAIL:  Failing row contains (1002, India Crona, 15480 Moore Valley, 2017-10-30, 300.00, null, H).


/*
Results:
lab1test=> \i unittests.sql
psql:unittests.sql:1: ERROR:  insert or update on table "sales" violates foreign key constraint "sales_productid_fkey"
DETAIL:  Key (productid)=(112) is not present in table "products".
psql:unittests.sql:13: ERROR:  insert or update on table "sales" violates foreign key constraint "sales_customerid_fkey"
DETAIL:  Key (customerid)=(1099) is not present in table "customers".
psql:unittests.sql:26: ERROR:  insert or update on table "sales" violates foreign key constraint "sales_storeid_fkey"
DETAIL:  Key (storeid)=(5) is not present in table "stores".
psql:unittests.sql:38: ERROR:  insert or update on table "sales" violates foreign key constraint "sales_daydate_fkey"
DETAIL:  Key (daydate)=(2018-01-02) is not present in table "days".
psql:unittests.sql:73: ERROR:  insert or update on table "payments" violates foreign key constraint "payments_customerid_fkey"
DETAIL:  Key (customerid)=(1099) is not present in table "customers".
UPDATE 1
psql:unittests.sql:96: ERROR:  new row for relation "customers" violates check constraint "owed_is_not_negative"
DETAIL:  Failing row contains (1001, Ami Maggio, 650 Kessler Common, 2017-09-07, -1.00, 2018-03-11, H).
UPDATE 1
psql:unittests.sql:120: ERROR:  new row for relation "sales" violates check constraint "sales_check"
DETAIL:  Failing row contains (101, 1001, 1, 2018-01-16, 1.00, 2).
UPDATE 1
psql:unittests.sql:137: ERROR:  new row for relation "customers" violates check constraint "customers_check"
DETAIL:  Failing row contains (1002, India Crona, 15480 Moore Valley, 2017-10-30, 300.00, null, H).
*/