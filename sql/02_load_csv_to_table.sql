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