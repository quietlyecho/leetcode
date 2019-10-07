/*
** Question: https://leetcode.com/problems/product-sales-analysis-ii/
*/

-- method 1
SELECT 
    s.product_id,
    SUM(s.quantity) AS total_quantity
FROM Sales s
GROUP BY s.product_id;
