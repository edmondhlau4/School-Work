DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;

CREATE TABLE products (
    productID INTEGER PRIMARY KEY,
    productName VARCHAR (40),
    manuf VARCHAR (40),
    normalPrice DECIMAL (5,2),
    discount INTEGER
);

CREATE TABLE customers (
    customerID INTEGER PRIMARY KEY,
    custName VARCHAR (40),
    address VARCHAR (40),
    joinDate DATE,
    amountOwed DECIMAL (6,2),
    lastPaidDate DATE,
    status CHAR (1)
);

CREATE TABLE stores (
    storeID INTEGER PRIMARY KEY,
    storeName VARCHAR (40),
    region CHAR (5),
    address VARCHAR (40),
    manager VARCHAR (40)
);

CREATE TABLE day (
    dayDate DATE PRIMARY KEY,
    category CHAR (1)
);

CREATE TABLE sales (
    productID INTEGER,
    customerID INTEGER,
    storeID INTEGER,
    dayDate DATE,
    PRIMARY KEY (productID, customerID, storeID, dayDate),
    paidPrice DECIMAL (5,2),
    quantity INTEGER
);

CREATE TABLE payments (
    customerID INTEGER,
    custName VARCHAR (40),
    paidDate DATE,
    amountPaid DECIMAL (6,2),
    cleared BOOLEAN,
    PRIMARY KEY (customerID, paidDate)
);
