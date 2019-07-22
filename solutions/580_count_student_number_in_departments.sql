/*
** Question: https://leetcode.com/problems/count-student-number-in-departments/
*/

-- method 1
SELECT
    d.dept_name,
    SUM(CASE 
        WHEN s.student_id IS NOT NULL THEN 1
        ELSE 0 END) AS student_number        
FROM department d
    LEFT OUTER JOIN student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name  
ORDER BY student_number DESC, d.dept_name ASC
;

-- method 2
-- Important to know the difference between COUNT(*) and COUNT(column_name): COUNT(*) counts NULLs, but 
-- COUNT(column_name) doesn't.
-- Reference: https://stackoverflow.com/questions/59294/in-sql-whats-the-difference-between-countcolumn-and-count
SELECT
    d.dept_name,
    COUNT(s.student_id) AS student_number
FROM department d
    LEFT OUTER JOIN student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY student_number DESC, d.dept_name ASC
;
