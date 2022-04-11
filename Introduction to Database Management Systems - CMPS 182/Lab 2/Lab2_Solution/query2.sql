SELECT s.productid as theProduct, 
    s.customerID as theCustomer, 
    s.storeID as theStore
FROM Sales s
WHERE s.dayDate = DATE '2018-01-16' 
    AND s.paidPrice > 20.00
    AND s.quantity > 5;

-- Using DATE '01/16/2018' is also okay.