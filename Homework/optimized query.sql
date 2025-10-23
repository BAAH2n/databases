USE Assignment_2;

CREATE INDEX idx_posts_user_id ON posts (user_id);
CREATE INDEX idx_comments_post_id ON comments (post_id);
CREATE INDEX idx_users_county ON users (country);
CREATE INDEX idx_comments_user_id ON comments (user_id);

WITH stats_about_users AS (
	SELECT p.user_id, 
    COUNT(p.post_id) AS quantity_of_posts_by_author, 
    AVG(p.likes_count) AS avg_likes_on_comment_author
    FROM posts AS p
    GROUP BY p.user_id
)
SELECT
	c.comment_text, 
	p.post_content, 
	u.username,
    st_c.avg_likes_on_comment_author,
    st_p.quantity_of_posts_by_author
FROM users AS u
JOIN posts AS p ON u.user_id = p.user_id 
JOIN comments AS c ON p.post_id = c.post_id 
LEFT JOIN stats_about_users AS st_p ON st_p.user_id = p.user_id
LEFT JOIN stats_about_users AS st_c ON st_c.user_id = c.user_id
WHERE u.country = 'Germany'
    