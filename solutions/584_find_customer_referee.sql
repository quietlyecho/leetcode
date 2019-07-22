/*
** Question: https://leetcode.com/problems/find-customer-referee/
*/

-- method 1, MySQL, MS SQL Server
-- below query returns error "ORA-00911: invalid character" for Oracle
SELECT c.name
FROM customer c
WHERE c.referee_id IS NULL OR c.referee_id <> 2
;
