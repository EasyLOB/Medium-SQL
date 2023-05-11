/*
SELECT * FROM vw_products_taxonomies ORDER BY product_id, taxonomy, term LIMIT 100;

SELECT
    vw_products.id,
    vw_products.sku,
    vw_products.name product,
    vw_products_taxonomies.taxonomy,
    vw_products_taxonomies.term
FROM
    vw_products
    INNER JOIN vw_products_taxonomies ON
        vw_products_taxonomies.product_id = vw_products.id
ORDER BY vw_products.id, vw_products_taxonomies.taxonomy, vw_products_taxonomies.term
LIMIT 100;

SELECT * FROM vw_products_taxonomies ORDER BY product_id, taxonomy, term LIMIT 100;

-- brands -> vw_product_brands

SELECT
    vw_products.id,
    vw_products.sku,
    vw_products.name,
    vw_products_taxonomies.term brand
FROM
    vw_products
    LEFT JOIN vw_products_taxonomies ON
        vw_products_taxonomies.product_id = vw_products.id
        AND vw_products_taxonomies.taxonomy = 'pwb-brand' -- Perfect Brands for WooCommerce
        -- AND vw_products_taxonomies.taxonomy = 'product-brand' -- WooCommerce Brands
ORDER BY vw_products.name, vw_products_taxonomies.term;

-- categories -> vw_product_categories

SELECT
    vw_products.id,
    vw_products.sku,
    vw_products.name,
    vw_products_taxonomies.term category
FROM
    vw_products
    LEFT JOIN vw_products_taxonomies ON
        vw_products_taxonomies.product_id = vw_products.id
        AND vw_products_taxonomies.taxonomy = 'product_cat'
ORDER BY vw_products.name, vw_products_taxonomies.term;

-- images -> vw_products_images

SELECT
    vw_products.id,
    vw_products.sku,
    vw_products.name,
    wp_postmeta.*
FROM
    vw_products
    LEFT JOIN wp_postmeta ON
        wp_postmeta.post_id = vw_products.id
        AND wp_postmeta.meta_key IN
        (
            '_product_image_gallery', -- Image Gallery
            '_thumbnail_id' -- Thumbnail
        )
ORDER BY vw_products.name, wp_postmeta.meta_key, wp_postmeta.meta_value;
*/
DROP VIEW IF EXISTS vw_products_taxonomies;

CREATE VIEW vw_products_taxonomies
AS 
SELECT
    products.id product_id,
    taxonomy_2.taxonomy,
    taxonomy_3.name term
FROM
    wp_posts products
    INNER JOIN wp_term_relationships taxonomy_1 ON
        taxonomy_1.object_id = products.id
    INNER JOIN wp_term_taxonomy taxonomy_2 ON
        taxonomy_2.term_taxonomy_id = taxonomy_1.term_taxonomy_id 
    INNER JOIN wp_terms taxonomy_3 ON
        taxonomy_3.term_id = taxonomy_2.term_id
WHERE
    products.post_type IN
    (
        'product',
        'product_variation'
    );
