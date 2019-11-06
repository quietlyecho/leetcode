/*
** Questions: https://leetcode.com/problems/new-users-daily-count/
*/

-- method 1, MS SQL
SELECT
    t1.first_login_date AS login_date,
    COUNT(t1.user_id) AS user_count
FROM
(
    SELECT 
        t.user_id, 
        MIN(t.activity_date) AS first_login_date
    FROM Traffic t
    WHERE t.activity = 'login'
    GROUP BY t.user_id
) t1
WHERE DATEDIFF(dd,  t1.first_login_date, CAST('2019-06-30' AS DATE)) <= 90
GROUP BY t1.first_login_date
