/*
** Question: https://leetcode.com/problems/monthly-transactions-ii/
*/

-- method 1, Oracle
-- Note:
--  * Truncate date when asked at month level
WITH t1 AS (
        SELECT
            SUBSTR(CAST(t.trans_date AS VARCHAR(11)), 1, 7) AS month,
            t.country,
            COUNT(*) AS approved_count,
            SUM(t.amount) AS approved_amount
        FROM Transactions t
        WHERE t.state = 'approved'
        GROUP BY
            SUBSTR(CAST(t.trans_date AS VARCHAR(11)), 1, 7),
            t.country
    ),
    t2 AS (
        SELECT 
            SUBSTR(CAST(c.trans_date AS VARCHAR(11)), 1, 7) AS month,
            t.country,
            COUNT(*) AS chargeback_count,
            SUM(t.amount) AS chargeback_amount
        FROM Chargebacks c
            INNER JOIN Transactions t ON c.trans_id = t.id
        GROUP BY
            SUBSTR(CAST(c.trans_date AS VARCHAR(11)), 1, 7),
            t.country
    )

SELECT
    COALESCE(t1.month, t2.month) AS month,
    COALESCE(t1.country, t2.country) AS country,
    CASE WHEN t1.approved_count IS NULL THEN 0 ELSE t1.approved_count END AS approved_count,
    CASE WHEN t1.approved_amount IS NULL THEN 0 ELSE t1.approved_amount END AS approved_amount,
    CASE WHEN t2.chargeback_count IS NULL THEN 0 ELSE t2.chargeback_count END AS chargeback_count,
    CASE WHEN t2.chargeback_amount IS NULL THEN 0 ELSE t2.chargeback_amount END AS chargeback_amount
FROM
    t1 FULL OUTER JOIN t2 ON t1.month = t2.month AND t1.country = t2.country

