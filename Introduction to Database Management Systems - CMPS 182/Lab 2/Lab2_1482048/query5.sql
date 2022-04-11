SELECT DISTINCT C.CustomerID, address "Customer Address", (paidPrice*quantity) "theRevenue", dayDate
FROM Customers C, Sales 
WHERE C.CustomerID = Sales.CustomerID AND 
	paidPrice*quantity >= 200 AND 
	status = 'H' AND  
	address IS NOT NULL; 
