/*
** Question: https://leetcode.com/problems/sales-analysis-i/
*/

-- method 1, Oracle
SELECT
    t2.seller_id    
FROM
(
    SELECT
        t1.seller_id,
        RANK() OVER (ORDER BY t1.total_price DESC) AS pos
    FROM
    (
        SELECT 
            s.seller_id, 
            SUM(s.price) AS total_price
        FROM Sales s
        GROUP BY s.seller_id
    ) t1
) t2
WHERE t2.pos = 1
ORDER BY t2.seller_id

-- method 2, MySQL/Postgres
-- Doesn't seem to work on Oracle
-- Note: seems like a subquery with result of 1*1 table can be seen as a single value
SELECT s.seller_id
FROM Sales s
GROUP BY s.seller_id
HAVING SUM(s.price) =
    (
        SELECT SUM(s.price) AS total_price
        FROM Sales s
        GROUP BY s.seller_id
        ORDER BY total_price DESC
        LIMIT 1
    )
ORDER BY s.seller_id;
