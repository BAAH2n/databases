USE Assignment_2;

DROP INDEX idx_posts_user_id ON posts;
DROP INDEX idx_comments_post_id ON comments;
DROP INDEX idx_users_county ON users;
DROP INDEX idx_comments_user_id ON comments;

EXPLAIN ANALYZE
SELECT
    c.comment_text,    -- Дані з головного запиту
    p.post_content,    -- Дані з головного запиту
    u.username,        -- Дані з головного запиту
    
    -- "Важкий" корельований підзапит 1 (як на твоїй фотці):
    -- Запускається 1 раз для КОЖНОГО знайденого коментаря.
    -- Рахує середню к-сть лайків для автора КОМЕНТАРЯ (c.user_id)
    (SELECT AVG(p2.likes_count) 
     FROM posts AS p2 
     WHERE p2.user_id = c.user_id) AS avg_likes_for_commenter,
     
    -- "Важкий" корельований підзапит 2 (як на твоїй фотці):
    -- Запускається 1 раз для КОЖНОГО знайденого коментаря.
    -- Рахує загальну к-сть постів автора ПОСТА (p.user_id)
    (SELECT COUNT(p3.post_id)
     FROM posts AS p3
     WHERE p3.user_id = p.user_id) AS total_posts_by_post_author

FROM
    users AS u
JOIN
    posts AS p ON u.user_id = p.user_id    -- JOIN 1 (Users <-> Posts)
JOIN
    comments AS c ON p.post_id = c.post_id  -- JOIN 2 (Posts <-> Comments)
WHERE
    u.country = 'Germany'; -- Фільтруємо по авторах постів
