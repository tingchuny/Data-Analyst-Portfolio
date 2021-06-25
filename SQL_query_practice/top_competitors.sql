#HackerRank Top Competitors


SELECT
    sub.hacker_id,
    hack.name
FROM
    submissions            AS sub
    LEFT JOIN challenges   AS cha  ON sub.challenge_id     = cha.challenge_id
    LEFT JOIN difficulty   AS diff ON cha.difficulty_level = diff.difficulty_level
    LEFT JOIN hackers      AS hack ON sub.hacker_id        = hack.hacker_id
WHERE
    sub.score = diff.score
GROUP BY
    sub.hacker_id,
    hack.name    
HAVING
    COUNT(sub.submission_id) > 1
ORDER BY
    COUNT(sub.submission_id) DESC,
    hacker_id ASC
