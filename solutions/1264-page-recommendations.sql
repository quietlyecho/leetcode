/*
** Question: https://leetcode.com/problems/page-recommendations/
*/

-- method 1, Oracle
-- Can also not use CTE, but put the whole CTE into a subquery directly
WITH user_1_friends AS (
    
    SELECT user2_id AS friend_id
    FROM Friendship
    WHERE user1_id = 1
    
    UNION
    
    SELECT user1_id AS friend_id
    FROM Friendship
    WHERE user2_id = 1
    
)

SELECT DISTINCT l.page_id AS recommended_page
FROM Likes l
WHERE l.page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1)
    AND l.user_id IN (SELECT friend_id FROM user_1_friends)
;

-- method 2, Oracle/MySQL
-- Refer to here: https://leetcode.com/problems/page-recommendations/discuss/435145/mysql-solution
-- CASE WHEN is also a good option; this is faster than method 1
select distinct page_id as recommended_page
from
(select
case
when user1_id=1 then user2_id
when user2_id=1 then user1_id
end as user_id
from Friendship) a
join Likes
on a.user_id=Likes.user_id
where page_id not in (select page_id from Likes where user_id=1)
