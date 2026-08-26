-- copy command to use; does not work.
COPY world_cup_2026_matches
FROM '...'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- must load data via terminal
-- in terminal use command: psql -h host -U user_name -d database_name