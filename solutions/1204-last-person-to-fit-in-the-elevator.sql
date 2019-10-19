/*
** Question: https://leetcode.com/problems/last-person-to-fit-in-the-elevator/
*/

-- method 1, MySQL/Postgres
-- In postgres, only columns in GROUP BY can exist in SELECT
SELECT t1.person_name
FROM
(
	SELECT q1.turn, q1.person_name, SUM(q2.weight) AS running_sum
	FROM Queue q1 LEFT OUTER JOIN Queue q2 ON q1.turn >= q2.turn
	GROUP BY q1.turn, q1.person_name
	HAVING SUM(q2.weight) <= 1000
) t1
ORDER BY running_sum DESC
LIMIT 1;

-- method 2, MS SQL Server
SELECT
    TOP 1 t1.person_name
FROM 
(
    SELECT
        q.person_name, q.turn,
        SUM(q.weight) OVER (
            ORDER BY q.turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sum_of_weight
    FROM Queue q
) t1
WHERE t1.running_sum_of_weight <= 1000
ORDER BY t1.turn DESC;

-- method 3, MS SQL Server
-- used LAST_VALUE() window function
-- helpful explanation on window frame:
--  https://www.postgresql.org/docs/12/tutorial-window.html
SELECT
    DISTINCT
    LAST_VALUE(t1.person_name) OVER (
        ORDER BY t1.turn ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS person_name
FROM
(
    SELECT
        q.person_name, q.turn,
        SUM(q.weight) OVER (
            ORDER BY q.turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sum_of_weight
    FROM Queue q
) t1
WHERE t1.running_sum_of_weight <= 1000
;
