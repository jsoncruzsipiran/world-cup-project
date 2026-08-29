/* LOAD venues.csv INTO venues */
-- Terminal: \copy venues FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 16

/* LOAD tournament_stages.csv INTO tournament_stages */
-- Terminal: \copy tournament_stages FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 7

/* LOAD teams.csv INTO teams */
-- Terminal: \copy teams FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 48

/* LOAD squads_and_players.csv INTO squads_and_players */
-- Terminal: \copy squads_and_players FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 1248

/* LOAD referees.csv INTO referees */
-- Terminal: \copy referees FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 28

/* LOAD player_stats.csv INTO player_stats */
-- Terminal: \copy player_stats FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 1248

/* LOAD matches.csv INTO matches */
-- Terminal: \copy matches(match_id,date,kickoff_time_utc,stage_id,venue_id,home_team_id,away_team_id,home_score,away_score,home_penalty_score,away_penalty_score,status,result_type,home_xg,away_xg,referee_id,player_of_the_match_id) FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 104

/* LOAD matches_detailed.csv INTO matches_detailed */
-- Terminal: \copy matches_detailed FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- COPY 104

/* LOAD match_team_stats.csv INTO match_team_stats */
-- Terminal: \copy match_team_stats FROM '...' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 208

/* LOAD match_lineups.csv INTO match_lineups */
-- Terminal: \copy match_lineups FROM '/Users/jasoncruzsipiran/world-cup-project/data/match_lineups.csv' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 5408

/* LOAD match_events.csv INTO match_events */
-- Terminal: \copy match_events FROM '/Users/jasoncruzsipiran/world-cup-project/data/match_events.csv' WITH(FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
-- Response: COPY 601