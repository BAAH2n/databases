DROP TABLE IF EXISTS steam_reviews;

CREATE TABLE steam_reviews AS
WITH raw_file AS (
    SELECT unnest(reviews) AS game_reviews
    FROM read_json_auto('/Users/terminator2000/Documents/КШЕ/2 year/Database/data/steam_2025_5k-dataset-reviews_20250901.json',
    maximum_object_size = 268435456)
),
reviews_root AS (
    SELECT
        unnest(CAST(json_extract(game_reviews, '$.review_data.reviews') AS JSON[])) AS review_data
        json_extract(game_reviews, '$.appid') AS root_appid,
        json_extract_string(game_reviews, '$.review_data.query_summary.review_score_desc') AS root_score_desc
    FROM raw_file
    WHERE CAST(json_extract(game_reviews, '$.review_data.success') AS INTEGER) = 1
),
prepared_cte AS (
    SELECT
        root_appid,
        root_score_desc AS raw_game_score_desc,
        json_extract_string(review_data, '$.recommendationid') AS raw_review_id,
        json_extract_string(review_data, '$.author.steamid') AS raw_author_steamid,
        json_extract_string(review_data, '$.author.num_games_owned') AS raw_author_games_owned,
        json_extract_string(review_data, '$.author.playtime_forever') AS raw_playtime_forever,
        json_extract_string(review_data, '$.author.playtime_at_review') AS raw_playtime_at_review,
        json_extract_string(review_data, '$.author.last_played') AS raw_last_played_timestamp,
        json_extract_string(review_data, '$.language') AS raw_language,
        json_extract_string(review_data, '$.review') AS raw_review_text,
        json_extract_string(review_data, '$.timestamp_created') AS raw_created_timestamp,
        json_extract_string(review_data, '$.timestamp_updated') AS raw_updated_timestamp,
        json_extract(review_data, '$.voted_up') AS is_voted_up,
        json_extract_string(review_data, '$.votes_up') AS raw_votes_up,
        json_extract_string(review_data, '$.votes_funny') AS raw_votes_funny,
        json_extract_string(review_data, '$.weighted_vote_score') AS raw_weighted_score,
        json_extract_string(review_data, '$.comment_count') AS raw_comment_count,
        json_extract(review_data, '$.steam_purchase') AS is_steam_purchase,
        json_extract(review_data, '$.received_for_free') AS is_received_for_free,
        json_extract(review_data, '$.written_during_early_access') AS is_early_access
    FROM reviews_root
)

SELECT
    CAST(root_appid AS INTEGER) AS app_id,
    NULLIF(raw_game_score_desc, '') AS game_overall_score,
    NULLIF(raw_review_id, '') AS review_id,
    NULLIF(raw_author_steamid, '') AS author_steamid,
    CAST(NULLIF(raw_author_games_owned, '') AS INTEGER) AS author_games_count,
    CAST(NULLIF(raw_playtime_forever, '') AS INTEGER) AS playtime_forever,
    CAST(NULLIF(raw_playtime_at_review, '') AS INTEGER) AS playtime_at_review,
    NULLIF(raw_language, '') AS language,
    NULLIF(raw_review_text, '') AS review_text,
    to_timestamp(CAST(NULLIF(raw_created_timestamp, '') AS BIGINT)) AS created_at,
    to_timestamp(CAST(NULLIF(raw_updated_timestamp, '') AS BIGINT)) AS updated_at,
    to_timestamp(CAST(NULLIF(raw_last_played_timestamp, '') AS BIGINT)) AS author_last_played_at,
    is_voted_up,
    CAST(NULLIF(raw_votes_up, '') AS INTEGER) AS votes_up_count,
    CAST(NULLIF(raw_votes_funny, '') AS BIGINT) AS votes_funny_count,
    CAST(NULLIF(raw_weighted_score, '') AS DOUBLE) AS weighted_score,
    CAST(NULLIF(raw_comment_count, '') AS INTEGER) AS comment_count,
    is_steam_purchase,
    is_received_for_free,
    is_early_access

FROM prepared_cte;

SELECT * FROM steam_reviews;