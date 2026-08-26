-- DISPLAY ENTIRE TABLE
SELECT * FROM world_cup_2026_matches;

/* WINNERS FOR EACH MATCH | ONLY 84 MATCHES HAD A WINNER */
WITH away_winners AS ( -- All instances of teams who have won their away games
    SELECT
        away_team AS match_winner,
        score,
        notes
    FROM 
        world_cup_2026_matches
    WHERE
        away_score > home_score
        OR
        -- KNOCKOUT STAGE MATCHES HAD NO VALUES FOR away_score & home_score, notes CONTAINED MATCH WINNER
        notes ILIKE '%' || away_team || '%'
            -- ILIKE finds pattern, regardless of capitalization
            -- || concats strings --> %away_team%
),
home_winners AS ( -- All instances of teams who have won their home games
    SELECT
        home_team AS match_winner,
        score,
        notes
    FROM 
        world_cup_2026_matches
    WHERE
        home_score > away_score
        OR
        -- KNOCKOUT STAGE MATCHES HAD NO VALUES FOR away_score & home_score, notes CONTAINED MATCH WINNER
        notes IlIKE '%' || home_team || '%'
            -- ILIKE finds pattern, regardless of capitalization
            -- || concats strings --> %home_team%

)

-- Table for all match winners
SELECT
    *
FROM
    home_winners

UNION ALL

SELECT
    *
FROM
    away_winners;

/* GAMES WITH NO DECIDED WINNER (TIED GROUP STAGE MATCHES) || 20 MATCHES WITH NO DECIDED WINNER */
SELECT
    home_team,
    away_team,
    score
FROM
    world_cup_2026_matches
WHERE
    home_score = away_score;

/* ALL 104 GAMES ARE ACCOUNTED FOR */