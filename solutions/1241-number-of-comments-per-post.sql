/*
** Question: https://leetcode.com/problems/number-of-comments-per-post/
*/

-- method 1, Oracle/Postgres
-- Note:
--  Don't use below:
--      FROM Submissions s
--      LEFT OUTER JOIN (...) t1
--          ON s.sub_id = t1.parent_id AND s.parent_id IS NULL
--
--  s.parent_id needs to be moved into WHERE clause to remove "comment rows"
SELECT
    DISTINCT
    s.sub_id AS post_id,
    CASE WHEN t1.number_of_comments IS NULL THEN 0
        ELSE t1.number_of_comments END AS number_of_comments
FROM
    Submissions s
    LEFT OUTER JOIN
    (
        SELECT s.parent_id, COUNT(DISTINCT s.sub_id) AS number_of_comments
        FROM Submissions s
        WHERE s.parent_id IS NOT NULL
        GROUP BY s.parent_id
    ) t1 -- comment cnt per post
        ON s.sub_id = t1.parent_id
WHERE
    s.parent_id IS NULL
ORDER BY post_id;

-- method 2, Oracl
-- This is from discussions
SELECT
    s.sub_id AS post_id,
    (SELECT COUNT(DISTINCT(s1.sub_id)) FROM Submissions s1 WHERE s1.parent_id = s.sub_id)
AS number_of_comments
FROM Submissions s
WHERE s.parent_id IS null
GROUP BY s.sub_id
ORDER BY post_id;
