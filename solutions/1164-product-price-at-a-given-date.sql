/*
** Question: https://leetcode.com/problems/product-price-at-a-given-date/
*/

-- method 1, Oracle
WITH p_ids AS (
    SELECT DISTINCT p.product_id
    FROM Products p
    ),
    price AS (
    SELECT p.product_id, p.new_price AS price
    FROM Products p
    WHERE (p.product_id, p.change_date) IN
        (
            SELECT p.product_id, MAX(p.change_date) AS target_date
            FROM Products p
            WHERE p.change_date <= '2019-08-16'
            GROUP BY p.product_id
        )
    )

SELECT 
    t1.product_id,
    COALESCE(t2.price, 10) AS price
FROM p_ids t1
    LEFT OUTER JOIN price t2
        ON t1.product_id = t2.product_id
;

-- method 2
-- Reference from this solution: https://leetcode.com/problems/product-price-at-a-given-date/discuss/367140/Easy-to-understand-solution-beat-99.5-no-need-for-window-function-just-a-simple-union
-- Note: 
--  * A very smart way to use HAVING to find change_date post 2019-08-16
select distinct product_id, 10 as price
from Products
group by product_id
having (min(change_date) > "2019-08-16")

union

select p2.product_id, new_price
from Products p2
where (p2.product_id, p2.change_date) in

(
select product_id, max(change_date) as recent_date
from Products
where change_date <= "2019-08-16"
group by product_id
)
