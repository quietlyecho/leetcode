DROP TABLE IF EXISTS t_569_employee;
CREATE TABLE t_569_employee (Id INTEGER, Company TEXT, Salary NUMERIC);

-- see the table
SELECT * FROM t_569_employee;

-- method 1, use double ranking
SELECT 
    t1.Id, t1.Company, t1.Salary
FROM 
(
SELECT
    e.Id, e.Company, e.Salary,
    DENSE_RANK() OVER (PARTITION BY e.Company ORDER BY e.Salary, e.Id) AS rank_asc,
    DENSE_RANK() OVER (PARTITION BY e.Company ORDER BY e.Salary DESC, e.Id Desc) AS rank_desc
FROM Employee e
) t1
WHERE
    t1.rank_asc = t1.rank_desc 
    OR t1.rank_asc = t1.rank_desc - 1
    OR t1.rank_asc = t1.rank_desc + 1
;

-- method 2, use frequency [pending]

-- method 3, other methods [pending]

