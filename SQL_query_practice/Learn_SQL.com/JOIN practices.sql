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
    
    
/*
By not joining the two tables, all the possible combinations are created,
then using where to set the rull instead of using CASE statment.
*/
SELECT
    first_name,
    last_name,
    salary,
    grade
FROM
    employee,
    salgrade
WHERE
    salary BETWEEN lower_limit AND upper_limit
    
/*
*/

SELECT
    cat.name
FROM
    category AS cat
    JOIN clothing AS cl ON cl.category_id = cat.id
                        AND cat.parent_id IS NULL
GROUP BY
    1
HAVING
    COUNT(cl.id) > 2
    
/*
The following 2 queries shows the same result
*/

SELECT
    cu.last_name,
    cu.first_name,
    co.name
FROM
    customer AS cu
    JOIN color AS co ON cu.favorite_color_id = co.id
WHERE
    cu.id NOT IN (SELECT customer_id
                  FROM clothing_order);

SELECT
    cu.last_name,
    cu.first_name,
    co.name
FROM
    customer cu
JOIN
    color AS co ON co.id = cu.favorite_color_id
LEFT JOIN
    clothing_order AS clo ON clo.customer_id = cu.id
WHERE
    clo.customer_id IS NULL;
