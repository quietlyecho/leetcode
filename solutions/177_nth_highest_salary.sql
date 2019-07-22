/*
** Question: https://leetcode.com/problems/nth-highest-salary/
*/

-- method 1, Oracle
CREATE FUNCTION getNthHighestSalary(N IN NUMBER) RETURN NUMBER IS
result NUMBER;
BEGIN
    /* Write your PL/SQL query statement below */
    SELECT
        DISTINCT t2.Salary
    INTO result
    FROM
    (SELECT N AS pos FROM dual) t1
    LEFT OUTER JOIN
    (
        SELECT e.Id, e.Salary,
            DENSE_RANK() OVER (ORDER BY e.Salary DESC) AS pos
        FROM Employee e
    ) t2 ON t1.pos = t2.pos;
    
    RETURN result;
END;

-- method 2, PostgreSQL
-- Create table
/*
CREATE TABLE IF NOT EXISTS Employee (Id SMALLSERIAL, Salary NUMERIC);
TRUNCATE TABLE Employee;
INSERT INTO Employee (Salary) VALUES(100);
INSERT INTO Employee (Salary) VALUES(200);
INSERT INTO Employee (Salary) VALUES(300);
*/

-- SELECT * FROM Employee;

CREATE OR REPLACE FUNCTION getNthHighestSalary(N INTEGER) RETURNS NUMERIC AS
$BODY$
DECLARE result NUMERIC;
BEGIN
	SELECT DISTINCT t1.Salary
	INTO result
	FROM
	(
		SELECT e.Id, e.Salary,
				DENSE_RANK() OVER (ORDER BY e.Salary DESC) AS pos
		FROM Employee e
	) t1
	WHERE t1.pos = N;
	
	RETURN result;
END;
$BODY$
LANGUAGE plpgsql;

SELECT getNthHighestSalary(4);
