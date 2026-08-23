-- copy command to use; does not work.
COPY raw_fifa_world_cup_2026_player_performance
FROM '...'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- must load data via terminal
-- in terminal use command: psql -h host -U user_name -d database_name