USE Assignment_2;

SELECT
    u.username,
    p.post_content,
    p.likes_count,
    COUNT(c.comment_id) AS total_comments_on_post
FROM
    posts AS p
JOIN
    users AS u ON p.user_id = u.user_id 
JOIN
    comments AS c ON p.post_id = c.post_id 
WHERE
    u.country = 'Germany'
    AND u.user_id IN (
        SELECT DISTINCT user_id    -- Searching users that have written comments  
        FROM comments
    )
GROUP BY
    p.post_id, u.username, p.post_content, p.likes_countн
ORDER BY
    total_comments_on_post DESC