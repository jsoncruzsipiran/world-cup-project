/* VENUES */
CREATE TABLE IF NOT EXISTS venues (
    venue_id INT PRIMARY KEY, -- unique identifier for the host stadium
    stadium_name TEXT, -- official commercial/tournament name of the stadium
    city TEXT, -- host city
    country VARCHAR(3), -- host country (USA, MEX, CAN)
    capacity INT, -- total seating capacity of the venue
    latitude NUMERIC, -- geographic latitude coordinate
    longitude NUMERIC, -- geographic longtiude coordinate
    elevation_meters INT -- stadium elevation in meters above sea level
);

/* TOURNAMENT STAGES */
CREATE TABLE IF NOT EXISTS tournament_stages (
    stage_id INT PRIMARY KEY, -- unique identifier for the tournament stage
    stage_name TEXT, -- name of the stage
    is_knockout BOOLEAN -- boolean flag indicating if the stage is single-elimination
);

/* TEAMS */
CREATE TABLE IF NOT EXISTS teams (
    team_id INT PRIMARY KEY, -- unique identifier for each national team
    team_name TEXT, -- official name of the country
    fifa_code VARCHAR(3), -- 3-letter FIFA country code
    group_letter VARCHAR(1), -- group letter (A - L) assigned for the group stage
    confederation TEXT, -- football confederation
    fifa_ranking_pre_tournament INT, -- official FIFA ranking of the country prior to the tournament start
    elo_rating INT, -- live elo rating of the team, indicating recent strength
    manager_name TEXT -- name of the national team manager
);

/* SQUADS AND PLAYERS */
CREATE TABLE IF NOT EXISTS squads_and_players (
    player_id INT PRIMARY KEY, -- unique identifier for each player
    team_id INT REFERENCES teams(team_id), -- foreign key reference to the player's national team in teams
    player_name TEXT, -- full name of the player
    position VARCHAR(3), -- playing position
    club_team TEXT, -- club team where the player currently plays
    market_value_euros INT, -- estimated market value in euros
    caps INT, -- total international caps for the national team
    date_of_birth DATE, -- player's date of birth in ISO format
    height_cm INT, -- player's height in centimeters
    goals INT -- total international goals scored by the player for their country
);

/* REFEREES */
CREATE TABLE IF NOT EXISTS referees (
    referee_id INT PRIMARY KEY, -- unique identifier for the referee
    name TEXT, -- full name of the referee
    country TEXT, -- home country of the referee
    avg_cards_per_game NUMERIC -- historical average number of cards shown per match
);

/* PLAYER STATS */
CREATE TABLE IF NOT EXISTS player_stats (
    player_id INT PRIMARY KEY, 
    player_name TEXT,
    team_id INT REFERENCES teams(team_id),
    position VARCHAR(3),
    matches_played INT,
    matches_started INT,
    minutes_played INT,
    goals INT,
    assists INT,
    shots INT,
    shots_on_target INT,
    yellow_cards INT,
    red_cards INT,
    penalty_goals INT,
    own_goals INT,
    clean_sheets INT,
    saves INT,
    goals_conceded INT,
    average_rating NUMERIC,
    data_source TEXT,
    last_verified DATE
);

/* MATCHES DETAILED */
CREATE TABLE IF NOT EXISTS matches_detailed (
    match_id INT PRIMARY KEY, -- unique identifier for the match
    date DATE, -- scheduled date of the match
    kickoff_time_utc TIMESTAMP, -- scheduled kickoff time in UTC
    stage_name TEXT, -- decoded, human-readable name of the tournament stage
    stadium_name TEXT, -- decoded, human-readable name of the stadium
    city TEXT, -- city where the match is played
    country VARCHAR(3), -- country where the match is played
    home_team_name TEXT, -- human-readable name of the home team
    home_fifa_code VARCHAR(3), -- FIFA country code of the home team
    away_team_name TEXT, -- human-readable name of the away team
    away_fifa_code VARCHAR(3), -- FIFA country code of the away team
    home_score INT, -- goals scored by the home team
    away_score INT, -- goals scored by the away team
    home_penalty_score INT,
    away_penalty_score INT,
    status TEXT, -- match status
    result_type TEXT,
    home_xg NUMERIC, -- expected goals for the home team
    away_xg NUMERIC, -- expected goals for the away team
    home_goalkeeper TEXT, 
    away_goalkeeper TEXT,
    player_of_the_match_name TEXT,
    referee_name TEXT -- full name of the match referee
);

ALTER TABLE matches_detailed
    ALTER COLUMN kickoff_time_utc TYPE TIME;

/* MATCHES */
CREATE TABLE IF NOT EXISTS matches (
    match_id INT PRIMARY KEY, -- unique identifier for the match
    date DATE, -- scheduled date of the match
    kickoff_time_utc TIMESTAMP, -- scheduled kickoff time in UTC
    stage_id INT REFERENCES tournament_stages(stage_id), -- foreign key reference to tournament stages
    venue_id INT REFERENCES venues(venue_id), -- foreign key reference to venues
    home_team_id INT REFERENCES teams(team_id), -- foreign key references to the home team
    away_team_id INT REFERENCES teams(team_id), -- foreign key references to the away team
    home_score INT, -- goals scored by the home team
    away_score INT, -- goals scored by the away team
    status TEXT, -- current status of the game
    home_xg INT, -- expected goals accumulated by the home team
    away_xg INT, -- expected goals accumulated by the away team
    referee_id INT REFERENCES referees(referee_id) -- foreign key reference to referees
);
ALTER TABLE matches
    ADD COLUMN home_penalty_score INT,
    ADD COLUMN away_penalty_score INT,
    ADD COLUMN result_type TEXT,
    ADD COLUMN player_of_the_match_id INT REFERENCES player_stats(player_id);

ALTER TABLE matches
    ALTER COLUMN
        kickoff_time_utc TYPE TIME;

ALTER TABLE matches
    ALTER COLUMN home_xg TYPE NUMERIC;

ALTER TABLE matches
    ALTER COLUMN away_xg TYPE NUMERIC;

/* MATCH TEAM STATS */ 
CREATE TABLE match_team_stats (
    match_id INT REFERENCES matches(match_id), -- foreign key referencing the match in matches
    team_id INT REFERENCES teams(team_id), -- foreign key referencing the team in teams
    possession_pct INT, -- possession percentage for the team during the match
    total_shots INT, -- total number of shot attempts
    shots_ont_target INT, -- shots on target
    corners INT, -- number of corner kicks taken
    fouls INT, -- number of fouls committed
    offsides INT, -- number of offsides called against the team
    saves INT, -- number of saves made by the team's goalkeeper
    player_of_the_match TEXT, -- the name of the player of the match
    data_source TEXT, -- sourced website
    last_updated DATE -- ISO date when the record was last verified/updated
);

/* MATCH LINEUPS */
CREATE TABLE IF NOT EXISTS match_lineups (
    lineup_id INT PRIMARY KEY,
    match_id INT REFERENCES matches(match_id),
    player_id INT REFERENCES squads_and_players(player_id),
    team_id INT REFERENCES teams(team_id),
    is_starting_xi BOOLEAN,
    tactical_position VARCHAR(3),
    minutes_played INT
);

/* MATCH EVENTS */
CREATE TABLE IF NOT EXISTS match_events (
    event_id INT PRIMARY KEY, -- unique identifier for the timeline event
    match_id INT REFERENCES matches(match_id), -- foreign key reference to matches
    minute INT, -- match minute when the event occurred 
    event_type TEXT, -- type of event
    team_id INT REFERENCES teams(team_id), -- foreign key reference to the team triggering the event
    player_id INT REFERENCES squads_and_players(player_id) -- foreign key reference to the player triggering the event
);