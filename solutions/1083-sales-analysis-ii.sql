/*
** Question: https://leetcode.com/problems/sales-analysis-ii/
*/

-- method 1, Oracle/Postgres
SELECT s.buyer_id
FROM Sales s
    INNER JOIN Product p ON s.product_id = p.product_id
GROUP BY s.buyer_id
HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) >= 1
    AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0
;

-- method 2, Oracle/Postgres
SELECT DISTINCT s.buyer_id
FROM Sales s
    INNER JOIN Product p ON s.product_id = p.product_id
WHERE p.product_name = 'S8'
    AND s.buyer_id NOT IN (
            SELECT s.buyer_id
            FROM Sales s
                INNER JOIN Product p ON s.product_id = p.product_id
            WHERE p.product_name = 'iPhone'
        )
