SELECT
    s.date,
    p.name,
    s.amount,
    n.calories
FROM
    sales_history         AS s
    JOIN product         AS p ON s.product_id = p.id
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
    p.price    AS price,
    pr.name AS company_name
    
FROM
    product AS p
    LEFT JOIN sales_history AS s 
        ON s.product_id = p.id
        AND s.date BETWEEN '2015-02-01' AND '2015-02-05'
    LEFT JOIN producer AS pr ON p.producer_id = pr.id
WHERE
    s.product_id IS NULL;


/*
Query items' name/price and filter the departments
*/
SELECT
	p.name,
    p.price
FROM
	product AS p
    JOIN department 	AS d 	ON p.department_id = d.id
    LEFT JOIN producer 	AS pr 	ON pr.id = p.producer_id
    							AND pr.name != 'GoodFoods'
WHERE
	d.name IN ('fruits', 'vegetables')
