-- Find the storeName and dayDate of each store for which there was at least one sale on that dayDate. No duplicates should appear in your result.

SELECT DISTINCT st.storeName, s.dayDate 
FROM Stores st, Sales s
WHERE st.storeID = s.storeID;

-- In this query and other queries, it's okay to use JOIN ON

SELECT DISTINCT st.storeName, s.dayDate 
FROM Stores st JOIN Sales s ON st.storeID = s.storeID;

-- DISTINCT is necessary in this query.