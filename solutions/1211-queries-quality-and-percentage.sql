/*
** Question: https://leetcode.com/problems/queries-quality-and-percentage/
*/

-- method 1, Oracle
SELECT 
    q.query_name,
    ROUND(AVG(q.rating * 1.0 / q.position), 2) AS quality,
    ROUND(SUM(CASE WHEN q.rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
FROM Queries q
GROUP BY q.query_name;

-- method 2, Oracle
-- Largely same with method 1, but here we used AVG() instead of SUM(CASE WHEN...) / COUNT(*) for "poor_query_percentage"
SELECT
    q.query_name,
    ROUND(AVG(q.rating * 1.0 / q.position), 2) AS quality,
    ROUND(AVG(CASE WHEN q.rating < 3 THEN 1 ELSE 0 END) * 100, 2) AS poor_query_percentage
FROM Queries q
GROUP BY q.query_name;
