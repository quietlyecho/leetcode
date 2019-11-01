/*
** Question: https://leetcode.com/problems/sales-analysis-iii/
*/

-- method 1, MySQL, use GROUP BY
SELECT p.product_id, p.product_name
FROM Sales s
    INNER JOIN Product p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING MIN(s.sale_date) >= '2019-01-01' AND MAX(s.sale_date) <= '2019-03-31'
