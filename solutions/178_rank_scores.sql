/*
** Question: https://leetcode.com/problems/rank-scores/
*/

-- create data
/*
CREATE TABLE IF NOT EXISTS Scores (Id INTEGER, Score DECIMAL(3,2));
Truncate table Scores;
insert into Scores (Id, Score) values ('1', '3.5');
insert into Scores (Id, Score) values ('2', '3.65');
insert into Scores (Id, Score) values ('3', '4.0');
insert into Scores (Id, Score) values ('4', '3.85');
insert into Scores (Id, Score) values ('5', '4.0');
insert into Scores (Id, Score) values ('6', '3.65');
*/

-- method 1, Oracle
SELECT
    ROUND(t1.Score, 2) AS Score, t1.Rank
FROM 
(
    SELECT
        s.Id,
        s.Score,
        DENSE_RANK() OVER (ORDER BY s.Score DESC) AS Rank
    FROM Scores s
) t1
ORDER BY t1.Rank
;

-- method 2, MySQL
-- PostgresSQL must put s1.Id in SELECT as well.
SELECT s1.Score, COUNT(DISTINCT s2.Score) AS Rank
FROM Scores s1
    INNER JOIN Scores s2 ON s2.Score >= s1.Score
GROUP BY s1.Id
ORDER BY s1.Score DESC;

-- method 3, MySQL, PostgreSQL
SELECT
    s1.Score,
    (SELECT COUNT(DISTINCT Score) FROM Scores WHERE s1.Score <= Score) AS Rank
FROM Scores s1
ORDER BY Rank
;
