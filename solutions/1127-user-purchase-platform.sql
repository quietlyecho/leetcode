/*
** Question: https://leetcode.com/problems/user-purchase-platform/
*/

-- method 1, MS SQL/Postgres
-- Note: 
--  Please refer to this answer:
--      https://leetcode.com/problems/user-purchase-platform/discuss/338776/MySQL-Solution-With-Explanations-(Faster-Than-100)
--  The key are:
--      * Creation of t2 - turns vertical values to be on same row
--      * Creation of t1

SELECT
    t1.spend_date, t1.platform,
    SUM(COALESCE(t3.total_amount, 0)) AS total_amount,
    COUNT(t3.user_id) AS total_users
FROM
    (
        SELECT DISTINCT spend_date, 'mobile' AS platform
        FROM Spending

        UNION

        SELECT DISTINCT spend_date, 'desktop' AS platform
        FROM Spending

        UNION

        SELECT DISTINCT spend_date, 'both' AS platform
        FROM Spending
    ) t1
    LEFT OUTER JOIN (
        SELECT
            t2.user_id, t2.spend_date,
            CASE WHEN desktop_amount > 0 AND mobile_amount > 0 THEN 'both'
                WHEN desktop_amount > 0 AND mobile_amount = 0 THEN 'desktop'
                WHEN desktop_amount = 0 AND mobile_amount > 0 THEN 'mobile'
                ELSE 'check' END AS platform,
            desktop_amount + mobile_amount AS total_amount
        FROM (
            SELECT s.user_id, s.spend_date,
                SUM(CASE WHEN s.platform = 'desktop' THEN s.amount ELSE 0 END) AS desktop_amount,
                SUM(CASE WHEN s.platform = 'mobile' THEN s.amount ELSE 0 END) AS mobile_amount
            FROM Spending s
            GROUP BY s.user_id, s.spend_date
        ) t2
    ) t3 ON t1.spend_date = t3.spend_date AND t1.platform = t3.platform
GROUP BY t1.spend_date, t1.platform

-- method 2, MS SQL/Postgres
-- Note: the creation of t5 is key.
WITH t1 AS (
        SELECT *,
            COUNT(*) OVER (PARTITION BY spend_date, user_id) AS spending_cnt
        FROM Spending
    ),
    t2 AS (
        SELECT *,
            CASE WHEN spending_cnt = 1 THEN platform ELSE 'both' END AS platform_2
        FROM t1
    ),
    t3 AS (
        SELECT t1.spend_date, t1.platform, SUM(t1.amount) AS total_amount, COUNT(t1.user_id) AS total_users
        FROM t1
        WHERE spending_cnt = 1
        GROUP BY t1.spend_date, t1.platform
    ),
    t4 AS (
        SELECT t1.spend_date, 
            CASE WHEN spending_cnt = 2 THEN 'both' ELSE 'check' END AS platform, 
            SUM(t1.amount) AS total_amount, COUNT(DISTINCT t1.user_id) AS total_users
        FROM t1
        WHERE spending_cnt = 2
        GROUP BY t1.spend_date, CASE WHEN spending_cnt = 2 THEN 'both' ELSE 'check' END
    )

SELECT
    t5.spend_date,
    t5.platform,
    COALESCE(t7.total_amount, 0) AS total_amount,
    COALESCE(t7.total_users, 0) AS total_users
FROM 
    (
        SELECT DISTINCT spend_date, 'mobile' AS platform
        FROM Spending 
        
        UNION
        
        SELECT DISTINCT spend_date, 'desktop' AS platform
        FROM Spending 
        
        UNION
        
        SELECT DISTINCT spend_date, 'both' AS platform
        FROM Spending 
    ) t5
    LEFT OUTER JOIN (
        SELECT * FROM t3

        UNION

        SELECT * FROM t4
    ) t7 ON t5.spend_date = t7.spend_date AND t5.platform = t7.platform
