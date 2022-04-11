SELECT c.customerID, c.custName
FROM Customers c, Sales s, Stores st
WHERE c.customerID = s.customerID AND s.storeID = st.storeID AND region = 'North'
GROUP BY c.customerID, c.custName
HAVING COUNT (DISTINCT (s.productID)) >= 2 
