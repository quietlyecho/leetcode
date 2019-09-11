/*
** Question: https://leetcode.com/problems/reported-posts/
*/

-- method 1
SELECT
    a.extra AS report_reason,
    COUNT(DISTINCT post_id) AS report_count
FROM Actions a
WHERE a.action = 'report'
    AND a.action_date = CAST('2019-07-05' AS DATE) - 1
GROUP BY a.extra;
