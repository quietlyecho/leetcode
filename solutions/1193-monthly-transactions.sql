/*
** Question: https://leetcode.com/problems/monthly-transactions-i/ 
*/

-- method 1, Oracle
SELECT
    SUBSTR(CAST(t.trans_date AS VARCHAR(10)), 1, 7) AS month,
    t.country,
    COUNT(*) AS trans_count,
    COUNT(CASE WHEN t.state = 'approved' THEN 1 ELSE NULL END) AS approved_count,
    SUM(t.amount) AS trans_total_amount,
    SUM(CASE WHEN t.state = 'approved' THEN t.amount ELSE 0 END) AS approved_total_amount
FROM Transactions t
GROUP BY 
    SUBSTR(CAST(t.trans_date AS VARCHAR(10)), 1, 7),
    t.country
