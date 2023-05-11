/*
SELECT * FROM vw_brands ORDER BY name LIMIT 100;
*/
DROP VIEW IF EXISTS vw_brands;

CREATE VIEW vw_brands
AS 
SELECT
    brands.term_id id,
    brands.name,
    --
    MAX( CASE WHEN brands_2.meta_key = 'ecommerce_sync' AND brands_2.term_id = brands.term_id THEN LOWER(brands_2.meta_value) END ) AS ecommerce_sync
FROM
    wp_terms brands
    INNER JOIN wp_term_taxonomy brands_1 ON
        brands_1.term_id = brands.term_id
        AND brands_1.taxonomy = 'product_brand'
    LEFT JOIN wp_termmeta brands_2 ON
        brands_2.term_id = brands.term_id
GROUP BY
    brands.term_id;
