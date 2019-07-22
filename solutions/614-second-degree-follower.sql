DROP TABLE IF EXISTS t_614_follow;
Create table t_614_follow (followee TEXT, follower TEXT);

SELECT *
FROM public.t_614_follow;

-- my solution
SELECT
    t1.follower, COUNT(DISTINCT f.follower) AS num
FROM 
    (SELECT DISTINCT follower FROM public.t_614_follow) t1
    INNER JOIN public.t_614_follow f ON t1.follower = f.followee
GROUP BY t1.follower
ORDER BY t1.follower;

-- discussion solution
select distinct follower, num
from public.t_614_follow, 
	(select followee, count(distinct follower) as num 
	 from public.t_614_follow
	 group by followee) as t
where follower = t.followee
order by follower;

-- Given a social network "following" table with two columns: “followee” and “follower”, please 
-- provide SQL statements (in any dialect) to count second-degree followers (excluding first-degree 
-- followers) for each followee.

DROP TABLE IF EXISTS following;
Create table following (followee TEXT, follower TEXT);
insert into following (followee, follower) values ('A', 'B');
insert into following (followee, follower) values ('A', 'C');
insert into following (followee, follower) values ('A', 'E');
insert into following (followee, follower) values ('B', 'C');
insert into following (followee, follower) values ('B', 'D');
insert into following (followee, follower) values ('B', 'E');
insert into following (followee, follower) values ('C', 'D');
insert into following (followee, follower) values ('C', 'F');
insert into following (followee, follower) values ('D', 'A');
insert into following (followee, follower) values ('D', 'B');
insert into following (followee, follower) values ('D', 'C');

SELECT * FROM following;

-- PostgreSQL
WITH t2 AS (
	SELECT DISTINCT f1.followee, f2.follower
	FROM following f1
		LEFT OUTER JOIN following f2 ON f1.follower = f2.followee
	WHERE f2.followee IS NOT NULL
)

SELECT 
    t3.followee,
    CASE WHEN t4.second_degree_num IS NULL THEN 0 ELSE t4.second_degree_num END AS second_degree_num
FROM
    (SELECT DISTINCT followee FROM following) t3
    LEFT OUTER JOIN
    (
        SELECT t2.followee, COUNT(t2.follower) AS second_degree_num
        FROM t2
        WHERE t2.follower NOT IN (
            SELECT follower
            FROM following
            WHERE followee = t2.followee
            ) -- to ensure not counting first degree followers
            AND t2.follower != t2.followee -- to ensure not counting followee themselves
        GROUP BY t2.followee
    ) t4 ON t3.followee = t4.followee
;






