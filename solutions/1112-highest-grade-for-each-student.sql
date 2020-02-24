/*
** Question: https://leetcode.com/problems/highest-grade-for-each-student/
*/

-- method 1, MS SQL/Postgres
SELECT
    t1.student_id, t1.course_id, t1.grade
FROM
(
    SELECT
        *,
        RANK() OVER (PARTITION BY e.student_id ORDER BY e.grade DESC, e.course_id) AS pos
    FROM Enrollments e
) t1
WHERE t1.pos = 1
ORDER BY t1.student_id

-- method 2, MySQL/Postgres
-- Note: Key here is GROUP BY; note that in SELECT, MIN() can be 
--       in the middle between student_id and grade
SELECT e.student_id, MIN(e.course_id) AS course_id, e.grade
FROM Enrollments e
WHERE (e.student_id, e.grade) IN 
    (
        SELECT e.student_id, MAX(e.grade) AS grade
        FROM Enrollments e
        GROUP BY e.student_id
    )
GROUP BY e.student_id, e.grade
ORDER BY e.student_id
