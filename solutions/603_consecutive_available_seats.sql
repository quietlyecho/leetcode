/*
** Question: https://leetcode.com/problems/consecutive-available-seats/
*/

-- method 1, Oracle
SELECT
    t1.seat_id
FROM
(
    SELECT
        c.seat_id,
        LEAD(seat_id) OVER (ORDER BY seat_id) AS next_1_seat,
        LAG(seat_id) OVER (ORDER BY seat_id) AS prev_1_seat
    FROM cinema c
    WHERE c.free = 1
) t1
WHERE 
    t1.seat_id + 1 = t1.next_1_seat OR
    t1.seat_id - 1 = t1.prev_1_seat
ORDER BY t1.seat_id
;
