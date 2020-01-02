/*
** Question: https://leetcode.com/problems/game-play-analysis-ii/ 
*/

-- method 1, Oracle/Postgres
SELECT
    t1.player_id,
    t1.device_id
FROM
(
    SELECT
        a.*,
        RANK() OVER (PARTITION BY a.player_id ORDER BY a.event_date) AS pos
    FROM Activity a
) t1
WHERE t1.pos = 1

-- method 2, Oracle/Postgres
-- Use IN
SELECT a.player_id, a.device_id
FROM Activity a
WHERE
    (a.player_id, a.event_date) IN
        (
            SELECT a.player_id, MIN(a.event_date) AS min_event_date
            FROM Activity a
            GROUP BY a.player_id
        )

