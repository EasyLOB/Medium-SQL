-- users
-- posts
-- attachments
-- taxonomy
-- TRASH
    
-- users

SELECT customers.* FROM wp_users customers ORDER BY customers.user_login;

SELECT
    customers.user_login,
    customers_1.*
FROM
    wp_users customers
    LEFT JOIN wp_usermeta customers_1 ON
        customers_1.user_id = customers.id
ORDER BY
    customers.user_login,
    customers_1.meta_key;

-- posts

SELECT * FROM wp_posts ORDER BY id LIMIT 100;
SELECT post_type,wp_posts.* FROM wp_posts ORDER BY id LIMIT 100;
SELECT post_type,COUNT(*) FROM wp_posts GROUP BY post_type ORDER BY 1;
SELECT DISTINCT post_type FROM wp_posts ORDER BY 1;
/*
attachment
custom_css
nav_menu_item
page
post
product
wp_global_styles
wpforms
*/

SELECT DISTINCT meta_key FROM wp_postmeta ORDER BY 1;
/*
_astra_sites_enable_for_batch
_astra_sites_image_hash
_astra_sites_imported_post
_astra_sites_imported_wp_forms
_backorders
_default_attributes
_downloadable
_dp_has_rewrite_republish_copy
_elementor_source_image_hash
_manage_stock
_menu_item_classes
_menu_item_object
_menu_item_object_id
_menu_item_type
_price
_product_attributes
_product_version
_regular_price
_sale_price
_sold_individually
_stock
_stock_status
_tax_status
_thumbnail_id
_uabb_converted
_uag_css_file_name
_uag_page_assets
_virtual
_wp_attached_file
_wp_attachment_metadata
_wp_old_date
_wp_old_slug
_wp_page_template
_wxr_import_term
_wxr_import_user_slug
_yoast_wpseo_content_score
_yoast_wpseo_estimated-reading-time-minutes
_yoast_wpseo_primary_product_cat
ast_ist_mapping
ast_self_id_48051
ast_self_id_48052
ast_self_id_48053
astra-main-page-id
dynamic_page
site-content-layout
site-post-title
site-sidebar-layout
skip_page
stick-header-meta
theme-transparent-header-meta
total_sales
wpforms_form_locations
*/

-- attachments

SELECT *
FROM wp_posts
WHERE post_type = 'attachment'
ORDER BY guid
LIMIT 100;

SELECT *
FROM wp_postmeta
WHERE
    meta_key IN
    (
       '_thumbnail_id'
    )
LIMIT 100;

-- taxonomy

SELECT * FROM wp_terms ORDER BY name LIMIT 100;

SELECT DISTINCT meta_key FROM wp_termmeta ORDER BY 1;
/*
_astra_sites_imported_term
order
product_count_product_cat
*/

SELECT * FROM wp_term_taxonomy ORDER BY 1 LIMIT 100;
SELECT DISTINCT taxonomy FROM wp_term_taxonomy ORDER BY 1;
/*
category
nav_menu
pa_color
pa_size
product_cat
product_type
product_visibility
*/
SELECT * 
FROM
    wp_term_taxonomy
    INNER JOIN wp_terms ON
        wp_terms.term_id = wp_term_taxonomy.term_id
WHERE taxonomy = 'product_cat'
ORDER BY wp_terms.name;

-- TRASH

-- TRASH comment metadata
SELECT * FROM wp_commentmeta WHERE comment_id NOT IN (SELECT comment_ID from wp_comments);

-- TRASH post metadata
SELECT * FROM wp_postmeta WHERE post_id NOT IN (SELECT id from wp_posts);

-- TRASH term metadata
SELECT * FROM wp_termmeta WHERE term_id NOT IN (SELECT term_id from wp_terms);

-- TRASH user metadata
SELECT * FROM wp_usermeta WHERE user_id NOT IN (SELECT id from wp_users);
