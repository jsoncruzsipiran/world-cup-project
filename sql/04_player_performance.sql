/* Find, create, and import data for individual player performance statistics based on reporting done by FIFA Training Centre */

-- Mexico v England | Mexico v Ecuador | Congo DR vs Uzbekistan | Czechia v Mexico | Colombia v Congo DR | Mexico v South Korea | Uzbekistan v Colombia | South Korea v Czechia | Mexico v South Africa
CREATE TABLE IF NOT EXISTS elevated_stadium_player_performances (
    match_id INT REFERENCES matches(match_id),
    player_id INT REFERENCES squads_and_players(player_id),
    player_name TEXT,
    team_name TEXT,
    passes_attempted INT,
    passes_completed INT,
    pass_completion_pct NUMERIC,
    switches_of_play INT,
    crosses_attempted INT,
    crosses_completed INT,
    ball_progressions INT,
    attempts_at_goal INT,
    goals INT,
    tackles_made_won TEXT,
    blocks INT,
    interceptions INT,
    duels_won_aerial INT,
    duels_won_physical INT,
    possession_contests_won INT,
    clearances INT,
    loose_ball_receptions INT,
    possession_regains INT,
    possession_interrupted INT,
    total_distance_m NUMERIC,
    top_speed_kmh NUMERIC,

    PRIMARY KEY (match_id, player_id)
);

ALTER TABLE elevated_stadium_player_performances
OWNER to postgres;

/* LOAD elevated_stadium_player_performances.csv to elevated_stadium_player_performances */
-- Terminal: \copy elevated_stadium_player_performances FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 284