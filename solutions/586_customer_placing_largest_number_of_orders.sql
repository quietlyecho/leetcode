/*
** Question: https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/
*/

-- method 1, MySQL
SELECT o.customer_number
FROM orders o
GROUP BY o.customer_number
ORDER BY COUNT(o.order_number) DESC
LIMIT 1
;

-- method 2, Oracle
-- Oracle doesn't support LIMIT statement
-- This method addresses follow-up question as well.
WITH order_cnt AS (
    SELECT
        customer_number,
        RANK() OVER (ORDER BY order_count DESC) AS pos
    FROM
    (
        SELECT customer_number, COUNT(order_number) AS order_count
        FROM orders
        GROUP BY customer_number
    ) t1
)

SELECT customer_number
FROM order_cnt
WHERE pos = 1
;
