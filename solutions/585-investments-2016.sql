/*
** Question: https://leetcode.com/problems/investments-in-2016/
*/

-- create table
CREATE TABLE IF NOT EXISTS insurance (PID SMALLINT, TIV_2015 NUMERIC(15,2), TIV_2016 NUMERIC(15,2), LAT NUMERIC(5,2), LON NUMERIC(5,2));
TRUNCATE TABLE insurance;
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('1', '10', '5', '10', '10');
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('2', '20', '20', '20', '20');
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('3', '10', '30', '20', '20');
INSERT INTO insurance (PID, TIV_2015, TIV_2016, LAT, LON) VALUES ('4', '10', '40', '40', '40');

-- method 1, Oracle
SELECT
    ROUND(SUM(t1.TIV_2016), 2) AS TIV_2016
FROM
(
    SELECT
        i.PID,
        i.TIV_2015,
        i.TIV_2016,
        COUNT(*) OVER (PARTITION BY i.TIV_2015) AS tiv_2015_cnt,
        COUNT(*) OVER (PARTITION BY i.LAT || i.LON) AS location_cnt
    FROM insurance i
) t1
WHERE 
    t1.tiv_2015_cnt > 1 AND location_cnt = 1
;

-- method 2, MySQL
-- Below is from the discussion section.
select sum(TIV_2016) TIV_2016
from insurance a
where 
    1 = (select count(*) from insurance b where a.LAT=b.LAT and a.LON=b.LON)
    and 1 < (select count(*) from insurance c where a.TIV_2015=c.TIV_2015);

-- method 3, Oracle
SELECT ROUND(SUM(TIV_2016), 2) AS TIV_2016
FROM insurance i
WHERE i.TIV_2015 IN
        (SELECT TIV_2015 FROM insurance WHERE PID != i.PID)
    AND i.LAT || i.LON NOT IN
        (SELECT LAT || LON FROM insurance WHERE PID != i.PID);

