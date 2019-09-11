/*
** Question: https://leetcode.com/problems/duplicate-emails/
*/

-- method 1
SELECT p.Email
FROM Person p
GROUP BY p.Email
HAVING COUNT(*) > 1;

