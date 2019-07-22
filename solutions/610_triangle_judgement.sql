/*
** Question: https://leetcode.com/problems/triangle-judgement/
*/

-- method 1
SELECT
    t.x, t.y, t.z,
    CASE 
        WHEN t.x + t.y > t.z AND 
            t.x + t.z > t.y AND 
            t.y + t.z > t.x THEN 'Yes'
        ELSE 'No' END AS triangle
FROM triangle t
;
