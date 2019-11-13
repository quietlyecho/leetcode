/*
** Question: https://leetcode.com/problems/team-scores-in-football-tournament/
*/

-- method 1, MySQL (answer from discussion, not written by me)
-- key takeaways:
--  1. JOIN using OR
--  2. Multiple aggregate func SUM can be added together
--  3. I was confused about why the SUM didn't care for cases when team loses;
--     The reason is that here we only considers cases when team gets POINTS,
--     when a team loses, it gets zero points; so there's no need to include 
--     losing cases.
SELECT team_id,team_name,
SUM(CASE WHEN team_id=host_team AND host_goals>guest_goals THEN 3 ELSE 0 END)+
SUM(CASE WHEN team_id=guest_team AND guest_goals>host_goals THEN 3 ELSE 0 END)+
SUM(CASE WHEN team_id=host_team AND host_goals=guest_goals THEN 1 ELSE 0 END)+
SUM(CASE WHEN team_id=guest_team AND guest_goals=host_goals THEN 1 ELSE 0 END)
as num_points
FROM Teams
LEFT JOIN Matches
ON team_id=host_team OR team_id=guest_team
GROUP BY team_id
ORDER BY num_points DESC, team_id ASC;

-- method 2, MS SQL/Postgres
WITH Matches_new AS (
    SELECT 
        m.*,
        t1.team_name AS host_team_name,
        t2.team_name AS guest_team_name,
        CASE
            WHEN m.host_goals > m.guest_goals THEN 3
            WHEN m.host_goals = m.guest_goals THEN 1
            WHEN m.host_goals < m.guest_goals THEN 0
            ELSE NULL END AS host_points,
        CASE 
            WHEN m.host_goals > m.guest_goals THEN 0
            WHEN m.host_goals = m.guest_goals THEN 1
            WHEN m.host_goals < m.guest_goals THEN 3
            ELSE NULL END AS guest_points
    FROM Matches m
        INNER JOIN Teams t1 ON m.host_team = t1.team_id
        INNER JOIN Teams t2 ON m.guest_team = t2.team_id
)

SELECT
    t1.team_id,
    t1.team_name,
    CASE 
        WHEN m1.host_points IS NULL AND m2.guest_points IS NULL THEN 0
        WHEN m1.host_points IS NULL THEN m2.guest_points
        WHEN m2.guest_points IS NULL THEN m1.host_points 
        ELSE m1.host_points + m2.guest_points END AS num_points
        
FROM Teams t1

    LEFT OUTER JOIN
    (SELECT host_team, SUM(host_points) AS host_points 
      FROM Matches_new 
      GROUP BY host_team) m1
        ON t1.team_id = m1.host_team
        
    LEFT OUTER JOIN (
      SELECT guest_team, SUM(guest_points) AS guest_points 
      FROM Matches_new 
      GROUP BY guest_team) m2 
        ON t1.team_id = m2.guest_team
        
ORDER BY num_points DESC, team_id
