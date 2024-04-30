
-- WooCommerce HPOS

/*
SELECT * FROM vw_orders_items ORDER BY id;
*/

DROP VIEW IF EXISTS vw_orders_items;

CREATE VIEW vw_orders_items
AS 
SELECT
	orders.id,
    orders.date_updated_gmt date,
    orders.status status,
    --
	orders.customer_id AS customer_id,
	orders.payment_method AS payment_id,
	CAST(0 AS float) AS shipping_tax,
    CAST(0 AS float) AS shipping,
	orders.tax_amount AS total_tax,
	orders.total_amount AS total,    
    --
	MAX( CASE WHEN orders_1.meta_key = '_dokan_vendor_id' 		AND orders_1.order_id = orders.id THEN orders_1.meta_value END ) AS meta_dokan_vendor_id,
    --
	items_3.order_item_id item_id,
    items_3.product_id AS item_product_id,
	items_3.variation_id AS item_variation_id,
	items_3.product_qty AS item_quantity,
	items_3.product_net_revenue AS item_subtotal_tax,
	CAST(0 AS float) AS item_subtotal,
	items_3.tax_amount AS item_tax,
	'' AS item_tax_class,
	items_3.product_gross_revenue AS item_total,
    --
    items_1.order_item_id,
    MAX( CASE WHEN items_2.meta_key = '_product_id' 	    AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS meta_item_product_id,
	MAX( CASE WHEN items_2.meta_key = '_variation_id' 	    AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS meta_item_variation_id,
	MAX( CASE WHEN items_2.meta_key = '_qty' 				AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS meta_item_quantity,
	MAX( CASE WHEN items_2.meta_key = '_line_subtotal_tax' 	AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS meta_item_subtotal_tax,
	MAX( CASE WHEN items_2.meta_key = '_line_subtotal' 		AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS meta_item_subtotal,
	MAX( CASE WHEN items_2.meta_key = '_line_tax' 			AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS meta_item_tax,
	MAX( CASE WHEN items_2.meta_key = '_tax_class' 			AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS meta_item_tax_class,
	MAX( CASE WHEN items_2.meta_key = '_line_total' 		AND items_2.order_item_id = items_1.order_item_id THEN items_2.meta_value END ) AS meta_item_total
FROM
	wp_wc_orders orders
    LEFT JOIN wp_wc_orders_meta orders_1 ON
		orders_1.order_id = orders.id
	--
    LEFT JOIN wp_woocommerce_order_items items_1 ON
		items_1.order_id = orders.id
        AND order_item_type = 'line_item'
    LEFT JOIN wp_woocommerce_order_itemmeta items_2 ON
		items_2.order_item_id = items_1.order_item_id
	--
    LEFT JOIN wp_wc_order_product_lookup items_3 ON
	     items_3.order_id = orders.id
         AND items_3.order_item_id = items_1.order_item_id
GROUP BY
	orders.id,
    items_1.order_item_id;
