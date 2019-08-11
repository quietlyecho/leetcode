/*
** https://leetcode.com/problems/article-views-i/
*/

-- method 1
SELECT DISTINCT v.author_id AS id
FROM Views v
WHERE v.author_id = v.viewer_id
ORDER BY id;
