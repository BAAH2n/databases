DROP TABLE IF EXISTS steam_games;

CREATE TABLE steam_games AS
WITH raw_games AS (
    SELECT unnest(games) AS games
    FROM read_json_auto('/Users/terminator2000/Documents/КШЕ/2 year/Database/data/steam_2025_5k-dataset-games_20250831.json',
    maximum_object_size = 268435456)
),
data_root AS (
    SELECT
        json_extract(games, '$.app_details.data') AS data,
        json_extract(games, '$.appid') AS root_appid,
        json_extract_string(games, '$.name_from_applist') AS root_name
    FROM raw_games
    WHERE CAST(json_extract(games, '$.app_details.success') AS BOOLEAN) = true
),
prepared_cte AS (
    SELECT
        root_appid,
        root_name,
        json_extract_string(data, '$.type') AS raw_type,
        json_extract_string(data, '$.required_age') AS raw_age_limit,
        json_extract(data, '$.is_free') AS is_free,
        json_extract_string(data, '$.detailed_description') AS raw_detailed_desc,
        json_extract_string(data, '$.about_the_game') AS raw_about,
        json_extract_string(data, '$.short_description') AS raw_short_desc,
        json_extract_string(data, '$.fullgame.appid') AS raw_fullgame_id,
        json_extract_string(data, '$.fullgame.name') AS raw_fullgame_name,
        json_extract_string(data, '$.website') AS raw_website,
        json_extract_string(data, '$.release_date.date') AS raw_release_date,
        json_extract(data, '$.developers') AS developers,
        json_extract(data, '$.publishers') AS publishers,
        json_extract(data, '$.categories[*].description') AS category_descriptions,
        json_extract(data, '$.platforms.windows') AS is_on_windows,
        json_extract(data, '$.platforms.mac') AS is_on_mac,
        json_extract(data, '$.platforms.linux') AS is_on_linux,
        json_extract_string(data, '$.support_info.url') AS raw_support_url,
        json_extract_string(data, '$.support_info.email') AS raw_support_email,
        json_extract_string(data, '$.ratings.dejus.required_age') AS raw_dejus_age,
        json_extract_string(data, '$.ratings.steam_germany.required_age') AS raw_germany_age,
    FROM data_root
)

SELECT
    root_appid AS app_id,
    NULLIF(root_name, '') AS game_name,

    NULLIF(raw_type, '') AS product_type,
    CAST(NULLIF(raw_age_limit, '') AS INTEGER) AS age_limit,
    is_free,
    NULLIF(raw_detailed_desc, '') AS detailed_description,
    NULLIF(raw_about, '') AS about_the_game,
    NULLIF(raw_short_desc, '') AS short_description,
    CAST(NULLIF(raw_fullgame_id, '') AS INTEGER) AS fullgame_appid,
    NULLIF(raw_fullgame_name, '') AS fullgame_name,
    NULLIF(raw_website, '') AS website,
    NULLIF(developers, 'null') AS developers,
    NULLIF(publishers, 'null') AS publishers,
    NULLIF(category_descriptions, []) AS category_descriptions,
    is_on_windows,
    is_on_mac,
    is_on_linux,
    TRY_STRPTIME(NULLIF(raw_release_date, ''), '%b %d, %Y') AS release_date,
    NULLIF(raw_support_url, '') AS support_url,
    NULLIF(raw_support_email, '') AS support_email,
    CAST(NULLIF(raw_dejus_age, '') AS INTEGER) AS dejus_age_limit,
    CAST(NULLIF(raw_germany_age, '') AS INTEGER) AS germany_age_limit,
FROM prepared_cte;

SELECT * FROM steam_games;