/*
** Question: https://leetcode.com/problems/students-and-examinations/
**
** Notes:
**  - Refer to below for CROSS JOIN
**      - https://www.postgresql.org/docs/current/queries-table-expressions.html#QUERIES-FROM
*/

-- method 1, Oracle
-- This is based on this solution: https://leetcode.com/problems/students-and-examinations/discuss/445296/Simple-MySQL-solution-beats-100-with-LEFT-JOIN-(no-subquery)
-- Takeaway: 
--  1. Do not need subquery; can switch to use GROUP BY; this is faster.
--  2. When need to covert NULL to 0, do not always focus on CASE WHEN; COUNT/SUM also ignores NULL

SELECT
    st.student_id, st.student_name, su.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students st
    CROSS JOIN Subjects su
    LEFT OUTER JOIN Examinations e
        ON st.student_id = e.student_id AND su.subject_name = e.subject_name
GROUP BY st.student_id, st.student_name, su.subject_name
ORDER BY st.student_id, su.subject_name;

-- method 2, Oracle/Postgres
SELECT
    st.student_id, st.student_name, su.subject_name,
    CASE WHEN t1.attended_exams IS NULL THEN 0
        ELSE t1.attended_exams END AS attended_exams
FROM Students st
    CROSS JOIN Subjects su
    LEFT OUTER JOIN (
        SELECT student_id, subject_name, COUNT(*) AS attended_exams
        FROM Examinations
        GROUP BY student_id, subject_name
    ) t1
        ON st.student_id = t1.student_id AND su.subject_name = t1.subject_name
ORDER BY st.student_id, su.subject_name;
