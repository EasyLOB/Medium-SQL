/*
SELECT * FROM vw_products_categories ORDER BY id, category_name LIMIT 100;
*/
DROP VIEW IF EXISTS vw_products_categories;

CREATE VIEW vw_products_categories
AS 
SELECT
    products.id,
    -- products.post_title product,
    -- products.post_excerpt description,
    -- CAST(products.post_date AS date) date_created,
    -- CAST(products.post_modified AS date) date_modified,
    -- products.post_type type,
    -- products.post_status status,
    --
    taxonomy_3.term_id category_id,
    taxonomy_3.name category_name
FROM
    wp_posts products
    LEFT JOIN wp_term_relationships taxonomy_1 ON
        taxonomy_1.object_id = products.id
    INNER JOIN wp_term_taxonomy taxonomy_2 ON
        taxonomy_2.term_taxonomy_id = taxonomy_1.term_taxonomy_id 
        AND taxonomy_2.taxonomy = 'product_cat'
    LEFT JOIN wp_terms taxonomy_3 ON
        taxonomy_3.term_id = taxonomy_2.term_id
WHERE
    products.post_type IN
    (
        'product',
        'product_variation'
    );
