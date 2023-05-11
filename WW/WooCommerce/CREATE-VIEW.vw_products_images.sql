/*
SELECT * FROM vw_products_images ORDER BY id, image_type, image LIMIT 100;
*/
DROP VIEW IF EXISTS vw_products_images;

CREATE VIEW vw_products_images
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
    CASE
        WHEN meta_key = '_product_image_gallery' THEN 'gallery'
        WHEN meta_key = '_thumbnail_id' THEN 'thumbnail'
        ELSE '?'
    END image_type,
    wp_postmeta.meta_value image
FROM
    wp_posts products
    LEFT JOIN wp_postmeta ON
        wp_postmeta.post_id = products.id
        AND wp_postmeta.meta_key IN
        (
            '_product_image_gallery', -- Image Gallery
            '_thumbnail_id' -- Thumbnail
        )
WHERE
    products.post_type IN
    (
        'product',
        'product_variation'
    );
