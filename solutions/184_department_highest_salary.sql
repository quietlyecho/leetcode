/*
** Question: https://leetcode.com/problems/department-highest-salary/
*/

-- method 1, Oracle
SELECT
    d.Name AS Department,
    t1.Name AS Employee,
    t1.Salary AS Salary
FROM
(
    SELECT
        e.Id, e.Name, e.Salary, e.DepartmentId,
        RANK() OVER (PARTITION BY e.DepartmentId ORDER BY e.Salary DESC) AS pos
    FROM Employee e
) t1
INNER JOIN Department d ON t1.DepartmentId = d.Id
WHERE 
    t1.pos = 1;

-- method 2, Oracle
-- An important concept related to this method is the usage of IN sytanx
-- Reference (PostgreSQL): https://www.postgresql.org/docs/current/functions-subquery.html#FUNCTIONS-SUBQUERY-IN
SELECT
    d.Name AS Department,
    e.Name AS Employee,
    e.Salary
FROM Employee e
    INNER JOIN Department d ON e.DepartmentId = d.Id
WHERE
    (e.DepartmentId, e.Salary) IN (
        SELECT DepartmentId, MAX(Salary)
        FROM Employee
        GROUP BY DepartmentId
    );

-- method 3, MySQL
SELECT d.Name as 'Department', e.Name AS 'Employee', e.Salary
FROM
    (
    SELECT DepartmentId, MAX(Salary) AS 'max_salary'
    FROM Employee
    GROUP BY DepartmentId
    ) t1
    INNER JOIN Employee e ON t1.max_salary = e.Salary AND t1.DepartmentId = e.DepartmentId
    INNER JOIN Department d on t1.DepartmentId = d.Id
ORDER BY 'Department';
