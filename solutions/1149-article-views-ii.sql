/*
** https://leetcode.com/problems/article-views-ii/
*/

-- method 1, Oracle
SELECT
    DISTINCT t1.viewer_id AS id
FROM
(
    SELECT
        v.viewer_id,
        COUNT(DISTINCT v.article_id) 
            OVER (PARTITION BY v.view_date, v.viewer_id) AS view_cnt_per_id_per_day
    FROM Views v
) t1
WHERE t1.view_cnt_per_id_per_day > 1
ORDER BY id
;
