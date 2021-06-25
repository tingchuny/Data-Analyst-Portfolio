#Simplified long query

#Before

WITH a AS (

SELECT
    name,
    grade,
    marks
FROM
    students
    LEFT JOIN grades ON students.marks between grades.min_mark and grades.max_mark
WHERE
    grade >= 8
ORDER BY
    grade DESC,
    name ASC

)

,b AS (

SELECT
    Null as name,
    grade,
    marks
FROM
    students
    LEFT JOIN grades ON students.marks between grades.min_mark and grades.max_mark
WHERE
    grade < 8
ORDER BY 
    grade DESC,
    marks ASC

)

SELECT
    *
FROM
    a  
UNION ALL
SELECT
    *
FROM
    b
ORDER BY
    grade DESC,
    name ASC,
    marks ASC
;

#After

SELECT
    IF(grade <8, NULL, name) AS name,
    grade,
    marks
FROM
    students
    LEFT JOIN grades ON students.marks between grades.min_mark and grades.max_mark
ORDER BY
    grade DESC,
    name ASC,
    marks ASC


