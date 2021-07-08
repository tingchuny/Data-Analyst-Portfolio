SELECT
    s.date,
    p.name,
    s.amount,
    n.calories
FROM
    sales_history       AS s
    JOIN product        AS p ON s.product_id = p.id
    JOIN nutrition_data AS n ON n.product_id = p.id
WHERE
    p.id IN (13, 18, 15)
ORDER BY
    s.date, n.calories;


/*
query items that is null between the 2 dates.
*/

SELECT
    p.name  AS product_name,
    p.price AS price,
    pr.name AS company_name
    
FROM
    product                     AS p
    LEFT JOIN sales_history     AS s 
        ON s.product_id = p.id
        AND s.date BETWEEN '2015-02-01' AND '2015-02-05'
    LEFT JOIN producer          AS pr 
        ON p.producer_id = pr.id
WHERE
    s.product_id IS NULL;


/*
Query items' name/price and filter the departments
*/

SELECT
    p.name,
    p.price
FROM
    product             AS p
    JOIN department     AS d     ON p.department_id = d.id
    LEFT JOIN producer     AS pr     ON pr.id = p.producer_id
                                AND pr.name != 'GoodFoods'
WHERE
    d.name IN ('fruits', 'vegetables')
    
    
/*
Join course end exercise
*/
SELECT
    s.id,
    l.name,
    s.language,
    s.group_level,
    t.day,
    t.hour
FROM
    student_group   AS s
    JOIN timetable  AS t    ON s.id         = t.group_id
    JOIN timetable  AS t2   ON t.group_id   = t2.group_id
    JOIN lecturer   AS l    ON l.id         = s.lecturer_id
    JOIN tuition    AS tu   ON tu.group_id  = s.id
WHERE
    t.hour = t2.hour
    AND
    t.day != t2.day
    AND
    cost > 800


/*
2 queries with the same results
*/

SELECT
    o.id                AS order_id,
    c.first_name        AS first_name,
    c.last_name         AS last_name,
    SUM(oi.price)       AS revenue
FROM
    orders              AS o
    JOIN clients        AS c     ON c.id = o.client_id
    JOIN order_items    AS oi     ON o.id = oi.order_id
GROUP BY
    1,2,3;
    
SELECT
    o.id                        AS order_id,
    c.first_name                AS first_name,
    c.last_name                 AS last_name,
    (SELECT SUM(price)
     FROM order_items    AS oi
     WHERE oi.order_id = o.id)  AS revenue
FROM
    orders                      AS o
    JOIN clients                AS c ON c.id = o.client_id
