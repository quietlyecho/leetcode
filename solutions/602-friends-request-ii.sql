/*
** Question: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
*/

-- method 1, LC solution
-- The key is to use UNION ALL so that COUNT will take into considertation of id both
-- when it's a requester and an accepter.
select
    top 1
    ids as id, cnt as num
from
(
   select ids, count(*) as cnt
   from
   (
        select requester_id as ids from request_accepted
        union all
        select accepter_id from request_accepted
    ) as tbl1
   group by ids
) as tbl2
order by cnt desc
;

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
SELECT
    TOP 1
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
ORDER BY num DESC
;

-- method 3, MS SQL server
-- use correlated subquery

SELECT
    TOP 1
    t1.id,
    (SELECT COUNT(*)
     FROM request_accepted
     WHERE requester_id = t1.id OR accepter_id = t1.id) AS num
FROM
    (
        SELECT requester_id AS id
        FROM request_accepted

        UNION

        SELECT accepter_id AS id
        FROM request_accepted
    ) t1
ORDER BY num DESC
;
