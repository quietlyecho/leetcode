/*
** Question: https://leetcode.com/problems/second-highest-salary/
*/

-- method 1, MS SQL Server
-- SELECT without a FROM is acceptable for PostgreSQL as well.
-- However, Oracle doesn't accept FROM-less syntax. In Oracle, can use below
-- inside WITH:
--  SELECT 2 AS position FROM dual
WITH pos AS (
    SELECT 2 AS position
)

SELECT
    DISTINCT t1.Salary AS SecondHighestSalary
FROM
    pos p
    LEFT OUTER JOIN
    (
        SELECT
            e.Id,
            e.Salary,
            DENSE_RANK() OVER (ORDER BY Salary DESC) AS pos
        FROM Employee e
    ) t1 ON p.position = t1.pos
;
