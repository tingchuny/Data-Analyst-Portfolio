
/*
Subquries practices
*/

SELECT
    o.name,
    COUNT(m.id)
FROM
    orchestras   AS o
    JOIN members AS m ON o.id = m.orchestra_id
GROUP BY
    1
HAVING
    COUNT(m.id) > (SELECT   AVG (d.count1)
                   FROM     (SELECT COUNT (*) AS count1 FROM members GROUP BY orchestra_id)
                            AS d)
    
