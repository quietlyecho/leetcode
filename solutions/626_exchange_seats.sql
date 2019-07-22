/*
** Question: https://leetcode.com/problems/exchange-seats/
*/

-- method 1, MS SQL
SELECT
    t2.id,
    CASE WHEN t2.group_cnt = 2 THEN COALESCE(lag_student, lead_student)
        ELSE t2.student END AS student
FROM
(
    SELECT
        t1.id, t1.student,
        t1.group_id,
        COUNT(*) OVER (PARTITION BY t1.group_id) AS group_cnt,
        LAG(t1.student, 1) OVER (PARTITION BY t1.group_id ORDER BY t1.id) AS lag_student,
        LEAD(t1.student, 1) OVER (PARTITION BY t1.group_id ORDER BY t1.id) AS lead_student
    FROM
        (
        SELECT
            id, student, (id - 1) / 2 AS group_id 
        FROM seat
        ) t1
) t2
ORDER BY t2.id;
