/*
** Question: https://leetcode.com/problems/swap-salary/submissions/
*/

-- create table
DROP TABLE IF EXISTS t_627_salary;
CREATE TABLE t_627_salary(id INT, name TEXT, sex CHAR(1), salary INT);
INSERT INTO t_627_salary (id, name, sex, salary) VALUES ('1', 'A', 'm', '2500');
INSERT INTO t_627_salary (id, name, sex, salary) VALUES ('2', 'B', 'f', '1500');
INSERT INTO t_627_salary (id, name, sex, salary) VALUES ('3', 'C', 'm', '5500');
INSERT INTO t_627_salary (id, name, sex, salary) VALUES ('4', 'D', 'f', '500');

-- method 1, Oracle
-- use UPDATE
UPDATE salary
SET sex = CASE WHEN sex = 'm' THEN 'f' ELSE 'm' END;
