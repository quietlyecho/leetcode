/*
** Question: https://leetcode.com/problems/game-play-analysis-iii/
*/

-- method 1
-- Using window function; an important concept called "window frame".
-- Refer to PostgreSQL's documentation for more details: 
--      https://www.postgresql.org/docs/current/tutorial-window.html

SELECT
    a.player_id, a.event_date,
    SUM(a.games_played) OVER 
        (PARTITION BY a.player_id ORDER BY a.event_date) AS games_played_so_far
FROM Activity a
;

-- method 2
-- A solution from the discussion section.
-- Using JOIN and GROUP BY

select a1.player_id, a1.event_date, sum(a2.games_played) as games_played_so_far
from activity as a1
inner join activity as a2
on a1.event_date >= a2.event_date
and a1.player_id = a2.player_id
group by  a1.player_id, a1.event_date
