
-- WooCommerce HPOS

/*
SELECT * FROM vw_orders ORDER BY id;

SELECT DISTINCT meta_key FROM wp_wc_orders_meta ORDER BY 1;
*/

DROP VIEW IF EXISTS vw_orders;

CREATE VIEW vw_orders
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
	MAX( CASE WHEN orders_1.meta_key = '_dokan_vendor_id' 		AND orders_1.order_id = orders.id THEN orders_1.meta_value END ) AS meta_dokan_vendor_id
FROM
	wp_wc_orders orders
    LEFT JOIN wp_wc_orders_meta orders_1 ON
		orders_1.order_id = orders.id
GROUP BY
	orders.id;
