/*
** Question: https://leetcode.com/problems/user-activity-for-the-past-30-days-ii/
*/

-- method 1, MS SQL
-- Watch out for scenario where there are no rows meeting WHERE condition
SELECT
    CASE WHEN COUNT(*) = 0 THEN 0 
    ELSE ROUND(COUNT(DISTINCT a.session_id) * 1.0 / COUNT(DISTINCT a.user_id), 2) END AS average_sessions_per_user
FROM Activity a
WHERE DATEDIFF(dd, a.activity_date, CAST('2019-07-27' AS DATE)) < 30;
