WITH a AS (
    
    SELECT
        CONCAT(name, '(', SUBSTRING(occupation,1,1), ')') AS name,
        0                                                 AS total,
        1                                                 AS order_key
    FROM
        occupations

), b AS (

    SELECT
        CONCAT('There are a total of', ' ', count(*), ' ', lower(occupation), 's.') AS sentence,
        COUNT(*)                                                                    AS total,
        2                                                                           AS order_key
    FROM
        occupations
    GROUP BY
        occupation

), c AS (

    SELECT
        name,
        total,
        order_key
    FROM
        a

    UNION ALL

    SELECT
        sentence,
        total,
        order_key
    FROM
        b

)

SELECT
    name
FROM
    c
ORDER BY
    order_key,
    total,
    name
