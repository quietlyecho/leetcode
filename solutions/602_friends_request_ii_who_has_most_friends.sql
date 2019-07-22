/*
** Question: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
*/

-- method 1, Oracle
WITH friends_num AS (
    SELECT
        COALESCE(t1.requester_id, t2.accepter_id) AS id,
        (CASE WHEN t1.cnt IS NULL THEN 0 ELSE t1.cnt END) +
        (CASE WHEN t2.cnt IS NULL THEN 0 ELSE t2.cnt END) AS num
    FROM
        (SELECT requester_id, COUNT(*) AS cnt
         FROM request_accepted 
         GROUP BY requester_id) t1
        FULL OUTER JOIN
        (SELECT accepter_id, COUNT(*) AS cnt
         FROM request_accepted
         GROUP BY accepter_id
        ) t2 ON t1.requester_id = t2.accepter_id
)

SELECT t1.id, t1.num
FROM
(
    SELECT 
        f.id, f.num,
        RANK() OVER (ORDER BY f.num DESC) AS pos
    FROM friends_num f
) t1
WHERE t1.pos = 1
;

-- method 2, MS SQL Server
WITH friends_num AS (
    SELECT
        COALESCE(t1.requester_id, t2.accepter_id) AS id,
        (CASE WHEN t1.cnt IS NULL THEN 0 ELSE t1.cnt END) +
        (CASE WHEN t2.cnt IS NULL THEN 0 ELSE t2.cnt END) AS num
    FROM
        (SELECT requester_id, COUNT(*) AS cnt
         FROM request_accepted 
         GROUP BY requester_id) t1
        FULL OUTER JOIN
        (SELECT accepter_id, COUNT(*) AS cnt
         FROM request_accepted
         GROUP BY accepter_id
        ) t2 ON t1.requester_id = t2.accepter_id
)

SELECT TOP 1 f.id, f.num
FROM friends_num f
ORDER BY f.num DESC;
