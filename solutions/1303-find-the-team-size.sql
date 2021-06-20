-- method 1
SELECT e.employee_id, 
    COUNT(*) OVER (PARTITION BY e.team_id) AS team_size
FROM Employee e

-- method 2
SELECT
    e.employee_id, t.team_size
FROM Employee e
    LEFT OUTER JOIN (
        SELECT e.team_id, COUNT(*) AS team_size
        FROM Employee e
        GROUP BY e.team_id
    ) t ON e.team_id = t.team_id

-- method 3
-- correlated subquery, the slowest
SELECT
    e.employee_id,
    (SELECT COUNT(*) FROM Employee e2 WHERE e.team_id = e2.team_id) AS team_size
FROM Employee e


