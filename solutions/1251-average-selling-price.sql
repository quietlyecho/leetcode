/*
** Question: https://leetcode.com/problems/average-selling-price/
*/

-- method 1, Oracle
SELECT 
    u.product_id,
    ROUND(SUM(u.units * p.price) * 1.0 / SUM(u.units), 2) AS average_price
FROM UnitsSold u
    INNER JOIN Prices p
        ON u.product_id = p.product_id 
        AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY u.product_id
ORDER BY u.product_id
