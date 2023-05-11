/*
SELECT * FROM vw_products ORDER BY name LIMIT 100;
SELECT * FROM vw_products WHERE status = 'publish' ORDER BY name LIMIT 100;
SELECT * FROM vw_products WHERE status = 'publish' AND regular_price = 1 ORDER BY name LIMIT 100;
SELECT * FROM vw_products WHERE status = 'publish' AND stock_status = 'instock' ORDER BY name LIMIT 100;

-- stock

SET @start_date = CAST('2000-01-01' AS datetime);
SET @start_date = CAST('2099-12-31' AS datetime);

SELECT
    id,
    name,
    COALESCE(query_1.quantity, 0) stock_orders,
    COALESCE(stock, 0) stock_woocommerce
FROM
    vw_products
    LEFT JOIN
    (
        SELECT
            item_product_id product_id,
            SUM(item_quantity) quantity
        FROM vw_orders_items
        WHERE
            date BETWEEN @start_date AND @end_date
            AND status IN
            (
                'wc-pending',
                'wc-on-hold',
                'wc-failed',
                'wc-processing'
                -- 'wc-canceled',
                -- 'wc-completed',
                -- 'wc-refunded' 
            )
        GROUP BY product_id
    ) query_1 ON
        query_1.product_id = vw_products.id
ORDER BY
    vw_products.name;
*/
DROP VIEW IF EXISTS vw_products;

CREATE VIEW vw_products
AS 
SELECT
    products.id,
    products.post_title name, -- 1
    products.post_content description, -- 2
    products.post_excerpt short_description, -- 3
    CAST(products.post_date AS date) date_created,
    CAST(products.post_modified AS date) date_modified,
    products.post_type type,
    products.post_status status,
    --
    MAX( CASE WHEN products_1.meta_key = '_sku'                 AND products_1.post_id = products.id THEN LOWER(products_1.meta_value) END ) AS sku,
    MAX( CASE WHEN products_1.meta_key = '_manage_stock'        AND products_1.post_id = products.id THEN LOWER(products_1.meta_value) END ) AS is_manage_stock,
    MAX( CASE WHEN products_1.meta_key = '_stock_status'        AND products_1.post_id = products.id THEN LOWER(products_1.meta_value) END ) AS stock_status,
    MAX( CASE WHEN products_1.meta_key = '_stock'               AND products_1.post_id = products.id THEN products_1.meta_value END ) AS stock,
    MAX( CASE WHEN products_1.meta_key = '_price'               AND products_1.post_id = products.id THEN products_1.meta_value END ) AS price,
    MAX( CASE WHEN products_1.meta_key = '_regular_price'       AND products_1.post_id = products.id THEN products_1.meta_value END ) AS regular_price,
    MAX( CASE WHEN products_1.meta_key = '_sale_price'          AND products_1.post_id = products.id THEN products_1.meta_value END ) AS sale_price,
    MAX( CASE WHEN products_1.meta_key = '_thumbnail_id'           AND products_1.post_id = products.id THEN products_1.meta_value END ) AS thumbnail_id,
    MAX( CASE WHEN products_1.meta_key = '_wp_attached_file'    AND products_1.post_id = products.id THEN products_1.meta_value END ) AS wp_attached_file
FROM
    wp_posts products
    LEFT JOIN wp_postmeta products_1 ON
        products_1.post_id = products.id
WHERE
    products.post_type IN
    (
        'product',
        'product_variation'
    )
GROUP BY
    products.id;
    
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
