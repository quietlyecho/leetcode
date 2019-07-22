/*
** Question: https://leetcode.com/problems/employee-bonus/
*/

-- method 1, Oracle
SELECT
    e.name, b.bonus
FROM Employee e
    LEFT OUTER JOIN Bonus b
        ON e.empId = b.empId
WHERE
    b.bonus IS NULL OR b.bonus < 1000
;
