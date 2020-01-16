/*
** Question: https://leetcode.com/problems/market-analysis-i/
*/

-- method 1, MS SQL
SELECT
    u.user_id AS buyer_id,
    u.join_date,
    COALESCE(t1.orders_in_2019, 0) AS orders_in_2019
FROM Users u
    LEFT OUTER JOIN (
        SELECT buyer_id, COUNT(*) AS orders_in_2019
        FROM Orders 
        WHERE DATEPART(yy, order_date) = 2019
        GROUP BY buyer_id
    ) t1
        ON u.user_id = t1.buyer_id

-- method 2, Oracle
-- Reference is this solution: https://leetcode.com/problems/market-analysis-i/discuss/357761/A-simple-MYSQL-solution-beats-100-so-far
SELECT
    u.user_id AS buyer_id, u.join_date,
    COUNT(o.order_id) AS orders_in_2019
FROM Users u
    LEFT OUTER JOIN Orders o
        ON u.user_id = o.buyer_id AND DATEPART(yy, order_date) = 2019
GROUP BY u.user_id, u.join_date
