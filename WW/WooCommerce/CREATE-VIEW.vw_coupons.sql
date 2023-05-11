/*
SELECT * FROM vw_coupons ORDER BY id LIMIT 100;
*/
DROP VIEW IF EXISTS vw_coupons;

CREATE VIEW vw_coupons
AS 
SELECT
    coupons.id, 
    coupons.post_title coupon, 
    coupons.post_excerpt description, 
    CAST(coupons.post_date AS date) date_created,
    CAST(coupons.post_modified AS date) date_modified,
    coupons.post_type type,
    coupons.post_status status,
    --
    MAX( CASE WHEN coupons_1.meta_key = 'coupon_amount'                 AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS coupon_amount,
    MAX( CASE WHEN coupons_1.meta_key = 'customer_email'                AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS customer_email,
    MAX( CASE WHEN coupons_1.meta_key = 'date_expires'                  AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS date_expires,
    MAX( CASE WHEN coupons_1.meta_key = 'discount_type'                 AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS discount_type,
    MAX( CASE WHEN coupons_1.meta_key = 'exclude_sale_items'            AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS exclude_sale_items,
    MAX( CASE WHEN coupons_1.meta_key = 'exclude_product_ids'           AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS exclude_product_ids, 
    MAX( CASE WHEN coupons_1.meta_key = 'exclude_product_categories'    AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS exclude_product_categories,
    MAX( CASE WHEN coupons_1.meta_key = 'free_shipping'                 AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS free_shipping,
    MAX( CASE WHEN coupons_1.meta_key = 'individual_use'                AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS individual_use,
    MAX( CASE WHEN coupons_1.meta_key = 'minimum_amount'                AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS minimum_amount,
    MAX( CASE WHEN coupons_1.meta_key = 'maximum_amount'                AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS maximum_amount,
    MAX( CASE WHEN coupons_1.meta_key = 'product_categories'            AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS product_categories,
    MAX( CASE WHEN coupons_1.meta_key = 'product_ids'                   AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS product_ids,
    MAX( CASE WHEN coupons_1.meta_key = 'usage_count'                   AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS total_used,
    MAX( CASE WHEN coupons_1.meta_key = 'usage_limit'                   AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS usage_limit, 
    MAX( CASE WHEN coupons_1.meta_key = 'usage_limit_per_user'          AND coupons.id = coupons_1.post_id THEN coupons_1.meta_value END) AS usage_limit_per_user
FROM
    wp_posts AS coupons
    INNER JOIN wp_postmeta AS coupons_1 ON
        coupons_1.post_id = coupons.id
WHERE
    coupons.post_type = 'shop_coupon'
GROUP BY
    coupons.id 
ORDER BY
    coupons.id ASC;
