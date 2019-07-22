/*
** Question: https://leetcode.com/problems/classes-more-than-5-students/
 */

-- method 1, Oracle
SELECT c.class
FROM courses c
GROUP BY c.class
HAVING COUNT(DISTINCT c.student) >= 5
ORDER BY c.class
;
