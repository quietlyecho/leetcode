/*
** Question: https://leetcode.com/problems/project-employees-iii/
*/

-- method 1, Oracle
SELECT
    t1.project_id, t1.employee_id
FROM 
(
    SELECT
        p.project_id,
        p.employee_id,
        RANK() OVER (PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS pos
    FROM Project p
        LEFT OUTER JOIN Employee e 
            ON p.employee_id = e.employee_id
) t1
WHERE t1.pos = 1

-- method 2, Oracle
WITH t1 AS (
    SELECT p.project_id, p.employee_id, e.experience_years
    FROM Project p
        LEFT OUTER JOIN Employee e
            ON p.employee_id = e.employee_id
)

SELECT t1.project_id, t1.employee_id
FROM t1
WHERE (t1.project_id, t1.experience_years) IN (
        SELECT t1.project_id, MAX(t1.experience_years) AS max_exp_years
        FROM t1
        GROUP BY t1.project_id
    )
