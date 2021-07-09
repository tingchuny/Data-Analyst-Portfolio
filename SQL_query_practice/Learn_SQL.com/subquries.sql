
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
    

/*
correlated subquries
*/
SELECT
    m.name AS member,
    o.name AS orchestra
FROM
    members AS m
    JOIN orchestras AS o ON m.orchestra_id = o.id
WHERE
    m.experience = 
        (SELECT MAX(experience)
        FROM members AS m1 
        WHERE m1.orchestra_id = m.orchestra_id)


SELECT
    m.name
FROM
    members AS m
WHERE
    m.wage >
        (SELECT AVG(mm.wage)
        FROM    members AS mm
        WHERE   mm.position = 'violin'
                AND
                m.orchestra_id = mm.orchestra_id);

SELECT
    o.name,
    o.rating,
    o.city_origin,
    (SELECT COUNT(*) 
     FROM concerts AS c 
     WHERE  c.country = 'Ukraine' 
            AND 
            o.id = c.orchestra_id) AS count
FROM
    orchestras AS o
WHERE
    o.country_origin = 'Germany'
