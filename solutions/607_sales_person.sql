/*
** Question: https://leetcode.com/problems/sales-person/ 
*/

-- method 1
SELECT s.name
FROM salesperson s
WHERE s.sales_id NOT IN
    (
    SELECT 
        DISTINCT o.sales_id
    FROM orders o
        LEFT OUTER JOIN company c ON o.com_id = c.com_id
    WHERE 
        c.name = 'RED'
    )
;
