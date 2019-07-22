/*
** Question: https://leetcode.com/problems/average-salary-departments-vs-company/
*/

-- method 1, MS SQL Server
-- For MySQL it's slightly different where we need to CAST to CHAR instead of VARCHAR
SELECT 
    t1.pay_month, t1.department_id,
    CASE WHEN t1.dept_avg > t2.all_avg THEN 'higher'
        WHEN t1.dept_avg = t2.all_avg THEN 'same'
        WHEN t1.dept_avg < t2.all_avg THEN 'lower'
        ELSE 'CHECK' END AS comparison
FROM
    (
        SELECT 
            SUBSTRING(CAST(s.pay_date AS VARCHAR), 1, 7) AS pay_month,
            e.department_id,
            AVG(s.amount) AS dept_avg
        FROM salary s
            INNER JOIN employee e ON 
                s.employee_id = e.employee_id
        GROUP BY 
            SUBSTRING(CAST(s.pay_date AS VARCHAR), 1, 7), 
            e.department_id
    ) t1
    LEFT OUTER JOIN (
        SELECT
            SUBSTRING(CAST(s.pay_date AS VARCHAR), 1, 7) AS pay_month,
            AVG(s.amount) AS all_avg
        FROM salary s
        GROUP BY 
            SUBSTRING(CAST(s.pay_date AS VARCHAR), 1, 7)
    ) t2
    ON t1.pay_month = t2.pay_month
;
