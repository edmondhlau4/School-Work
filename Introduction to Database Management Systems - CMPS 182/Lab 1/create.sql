    DROP SCHEMA Lab1 CASCADE;
    CREATE SCHEMA Lab1;

    CREATE TABLE Products (
        productID INTEGER PRIMARY KEY,
        productName VARCHAR(40),
        manuf VARCHAR(40),
        normalPrice DECIMAL(5, 2),
        discount INTEGER
    );

    -- Alternatively : 
    -- CREATE TABLE Products (
    --    productID INTEGER,
    --    productName VARCHAR(40),
    --    manuf VARCHAR(40),
    --    normalPrice DECIMAL(5, 2),
    --    discount INTEGER,
    --    PRIMARY KEY (productID)
    -- );
    -- INT/INTEGER, DECIMAL(5,2)/NUMERIC(5,2) are all correct answers.

    CREATE TABLE Customers (
        customerID INTEGER PRIMARY KEY, 
        custName VARCHAR(40), 
        address VARCHAR(40), 
        joinDate DATE, 
        amountOwed DECIMAL(6, 2), 
        lastPaidDate DATE, 
        status CHAR(1)
    );

    -- Alternatively : 
    -- CREATE TABLE Customers (
    --     customerID INTEGER, 
    --     custName VARCHAR(40), 
    --     address VARCHAR(40), 
    --     joinDate DATE, 
    --     amountOwed DECIMAL(6, 2), 
    --     lastPaidDate DATE, 
    --     status CHAR(1),
    --     PRIMARY KEY (customerID)
    -- );

    CREATE TABLE Stores (
        storeID INTEGER PRIMARY KEY, 
        storeName VARCHAR(40), 
        region CHAR(5), 
        address VARCHAR(40), 
        manager VARCHAR(40)
    );

    -- Alternatively : 
    -- CREATE TABLE Stores (
    --     storeID INTEGER, 
    --     storeName VARCHAR(40), 
    --     region CHAR(5), 
    --     address VARCHAR(40), 
    --     manager VARCHAR(40),
    --     PRIMARY KEY (storeID)
    -- );

    CREATE TABLE Days(
        dayDate DATE PRIMARY KEY, 
        category CHAR(1)
    );

    -- Alternatively : 
    -- CREATE TABLE Days(
    --     dayDate DATE PRIMARY KEY, 
    --     category CHAR(1),
    --     PRIMARY KEY (dayDate)
    -- );
    -- Table name Day will also be accepted this time, but we will use Days for future labs.

    CREATE TABLE Sales(
        productID INTEGER, 
        customerID INTEGER, 
        storeID INTEGER, 
        dayDate DATE, 
        paidPrice DECIMAL(5, 2), 
        quantity INTEGER,
        PRIMARY KEY (productID, customerID, storeID, dayDate)
    );

    CREATE TABLE Payments(
        customerID INTEGER, 
        custName VARCHAR(40), 
        paidDate DATE, 
        amountPaid DECIMAL(6, 2), 
        cleared BOOLEAN,
        PRIMARY KEY (customerID, paidDate)
    );