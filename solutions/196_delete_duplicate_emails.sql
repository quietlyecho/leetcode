/*
** Question: https://leetcode.com/problems/delete-duplicate-emails/
*/

-- Create table to work with
DROP TABLE IF EXISTS t_196_person;

CREATE TABLE t_196_person (Id INTEGER, Email TEXT);
INSERT INTO t_196_person VALUES (1, 'john@example.com');
INSERT INTO t_196_person VALUES (2, 'bob@example.com');
INSERT INTO t_196_person VALUES (3, 'john@example.com');
INSERT INTO t_196_person VALUES (4, 'john@example.com');

-- SELECT * FROM t_196_person;

-- method 1, PostgreSQL
-- resource: http://www.postgresqltutorial.com/postgresql-delete/
DELETE FROM t_196_person p1
USING t_196_person p2
WHERE p1.Email = p2.Email AND p1.Id > p2.Id;

-- method 2, MySQL
DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id