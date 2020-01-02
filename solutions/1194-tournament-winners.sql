/*
** Question: https://leetcode.com/problems/tournament-winners/
*/

-- method 1, Oracle
WITH Scores AS (  
    SELECT player, SUM(score) AS total_score
    FROM (
        SELECT first_player AS player, first_score AS score
        FROM Matches
        
        UNION ALL
        
        SELECT second_player AS player, second_score AS score
        FROM Matches
        )
    GROUP BY player
    )

SELECT
    t1.group_id, t1.player_id
FROM
(
    SELECT
        p.player_id,
        p.group_id,
        s.total_score,
        RANK() OVER (
            PARTITION BY p.group_id ORDER BY s.total_score DESC, p.player_id
        ) AS pos
    FROM Players p
        INNER JOIN Scores s
            ON p.player_id = s.player
) t1
WHERE t1.pos = 1
