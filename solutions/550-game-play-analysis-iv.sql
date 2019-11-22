/*
** Question: https://leetcode.com/problems/game-play-analysis-iv/
*/

-- method 1, Oracle
WITH first_login AS (
    SELECT a.player_id, MIN(event_date) AS first_login_date
    FROM Activity a
    GROUP BY a.player_id
) 

SELECT
    ROUND(SUM(CASE WHEN second_login.second_login_date IS NULL THEN 0 ELSE 1 END) * 1.0 / COUNT(*), 2) AS fraction
FROM
    first_login 
    LEFT OUTER JOIN (
        SELECT
            a.player_id, a.event_date AS second_login_date
        FROM 
            Activity a
            INNER JOIN first_login t1 
                ON a.player_id = t1.player_id AND a.event_date - t1.first_login_date = 1
    ) second_login 
        ON first_login.player_id = second_login.player_id

-- method 2, MySQL/Postgres
-- This is the answer submitted by other: 
--  https://leetcode.com/problems/game-play-analysis-iv/discuss/315626/Very-simple-MYSQL-solution
-- This method uses COUNT very smartly, reduces the use of CASE WHEN like in method 1.
-- Also it is more efficient by JOIN activiy instead of coming up with a second_login table like
-- in method 1, which is totally unnecessary.
SELECT 
    ROUND(COUNT(t2.player_id)/COUNT(t1.player_id),2) AS fraction
FROM
    (SELECT player_id, MIN(event_date) AS first_login FROM Activity GROUP BY player_id) t1 
    LEFT JOIN Activity t2
        ON t1.player_id = t2.player_id AND t1.first_login = t2.event_date - 1
