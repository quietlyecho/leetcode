
-- method 1
-- This is for MySQL

SELECT
    AVG(n.Number) AS median
FROM Numbers n
WHERE n.Frequency >= ABS(
    (SELECT SUM(Frequency) FROM Numbers WHERE Number <= n.Number) -
    (SELECT SUM(Frequency) FROM Numbers WHERE Number >= n.Number)
    )
;
