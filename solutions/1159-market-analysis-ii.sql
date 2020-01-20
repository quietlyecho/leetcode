/*
** Question: https://leetcode.com/problems/market-analysis-ii/
*/

-- method 1, MS SQL (doesn't work for Oracle), Postgres
SELECT
    u.user_id AS seller_id,
    CASE WHEN u.favorite_brand = t1.item_brand THEN 'yes' ELSE 'no' END AS '2nd_item_fav_brand'
FROM
    Users u
    LEFT OUTER JOIN
    (
        SELECT o.seller_id, i.item_brand,
            RANK() OVER (PARTITION BY o.seller_id ORDER BY o.order_date) AS pos
        FROM Orders o
            INNER JOIN Items i
                ON o.item_id = i.item_id
    ) t1 -- Orders with ordering of each sale per seller
        ON u.user_id = t1.seller_id AND t1.pos = 2
