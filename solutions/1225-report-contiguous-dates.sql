/*
** Question: https://leetcode.com/problems/report-contiguous-dates/
*/

-- method 1
-- From discuss section
-- Note:
--  In Postgres, date type only works with integer when plus/minus, not bigint or smallint
--  In Postgres, SELECT doesn't need to have all columns that GROUP BY has
-- Please refer to this method:
--  https://leetcode.com/problems/report-contiguous-dates/discuss/407117/MSSQL-100-Simple-solution


-- method 2, MS SQL
-- My solution

WITH t1 AS (
        -- success start_date
        SELECT
            'succeeded' AS period_state,
            t1.success_date AS start_date,
            ROW_NUMBER() OVER (ORDER BY t1.success_date) AS row_number
        FROM 
        (
            SELECT
                s.success_date,
                LEAD(success_date, 1) OVER (ORDER BY success_date) AS next_s_date,
                LAG(success_date, 1) OVER (ORDER BY success_date) AS prev_s_date
            FROM Succeeded s
            WHERE s.success_date BETWEEN '2019-01-01' AND '2019-12-31'
        ) t1
        WHERE t1.prev_s_date IS NULL
            OR DATEDIFF(day, t1.prev_s_date, t1.success_date) > 1
    ),
    t2 AS (
        -- success end_date
        SELECT
            'succeeded' AS period_state,
            t2.success_date AS end_date,
            ROW_NUMBER() OVER (ORDER BY t2.success_date) AS row_number
        FROM 
        (
            SELECT
                s.success_date,
                LEAD(success_date, 1) OVER (ORDER BY success_date) AS next_s_date,
                LAG(success_date, 1) OVER (ORDER BY success_date) AS prev_s_date
            FROM Succeeded s
            WHERE s.success_date BETWEEN '2019-01-01' AND '2019-12-31'
        ) t2
        WHERE t2.next_s_date IS NULL
            -- OR t2.next_s_date - t2.success_date > 1
            OR DATEDIFF(DAY, t2.success_date, t2.next_s_date) > 1
    ),
    t3 AS (
        -- fail start_date
        SELECT
            'failed' AS period_state,
            t3.fail_date AS start_date,
            ROW_NUMBER() OVER (ORDER BY t3.fail_date) AS row_number
        FROM 
        (
            SELECT
                f.fail_date,
                LEAD(fail_date, 1) OVER (ORDER BY fail_date) AS next_f_date,
                LAG(fail_date, 1) OVER (ORDER BY fail_date) AS prev_f_date
            FROM Failed f
            WHERE f.fail_date BETWEEN '2019-01-01' AND '2019-12-31'
        ) t3
        WHERE t3.prev_f_date IS NULL
            -- OR t3.fail_date - t3.prev_f_date > 1
            OR DATEDIFF(DAY, t3.prev_f_date, t3.fail_date) > 1
    ), 
    t4 AS (
        SELECT
            -- fail end_date
            'failed' AS period_state,
            t4.fail_date AS end_date,
            ROW_NUMBER() OVER (ORDER BY t4.fail_date) AS row_number
        FROM 
        (
            SELECT
                f.fail_date,
                LEAD(fail_date, 1) OVER (ORDER BY fail_date) AS next_f_date,
                LAG(fail_date, 1) OVER (ORDER BY fail_date) AS prev_f_date
            FROM Failed f
            WHERE f.fail_date BETWEEN '2019-01-01' AND '2019-12-31'
        ) t4
        WHERE t4.next_f_date IS NULL
            -- OR t4.next_f_date - t4.fail_date > 1
            OR DATEDIFF(DAY, t4.fail_date, t4.next_f_date) > 1
    )

SELECT
    t1.period_state, t1.start_date, t2.end_date
FROM
    t1 INNER JOIN t2 
        ON t1.row_number = t2.row_number
    
UNION

SELECT
    t3.period_state, t3.start_date, t4.end_date
FROM
    t3 INNER JOIN t4 
        ON t3.row_number = t4.row_number
        
ORDER BY 2;
