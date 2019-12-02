/*
** Question: https://leetcode.com/problems/game-play-analysis-i/
*/

SELECT a.player_id, MIN(a.event_date) AS first_login
FROM Activity a
GROUP BY a.player_id
ORDER BY a.player_id;
