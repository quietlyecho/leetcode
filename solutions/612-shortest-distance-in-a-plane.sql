/*
** Question: https://leetcode.com/problems/shortest-distance-in-a-plane/
*/

-- method 1, MySQL
-- MySQL uses POW function. PostgresSQL uses ^ or power()
SELECT
    ROUND(MIN(SQRT(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y,2))), 2) AS shortest
FROM point_2d p1
    CROSS JOIN point_2d p2
WHERE 
    p1.x != p2.x OR p1.y != p2.y
;

-- method 2, ORACLE
-- Can also use an INNER JOIN. In condition, use OR.
SELECT
    ROUND(MIN(SQRT((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y))), 2) AS shortest
FROM point_2d p1
    INNER JOIN point_2d p2 ON p1.x != p2.x OR p1.y != p2.y
;

-- method 3, MySQL
-- Slightly different in terms of how matching rows are selected.
-- Below joining avoids some duplicating joinings. 
-- For each point, the join only joins it with points on its right. When iterating
-- over all the points, this still ensures that all different paris of points have 
-- been joined.
SELECT
    ROUND(SQRT(MIN((POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)))),2) AS shortest
FROM
    point_2d p1
        JOIN
    point_2d p2 ON (p1.x <= p2.x AND p1.y < p2.y)
        OR (p1.x <= p2.x AND p1.y > p2.y)
        OR (p1.x < p2.x AND p1.y = p2.y)
;
