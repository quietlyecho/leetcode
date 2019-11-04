/*
** Question:
*/

-- method 1, Oracle/Postgres

SELECT
    ROUND(SUM(imm_flag) * 100.0 / COUNT(*), 2) AS immediate_percentage
FROM
(
    SELECT 
        d.*,
        CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1
            ELSE 0 END AS imm_flag,
        RANK() OVER (
            PARTITION BY d.customer_id ORDER BY d.order_date) AS pos
    FROM Delivery d
) t1
WHERE t1.pos = 1
;

-- method 2, Oracle/Postgres
-- The difference here is to use IN and Row Constructor to find customer id 
-- and its minimum order date
--
-- References:
-- https://www.postgresql.org/docs/current/functions-subquery.html#FUNCTIONS-SUBQUERY-IN
-- https://www.postgresql.org/docs/current/sql-expressions.html#SQL-SYNTAX-ROW-CONSTRUCTORS

SELECT
    ROUND(SUM(CASE WHEN d.customer_pref_delivery_date = d.order_date THEN 1
              ELSE 0 END) * 100.0 / COUNT(*),
          2) AS immediate_percentage
FROM Delivery d
WHERE (d.customer_id, d.order_date) IN (
        SELECT customer_id, MIN(order_date) AS min_order_date
        FROM Delivery
        GROUP BY customer_id)
;
