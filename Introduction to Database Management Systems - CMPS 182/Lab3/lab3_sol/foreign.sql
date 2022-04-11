
-- a) The productID field in Sells should reference the productID primary key Products.
ALTER TABLE Sales ADD FOREIGN KEY (productID) REFERENCES Products(productID);

-- b) The customerID field in Sales should reference the customerID primary key in Customers.
ALTER TABLE Sales ADD FOREIGN KEY (customerID) REFERENCES Customers(customerID);

-- c) The storeID field in Sales should reference the storeID primary key in Stores.
ALTER TABLE Sales ADD FOREIGN KEY (storeID) REFERENCES Stores(storeID);

-- d) The dayDate field in Sales should reference the dayDate primary key in Days.
ALTER TABLE Sales ADD FOREIGN KEY (dayDate) REFERENCES Days(dayDate);

-- e) The customerID field in Payments should reference the customerID primary key in Customers.
ALTER TABLE Payments ADD FOREIGN KEY (customerID) REFERENCES Customers(customerID);

-- Results:
-- lab1test=> \i foreign.sql
-- ALTER TABLE
-- ALTER TABLE
-- ALTER TABLE
-- ALTER TABLE
-- ALTER TABLE