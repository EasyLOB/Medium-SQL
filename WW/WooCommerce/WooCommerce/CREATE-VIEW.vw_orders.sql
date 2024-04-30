
-- WooCommerce

/*
SELECT * FROM vw_orders ORDER BY id;
*/

DROP VIEW IF EXISTS vw_orders;

CREATE VIEW vw_orders
AS 
SELECT
	orders.id,
    orders.post_date date,
    orders.post_status status,
    --
	MAX( CASE WHEN orders_1.meta_key = '_customer_user' 		AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS customer_id,
	MAX( CASE WHEN orders_1.meta_key = '_payment_method' 		AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS payment_id,
	MAX( CASE WHEN orders_1.meta_key = '_order_stock_reduced'	AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS is_stock_reduced,
	MAX( CASE WHEN orders_1.meta_key = '_order_shipping_tax' 	AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS shipping_tax,
    MAX( CASE WHEN orders_1.meta_key = '_order_shipping'     	AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS shipping,
	MAX( CASE WHEN orders_1.meta_key = '_order_tax' 			AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS total_tax,
	MAX( CASE WHEN orders_1.meta_key = '_order_total' 			AND orders_1.post_id = orders.id THEN orders_1.meta_value END ) AS total
FROM
	wp_posts orders
    LEFT JOIN wp_postmeta orders_1 ON
		orders_1.post_id = orders.id
WHERE
	orders.post_type = 'shop_order'
GROUP BY
	orders.id;
