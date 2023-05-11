/*
SELECT * FROM vw_options ORDER BY name LIMIT 100;
*/
DROP VIEW IF EXISTS vw_options;

CREATE VIEW vw_options
AS 
SELECT
    options.option_id id,
    options.option_name name,
    options.option_value value
FROM
    wp_options options;
