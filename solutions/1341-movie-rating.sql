/*
** Question: https://leetcode.com/problems/movie-rating/
*/

-- method 1, Oracle/Postgres

WITH full_table AS (
    SELECT mr.movie_id, mr.user_id, mr.rating, mr.created_at,
        u.name, m.title
    FROM Movie_Rating mr
        INNER JOIN Users u ON mr.user_id = u.user_id
        INNER JOIN Movies m ON mr.movie_id = m.movie_id
)

SELECT 
    t2.name AS results
FROM
(
    SELECT
        t1.name,
        RANK() OVER (ORDER BY t1.review_cnt DESC, t1.name ASC) AS pos
    FROM
    (
        SELECT ft.user_id, ft.name, COUNT(*) AS review_cnt
        FROM full_table ft
        GROUP BY ft.user_id, ft.name
    ) t1
) t2
WHERE t2.pos = 1

UNION

SELECT 
    t4.title AS results
FROM
(
    SELECT
        t3.title,
        RANK() OVER (ORDER BY t3.avg_rating DESC, t3.title ASC) AS pos
    FROM
    (
        SELECT ft.movie_id, ft.title, AVG(ft.rating) AS avg_rating
        FROM full_table ft
        WHERE ft.created_at BETWEEN '2020-02-01' AND '2020-02-29'
        GROUP BY ft.movie_id, ft.title
    ) t3
) t4
WHERE t4.pos = 1
