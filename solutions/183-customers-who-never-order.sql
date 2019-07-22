/*
** Question: https://leetcode.com/problems/customers-who-never-order/
*/

-- method 1, Oracle
SELECT c.Name AS Customers
FROM Customers c
WHERE c.Id NOT IN (SELECT CustomerId FROM Orders)
ORDER BY c.Name;

-- method 2, Oracle
SELECT c.Name as Customers
FROM Customers c
    LEFT OUTER JOIN Orders o ON c.Id = o.CustomerId
WHERE o.Id IS NULL
ORDER BY Customers;

-- method 3, Oracle
-- more explanations on EXISTS: http://www.postgresqltutorial.com/postgresql-exists/
SELECT c.Name AS Customers
FROM Customers c
WHERE
    NOT EXISTS (SELECT 1 FROM Orders WHERE c.Id = CustomerId)
ORDER BY Customers;
