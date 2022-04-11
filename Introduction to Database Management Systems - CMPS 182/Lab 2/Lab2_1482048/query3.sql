SELECT DISTINCT st.storeName, s.dayDate
From stores st , sales s
WHERE st.storeID = s.storeID AND quantity > 1;
