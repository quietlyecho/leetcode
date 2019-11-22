/*
** Question: https://leetcode.com/problems/immediate-food-delivery-i/
*/

-- method 1, MS SQL
SELECT
    ROUND(
        SUM(CASE WHEN d.customer_pref_delivery_date = d.order_date THEN 1 
            ELSE 0 END) * 100.0 / COUNT(*), 
        2) AS immediate_percentage
FROM Delivery d
;

