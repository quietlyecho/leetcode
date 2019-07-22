/*
** Question: https://leetcode.com/problems/big-countries/
*/

-- method 1, Oracle
-- use OR
SELECT w.name, w.population, w.area
FROM World w
WHERE w.area > 3e+6 OR w.population > 25e+6
;

-- method 2, Oracle
-- use UNION
SELECT w.name, w.population, w.area
FROM World w
WHERE w.area > 3e+6

UNION

SELECT w.name, w.population, w.area
FROM World w
WHERE w.population > 25e+6
;
