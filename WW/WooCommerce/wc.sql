
-- brands
-- categories
-- coupons
-- customers
-- orders
-- products

-- brands

-- WooCommerce Brands
SELECT * FROM wp_term_taxonomy WHERE taxonomy = 'product_brand' ORDER BY term_id;
-- Perfect Brands for WooCommerce
SELECT * FROM wp_term_taxonomy WHERE taxonomy = 'pwb-brand' ORDER BY term_id;

-- categories
    
-- coupons

SELECT
    coupons.*, 
    coupons_1.*
FROM
    wp_posts AS coupons
    INNER JOIN wp_postmeta AS coupons_1 ON
        coupons_1.post_id = coupons.id
WHERE
    coupons.post_type = 'shop_coupon'
    AND coupons.post_status = 'publish'
ORDER BY
    coupons.id ASC,
    coupons_1.meta_key ASC
LIMIT 100;

-- customers

SELECT
    customers.*,
    customers_1.*
FROM
    wp_users customers
    LEFT JOIN wp_usermeta customers_1 ON
        customers_1.user_id = customers.id
ORDER BY
    customers.id,
    customers_1.meta_key
LIMIT 100;

-- orders

SELECT
    orders.*,
    orders_1.*
FROM
    wp_posts orders
    LEFT JOIN wp_postmeta orders_1 ON
        orders_1.post_id = orders.id
WHERE orders.post_type = 'shop_order'
ORDER BY
    orders.id,
    orders_1.meta_key
LIMIT 100;

-- products

SELECT
    products.*,
    products_1.*
FROM
    wp_posts products
    LEFT JOIN wp_postmeta products_1 ON
        products_1.post_id = products.id
WHERE products.post_type = 'product'
ORDER BY 1;
