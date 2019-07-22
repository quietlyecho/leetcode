/*
** Question: https://leetcode.com/problems/consecutive-numbers/
*/

-- method 1, Oracle
-- Use window function
WITH t1 AS(
    SELECT 
        l.Id, l.Num,
        LEAD(l.Num, 1) OVER (ORDER BY Id) AS lead_1,
        LEAD(l.Num, 2) OVER (ORDER BY Id) AS lead_2
    FROM Logs l
)

SELECT DISTINCT t1.Num AS ConsecutiveNums
FROM t1
WHERE t1.Num = t1.lead_1 AND t1.Num = t1.lead_2
;

-- method 2, Oracle
-- Use joins
SELECT
    DISTINCT l1.Num AS ConsecutiveNums
FROM Logs l1
    INNER JOIN Logs l2 ON l1.Id = l2.Id - 1 AND l1.Num = l2.Num
    INNER JOIN Logs l3 ON l2.Id = l3.Id - 1 AND l2.Num = l3.Num
;
