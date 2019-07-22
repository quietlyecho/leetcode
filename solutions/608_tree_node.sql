/*
** Question: https://leetcode.com/problems/tree-node/submissions/
*/

-- method 1
WITH cid_cnt AS (
    SELECT p_id, COUNT(id) AS cid_cnt
    FROM tree
    WHERE p_id IS NOT NULL
    GROUP BY p_id
)

SELECT
    t.id,
    CASE 
        WHEN t.p_id IS NOT NULL AND cid_cnt IS NULL THEN 'Leaf'
        WHEN t.p_id IS NOT NULL AND cid_cnt > 0 THEN 'Inner'
        WHEN t.p_id IS NULL THEN 'Root'
        ELSE 'CHECK'
        END AS Type
FROM tree t
    LEFT OUTER JOIN cid_cnt c ON t.id = c.p_id
ORDER BY t.id
;

-- method 2
-- Note: it's important that the argument for IN is actually a single column table.
SELECT
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT p_id FROM tree) THEN 'Inner'
        ELSE 'Leaf'
        END AS Type
FROM tree
ORDER BY id
;
