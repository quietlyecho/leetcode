/*
** Question: https://leetcode.com/problems/last-person-to-fit-in-the-elevator/
*/

-- method 1, MS SQL Server
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

