/*
** Question: https://leetcode.com/problems/product-sales-analysis-iii/
*/

-- method 1, Oracle
SELECT
    t1.product_id, t1.year AS first_year, t1.quantity, t1.price
FROM
(
    SELECT
        s.*,
        RANK() OVER (PARTITION BY s.product_id ORDER BY s.year) AS pos
    FROM Sales s
) t1
WHERE t1.pos = 1

-- method 2, Oracle/Postgres
SELECT s.product_id, s.year AS first_year, s.quantity, s.price 
FROM Sales s
WHERE (s.product_id, s.year) IN
    (
        SELECT s.product_id, MIN(s.year) AS first_year
        FROM Sales s
        GROUP BY s.product_id
    )
    
