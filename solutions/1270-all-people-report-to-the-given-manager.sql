/*
** Question: https://leetcode.com/problems/all-people-report-to-the-given-manager/
*/

-- method 1
SELECT
    e.employee_id
FROM Employees e
    LEFT OUTER JOIN Employees e1
        ON e.manager_id = e1.employee_id
    LEFT OUTER JOIN Employees e2
        ON e1.manager_id = e2.employee_id
    LEFT OUTER JOIN Employees e3
        ON e2.manager_id = e3.employee_id
WHERE e3.manager_id = 1
    AND e.employee_id != 1
ORDER BY e.employee_id
;

