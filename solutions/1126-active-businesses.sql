/*
** Question: https://leetcode.com/problems/active-businesses/
*/

-- method 1, Oracle/Postgres
SELECT
    t1.business_id
FROM
(
    SELECT 
        e.*,
        AVG(e.occurences) OVER (
            PARTITION BY e.event_type
        ) AS avg_event_occ
    FROM Events e
) t1
GROUP BY t1.business_id
HAVING SUM(CASE WHEN t1.occurences > t1.avg_event_occ THEN 1 ELSE 0 END) > 1
;

-- method 2, Oracle/Postgres
-- Two difference from method 1:
--  1. use join to get event_avg
--  2. removing rows not meeting criteria and then count, instead of using SUM(CASE WHEN...)
SELECT
    e.business_id
FROM Events e
    INNER JOIN (
        SELECT event_type, AVG(occurences) AS avg_event_occ
        FROM Events
        GROUP BY event_type
    ) t1
        ON e.event_type = t1.event_type
WHERE e.occurences > t1.avg_event_occ
GROUP BY e.business_id
HAVING COUNT(*) > 1
;
