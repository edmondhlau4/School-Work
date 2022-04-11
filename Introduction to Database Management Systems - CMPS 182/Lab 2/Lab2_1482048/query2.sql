SELECT productID AS theProduct, customerID AS theCustomer, storeID AS theStore
FROM Sales
where dayDate = 'January 16, 2018' AND paidPrice > 20 AND quantity > 5;
