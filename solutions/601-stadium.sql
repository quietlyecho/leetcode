/*
** Question: https://leetcode.com/problems/human-traffic-of-stadium/
*/

-- method 1, MS SQL Server
-- Somehow Oracle version always return a TIMESTAMP and not a DATE for visit_date

WITH stadium2 AS (
    SELECT id, visit_date, people
    FROM stadium
    WHERE people >= 100
)

SELECT 
    s1.id, s1.visit_date, s1.people
FROM stadium2 s1
    LEFT OUTER JOIN stadium2 s2 ON s1.id - s2.id = 2
    LEFT OUTER JOIN stadium2 s3 ON s1.id - s3.id = 1
    LEFT OUTER JOIN stadium2 s4 ON s1.id - s4.id = -1
    LEFT OUTER JOIN stadium2 s5 ON s1.id - s5.id = -2
WHERE 1=1
    AND (
        (s2.visit_date IS NOT NULL AND s3.visit_date IS NOT NULL) OR
        (s3.visit_date IS NOT NULL AND s4.visit_date IS NOT NULL) OR
        (s4.visit_date IS NOT NULL AND s5.visit_date IS NOT NULL)
    );

-- method 2, MS SQL Server
-- Use window function to find previous IDs and next IDs.
-- The key is that the question wasn't asking for 3 consecutive dates, but 3 consecutive
-- rows.
SELECT
    t1.id,
    t1.visit_date,
    t1.people
FROM
(
    SELECT
        s.id, s.visit_date, s.people,
        LAG(s.id, 2) OVER (ORDER BY s.id) AS prev_2_row_id,
        LAG(s.id, 1) OVER (ORDER BY s.id) AS prev_1_row_id,
        LEAD(s.id, 1) OVER (ORDER BY s.id) AS next_1_row_id,
        LEAD(s.id, 2) OVER (ORDER BY s.id) AS next_2_row_id
    FROM stadium s
    WHERE s.people >= 100
) t1
WHERE
    (t1.id - prev_2_row_id = 2 AND
     t1.id - prev_1_row_id = 1)
     OR
     (t1.id - prev_1_row_id = 1 AND
      t1.id - next_1_row_id = -1)
     OR
     (t1.id - next_1_row_id = -1 AND
      t1.id - next_2_row_id = -2)
ORDER BY t1.id;
