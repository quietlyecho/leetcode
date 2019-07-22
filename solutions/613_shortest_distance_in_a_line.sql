/*
** Question: https://leetcode.com/problems/shortest-distance-in-a-line/submissions/
*/

-- method 1, Oracle
-- Reference:
-- CROSS JOIN vs FULL OUTER JOIN: 
--      https://stackoverflow.com/questions/3228871/sql-server-what-is-the-difference-between-cross-join-and-full-outer-join
-- Examples on JOINs:
--      https://en.wikipedia.org/wiki/Join_(SQL)

SELECT
    MIN(t1.distance) AS shortest
FROM
(
    SELECT
        ABS(p1.x - p2.x) AS distance
    FROM point p1
        CROSS JOIN point p2
) t1
WHERE
    t1.distance != 0
;

-- method 2, Oracle
SELECT
    MIN(ABS(p1.x - p2.x)) AS shortest
FROM point p1
    INNER JOIN point p2 ON p1.x != p2.x
;

-- Follow-up question:
-- What if all these points have an id and are arranged from the left most to the right most of x axis?
DROP TABLE IF EXISTS point;

CREATE TABLE point (id INT, x INT);
INSERT INTO point VALUES(1, -1);
INSERT INTO point VALUES(2, 0);
INSERT INTO point VALUES(3, 2);
INSERT INTO point VALUES(4, 8);
INSERT INTO point VALUES(5, 9);

SELECT
    MIN(ABS(p1.x - p2.x)) AS shortest
FROM point p1
    INNER JOIN point p2 ON p1.id = p2.id - 1
;

