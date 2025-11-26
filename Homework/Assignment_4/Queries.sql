DROP TABLE IF EXISTS merged;
CREATE TABLE merged AS
    SELECT * FROM steam_games g
    JOIN steam_reviews r on g.app_id = r.app_id;

SELECT * FROM merged;

-- #1. I want to find the TOP-10 productive developers

WITH dev AS (
    SELECT DISTINCT
        unnest(CAST(merged.developers AS VARCHAR[])) AS Developer,
        merged.game_name AS Games
    FROM merged
    WHERE merged.release_date >= '2022-01-01' AND merged.product_type = 'game'
)
SELECT
    Developer,
    list(Games) AS Games,
    COUNT (*) AS Number_of_games
FROM dev
GROUP BY Developer
ORDER BY Number_of_games DESC
LIMIT 10;

-- #2. I want to compare the average users' playing time who left positive reviews against those who left negative games

SELECT
    game_name,
    AVG(CASE WHEN is_voted_up = true THEN playtime_forever ELSE NULL END) AS avg_positive_playtime,
    AVG(CASE WHEN is_voted_up = false THEN playtime_forever ELSE NULL END) AS avg_negative_playtime,
FROM merged
WHERE playtime_forever IS NOT NULL
GROUP BY game_name
HAVING avg_positive_playtime IS NOT NULL AND avg_negative_playtime IS NOT NULL;

-- #3. Distribution of languages in which reviews are written

SELECT
    language AS review_language,
    COUNT (*) AS number_of_reviews
FROM merged
GROUP BY review_language
ORDER BY number_of_reviews;

-- #4. I want to get the TOP-5 games with the funniest reviews (ratio between funny and all reviews)

WITH calculated_stats AS (
    SELECT
        game_name,
        SUM(votes_funny_count) AS number_of_funny_marks,
        COUNT(*) AS number_of_reviews
    FROM merged
    GROUP BY game_name
)
SELECT
    game_name,
    number_of_funny_marks,
    number_of_reviews,
    (number_of_funny_marks * 100.0 / number_of_reviews) AS percent_of_funny_marks
FROM calculated_stats
WHERE number_of_funny_marks < 1000 -- I have noticed that we have abnormal values on some reviews (4294967295), so I assume that it is cheating, so I filtered it
ORDER BY percent_of_funny_marks DESC
LIMIT 5;

-- #5. I want to compare the average number of reviews in free games and not

SELECT
    is_free AS is_game_free,
    COUNT(*) AS total_reviews,
    COUNT(DISTINCT game_name) AS unique_games_count,
    CAST(COUNT(*) AS DOUBLE) / COUNT(DISTINCT game_name) AS avg_reviews_per_game
FROM merged
GROUP BY is_free;