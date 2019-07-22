/*
** Question: https://leetcode.com/problems/trips-and-users/
*/

-- method 1, Oracle
SELECT
    t.Request_at AS "Day",
    ROUND(
        SUM(CASE 
                WHEN u1.Banned = 'No' AND u2.Banned = 'No' 
                AND (t.Status = 'cancelled_by_driver' OR t.Status = 'cancelled_by_client') THEN 1 ELSE 0 END) / 
        SUM(CASE WHEN u1.Banned = 'No' AND u2.Banned = 'No' THEN 1 ELSE 0 END), 2
    ) AS "Cancellation Rate"
FROM Trips t
    LEFT OUTER JOIN Users u1 ON t.Client_Id = u1.Users_Id
    LEFT OUTER JOIN Users u2 ON t.Driver_Id = u2.Users_Id
WHERE t.Request_at >= '2013-10-01' AND t.Request_at <= '2013-10-03'
GROUP BY t.Request_at;

-- method 2, Oracle
SELECT
    t.Request_at AS Day,
    ROUND(1.0 * SUM(CASE WHEN t.Status LIKE '%cancelled%' THEN 1 ELSE 0 END) / COUNT(*), 2) AS "Cancellation Rate"
FROM Trips t
    INNER JOIN Users u1 ON
        t.Client_Id = u1.Users_Id
        AND u1.Banned = 'No'
        AND t.Request_at >= '2013-10-01'
        AND t.Request_at <= '2013-10-03'
    INNER JOIN Users u2 ON
        t.Driver_Id = u2.Users_Id AND u2.Banned = 'No'
GROUP BY t.Request_at
ORDER BY t.Request_at
;
