-- FULL DISPLAY OF NEW TABLE
SELECT * FROM elevated_stadium_player_performances;

/* Physical performance */

-- DISTANCE COVERED BY TEAMS PER 90
WITH avg_distance_per_team AS (
    SELECT
        -- Identifier for world cup match
        match_id,

        --  Name of national team
        team_name,

        -- Average distance covered by each national team per 90
        ROUND(
            AVG(
                (total_distance_m / NULLIF(minutes_played, 0)) * 90
            ),
            2
        ) AS avg_distance_m_per_90,

        -- Rank each country per match on higher covered distance
        ROW_NUMBER() OVER (
            -- Ranks countries with the same match_ids
            PARTITION BY match_id

            -- Orders ranking based on highest distance covered
            ORDER BY ROUND(
                AVG(
                    (total_distance_m / NULLIF(minutes_played, 0)) * 90
                ),
                2
            ) DESC
        ) AS rank
    FROM elevated_stadium_player_performances
    WHERE minutes_played >= 10 -- removes outliers (left skew), consider only meaningful minutes (amount of time to earn a match rating)
    GROUP BY 
        match_id, 
        team_name
)

-- FIND IF TEAM WITH MOST DISTANCE COVERED WON THE MATCH
SELECT
    avg_distance_per_team.*,
    CASE
        WHEN 
            avg_distance_per_team.team_name = matches_detailed.home_team_name 
            AND
            matches_detailed.home_score > matches_detailed.away_score
        THEN TRUE
        
        WHEN 
            avg_distance_per_team.team_name = matches_detailed.away_team_name
            AND
            matches_detailed.home_score < matches_detailed.away_score
        THEN TRUE

        ELSE FALSE
    END AS winner
FROM avg_distance_per_team
JOIN matches_detailed ON avg_distance_per_team.match_id = matches_detailed.match_id
ORDER BY 
    match_id,
    rank;
-- 7 of 9 teams that covered more distance than their opponent actually won their match.

