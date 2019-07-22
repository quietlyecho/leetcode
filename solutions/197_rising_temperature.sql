/*
** Question: https://leetcode.com/problems/rising-temperature/
*/

-- method 1, Oracle
SELECT w1.Id
FROM Weather w1
    INNER JOIN Weather w2 ON w1.RecordDate = w2.RecordDate + 1
WHERE w1.Temperature > w2.Temperature
;

-- method 2, Oracle
-- Note: the comparison between temperatures can happen in JOIN's criteria
SELECT DISTINCT w1.Id
FROM Weather w1
    INNER JOIN Weather w2 ON
        w1.RecordDate = w2.RecordDate + 1
        AND w1.Temperature > w2.Temperature
;
