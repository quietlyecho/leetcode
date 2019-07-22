/*
** Question: https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/
** Below is in MySQL, not Oracle.
** Reference: 
**  COALESCE: https://www.postgresql.org/docs/9.2/functions-conditional.html
*/ 

-- method 1
/*
SELECT 
    ROUND(
        IFNULL(
       (SELECT COUNT(*) FROM (SELECT DISTINCT requester_id, accepter_id FROM request_accepted) t1) /
       (SELECT COUNT(*) FROM (SELECT DISTINCT sender_id, send_to_id FROM friend_request) t2),
            0),
        2) AS accept_rate*/

-- method 2
SELECT
    ROUND(
        COALESCE(
            (SELECT COUNT(*) FROM (SELECT DISTINCT requester_id, accepter_id FROM request_accepted) t1) /
            (SELECT COUNT(*) FROM (SELECT DISTINCT sender_id, send_to_id FROM friend_request) t2),
            0),
        2) AS accept_rate
