-- DISPLAY OF TABLES
SELECT * FROM match_events;
SELECT * FROM match_lineups;
SELECT * FROM match_team_stats;
SELECT * FROM matches_detailed;
SELECT * FROM matches;
SELECT * FROM player_stats;
SELECT * FROM referees;
SELECT * FROM squads_and_players;
SELECT * FROM teams;
SELECT * FROM tournament_stages;
SELECT * FROM venues;


/* Did players, who come from countries that naturally have high elevations, perform better to other players during matches in highly-elevated stadiums? */

-- find matches played in high elevation stadiums
WITH matches_with_high_elevations AS (
    SELECT
        matches_detailed.match_id,
        matches_detailed.stadium_name,
        venues.elevation_meters,
        matches_detailed.home_team_name,
        matches_detailed.away_team_name,
        matches_detailed.home_score,
        matches_detailed.away_score,
        matches_detailed.home_xg,
        matches_detailed.away_xg
    FROM matches_detailed
    JOIN venues ON matches_detailed.stadium_name = venues.stadium_name
    WHERE elevation_meters >= 1200
),

-- find the names + teams for each match in the world cup
relevant_match_lineups AS (
    SELECT
        match_lineups.match_id,
        player_stats.player_name,
        teams.team_name
    FROM match_lineups
    JOIN player_stats ON match_lineups.player_id = player_stats.player_id
    JOIN teams ON match_lineups.team_id = teams.team_id
    WHERE match_lineups.minutes_played > 0
)

-- combine tables to find the players who've played matches in the most elevated stadiums at the 2026 world cup
SELECT
    relevant_match_lineups.*,
    matches_with_high_elevations.*
FROM relevant_match_lineups
JOIN matches_with_high_elevations ON relevant_match_lineups.match_id = matches_with_high_elevations.match_id
ORDER BY 
    relevant_match_lineups.match_id, 
    team_name;

/* DATA DISPLAYS LIST OF PLAYERS WHO'VE PARTICIPATED IN THESE MATCHES OF INTEREST */
/* MUST EXPLORE TO FIND INDIVIDUAL PLAYER PERFORMANCE STATISTICS */