SELECT pr.productID, pr.productName
FROM Products pr
WHERE pr.productName LIKE 'Intelligent%'
ORDER BY pr.productName;