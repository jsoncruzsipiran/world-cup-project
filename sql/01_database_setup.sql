-- CREATE A TABLE COMPATIBLE WITH THE FIELDS OF THE matches.csv DATA
CREATE TABLE world_cup_2026_matches (
    round TEXT,
    game_week INT,
    day_of_week VARCHAR(3),
    date DATE,
    start_time TIMESTAMP,
    home_team TEXT,
    away_team TEXT,
    score TEXT,
    home_score INT,
    away_score INT,
    attendance TEXT,
    venue TEXT,
    referee TEXT,
    home_formation TEXT,
    away_formation TEXT,
    home_manager TEXT,
    away_manager TEXT,
    home_captain TEXT,
    away_captain TEXT,
    home_possession INT,
    away_possession INT,
    home_sot INT,
    away_sot INT,
    home_total_shots INT,
    away_total_shots INT,
    home_saves INT,
    away_saves INT,
    home_cards_yellow INT,
    away_cards_yellow INT,
    home_cards_red INT,
    away_cards_red INT,
    home_fouls INT,
    away_fouls INT,
    home_corners INT,
    away_corners INT,
    home_crosses INT,
    away_crosses INT,
    home_interceptions INT,
    away_interceptions INT,
    home_offsides INT,
    away_offsides INT,
    notes TEXT DEFAULT NULL
);

-- ALLOW PERMISSIONS TO LOAD DATA FOR USER
ALTER TABLE
    world_cup_2026_matches
OWNER to postgres;

-- CHANGE COLUMN TYPE FOR start_time TO TIME
ALTER TABLE
    world_cup_2026_matches
ALTER COLUMN  
    start_time
TYPE TIME;

-- CHANGE COLUMN TYPE FOR home_score TO NUMERIC
ALTER TABLE
    world_cup_2026_matches
ALTER COLUMN home_score TYPE NUMERIC;

-- CHANGE COLUMN TYPE FOR away_score TO NUMERIC
ALTER TABLE
    world_cup_2026_matches
ALTER COLUMN away_score TYPE NUMERIC;