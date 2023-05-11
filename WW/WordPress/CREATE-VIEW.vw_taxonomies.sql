/*
SELECT * FROM vw_taxonomies ORDER BY taxonomy LIMIT 100;
SELECT * FROM vw_taxonomies_terms ORDER BY taxonomy, term_name LIMIT 100;
*/
DROP VIEW IF EXISTS vw_taxonomies;

CREATE VIEW vw_taxonomies
AS 
SELECT DISTINCT
    taxonomies.taxonomy
FROM
    wp_term_taxonomy taxonomies;

DROP VIEW IF EXISTS vw_taxonomies_terms;

CREATE VIEW vw_taxonomies_terms
AS 
SELECT DISTINCT
    taxonomies.taxonomy,
    taxonomies_1.term_id term_id,
    taxonomies_1.name term_name
FROM
    wp_term_taxonomy taxonomies
    INNER JOIN wp_terms taxonomies_1 ON
        taxonomies_1.term_id = taxonomies.term_id;
