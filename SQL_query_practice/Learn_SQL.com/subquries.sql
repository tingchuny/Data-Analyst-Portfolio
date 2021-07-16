
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
    orchestras  AS o
WHERE
    o.country_origin = 'Germany';

SELECT
    m.name                      AS name,
    (SELECT COUNT(*) 
    FROM piece_of_art AS p 
    WHERE p.museum_id = m.id)   AS piece_count
FROM
    museum      AS m


/*
subqury in WHERE clause
*/

SELECT
    o.name,
    c.city,
    c.rating
FROM
    orchestras      AS o
    JOIN concerts   AS c ON o.id = c.orchestra_id
WHERE
    c.rating IN (
        SELECT MAX(rating)
        FROM concerts
        WHERE concerts.orchestra_id = o.id)


/*
LEFT JOIN vs Using subqury to get the same result
*/

SELECT
    k.last_name,
    k.first_name,
    k.experience
FROM 
    dog_sitter k
    LEFT JOIN care c ON k.id = c.dog_sitter_id
WHERE
    c.dog_id IS NULL;

SELECT
    s.last_name,
    s.first_name,
    s.experience
FROM
    dog_sitter AS s
WHERE
    s.id NOT IN (SELECT dog_sitter_id FROM care)
