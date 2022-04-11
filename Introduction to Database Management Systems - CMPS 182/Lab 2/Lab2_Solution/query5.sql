-- If a customer’s status is ‘H’, that’s a high status customer. (‘M’ is for medium, ‘L’ is for low.) The revenue
-- from a sale equals paidPrice * quantity for that sale.
-- For each sale in which all of the following are true:
--     a) the revenue is greater than or equal to two hundred,
--     b) the customer is a high status customer, and
--     c) the customer’s address isn’t NULL,
-- output the customerID, customer address, revenue and dayDate for that sale. The attribute for the
-- revenue of the sale should appear as theRevenue in your result. No duplicates should appear in your
-- result.


SELECT DISTINCT c.customerID, c.address, s.paidPrice * s.quantity as theRevenue, s.daydate
FROM Customers c, Sales s
WHERE c.customerID = s.customerID 
  AND c.status = 'H'
  AND c.address is NOT NULL
  AND s.paidPrice * s.quantity >= 200;

-- DISTINCT is needed, because there might be multiple sales to the same customer on
-- the same dayDate that have the same revenue.