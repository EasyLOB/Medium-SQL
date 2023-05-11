/*
SELECT * FROM vw_orders_items ORDER BY id LIMIT 100;
*/
DROP VIEW IF EXISTS vw_orders_items;

CREATE VIEW vw_orders_items
AS 
SELECT
    orders.id,
    orders.post_date date,
    orders.post_status status,
    --
    MAX( CASE WHEN orders_1.meta_key = '_customer_user'         AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS customer_id,
    MAX( CASE WHEN orders_1.meta_key = '_payment_method'         AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS payment_id,
    MAX( CASE WHEN orders_1.meta_key = '_order_stock_reduced'    AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS is_stock_reduced,
    MAX( CASE WHEN orders_1.meta_key = '_order_shipping_tax'     AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS shipping_tax,
    MAX( CASE WHEN orders_1.meta_key = '_order_shipping'         AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS shipping,
    MAX( CASE WHEN orders_1.meta_key = '_order_tax'             AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS total_tax,
    MAX( CASE WHEN orders_1.meta_key = '_order_total'             AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS total,
    --
    items_1.order_item_id item_id,
    --
    MAX( CASE WHEN items_2.meta_key = '_product_id'         AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS item_product_id,
    MAX( CASE WHEN items_2.meta_key = '_variation_id'         AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS item_variation_id,
    MAX( CASE WHEN items_2.meta_key = '_qty'                 AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS item_quantity,
    MAX( CASE WHEN items_2.meta_key = '_line_subtotal_tax'     AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS item_subtotal_tax,
    MAX( CASE WHEN items_2.meta_key = '_line_subtotal'         AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS item_subtotal,
    MAX( CASE WHEN items_2.meta_key = '_line_tax'             AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS item_tax,
    MAX( CASE WHEN items_2.meta_key = '_tax_class'             AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS item_tax_class,
    MAX( CASE WHEN items_2.meta_key = '_line_total'         AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS item_total    
FROM
    wp_posts orders
    LEFT JOIN wp_postmeta orders_1 ON
        orders_1.post_id = orders.id
    --
    LEFT JOIN wp_woocommerce_order_items items_1 ON
        items_1.order_id = orders.id
        AND order_item_type = 'line_item'
    LEFT JOIN wp_woocommerce_order_itemmeta items_2 ON
        items_2.order_item_id = items_1.order_item_id
WHERE
    orders.post_type = 'shop_order'
GROUP BY
    orders.id,
    items_1.order_item_id;
