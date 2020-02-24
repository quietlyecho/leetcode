/*
** Question:https://leetcode.com/problems/project-employees-ii/
*/

-- method 1, Oracle
SELECT
    t2.project_id
FROM
(
    SELECT
        t1.*,
        RANK() OVER (ORDER BY t1.emp_cnt DESC) AS pos
    FROM
    (
        SELECT p.project_id, COUNT(*) AS emp_cnt
        FROM Project p
        GROUP BY p.project_id
    ) t1
) t2
WHERE t2.pos = 1;

-- method 2, Oracle
WITH t1 AS (
    SELECT p.project_id, COUNT(*) AS emp_cnt
    FROM Project p
    GROUP BY p.project_id
)

SELECT
    t1.project_id
FROM t1
WHERE t1.emp_cnt IN
    (
        SELECT MAX(emp_cnt) AS max_emp_cnt
        FROM t1
    )

-- method 3.1, MySQL/Postgres
-- Refer to this solution: https://leetcode.com/problems/project-employees-ii/discuss/353448/Easy-Understand-MySQL-Solution 
-- This is similar to my method 2, but uses HAVING instead of CTE and WHERE.
select project_id
from project 
group by project_id
having count(employee_id) = 
     (select max(cnt) 
      from (select project_id, count(distinct employee_id) as cnt
            from project
            group by project_id) as t1)

-- method 3.2, MySQL/Postgres
-- Refer to this solution: https://leetcode.com/problems/project-employees-ii/discuss/307641/Simple-SQL-solution
SELECT project_id
FROM project
GROUP BY project_id
HAVING COUNT(employee_id) =
(
    SELECT count(employee_id)
    FROM project
    GROUP BY project_id
    ORDER BY count(employee_id) desc
    LIMIT 1
)
