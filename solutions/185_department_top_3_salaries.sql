/*
** This is for question: https://leetcode.com/problems/department-top-three-salaries/submissions/
*/


-- method 1
-- This method is about window function.
SELECT
    d.Name AS Department,
    t1.Name AS Employee,
    t1.Salary
FROM
(
SELECT
    e.DepartmentId, e.Name, e.Salary,
    DENSE_RANK() OVER (PARTITION BY e.DepartmentId ORDER BY e.Salary DESC) AS pos
FROM Employee e
) t1
    INNER JOIN Department d ON t1.DepartmentId = d.Id
WHERE t1.pos <= 3
ORDER BY d.Name, t1.Salary DESC;

-- method 2
-- This method is about correlated subquery.
-- Resources: https://www.geeksforgeeks.org/sql-correlated-subqueries/
SELECT d.Name AS Department, e.Name AS Employee, e.Salary
FROM Employee e
    INNER JOIN Department d ON e.DepartmentId = d.Id
WHERE 
    (
        SELECT COUNT(DISTINCT Salary) 
        FROM Employee
        WHERE Salary >= e.Salary AND DepartmentId = e.DepartmentId
    ) <= 3
ORDER BY d.Name, e.Salary DESC;
