/*
** Question: https://leetcode.com/problems/employees-earning-more-than-their-managers/
*/

-- method 1, Oracle
SELECT e1.Name AS Employee
FROM Employee e1
    LEFT OUTER JOIN Employee e2 ON e1.ManagerId = e2.Id
WHERE e1.Salary > e2.Salary
;

-- method 2, Oracle
SELECT e1.Name AS Employee
FROM Employee e1
WHERE e1.Salary > (
    SELECT Salary
    FROM Employee
    WHERE Id = e1.ManagerId
    )
;
