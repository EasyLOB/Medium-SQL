
/*
wp_users
    wp_usermeta
    wp_comments
        wp_commentmeta
*/

-- CLEAN users metadata
SELECT
    CONCAT('DELETE FROM wp_usermeta WHERE umeta_id = ', wp_usermeta.umeta_id, ';') AS sqldelete,
    wp_usermeta.umeta_id,
    wp_usermeta.meta_key,
    wp_usermeta.meta_value,
    wp_usermeta.user_id,
    wp_users.id,
    wp_users.user_email
FROM
    wp_usermeta
    LEFT JOIN wp_users ON
        wp_users.id = wp_usermeta.user_id
WHERE wp_usermeta.user_id <> 0 AND wp_users.id IS NULL -- DELETE
-- WHERE wp_users.id IS NOT NULL -- OK
ORDER BY wp_usermeta.user_id;

-- CLEAN users comments
SELECT
    CONCAT('DELETE FROM wp_comments WHERE comment_ID = ', wp_comments.comment_ID, ';') AS sqldelete,
    wp_comments.comment_ID,
    wp_comments.user_id,
    wp_users.id,
    wp_users.user_email
FROM
    wp_comments
    LEFT JOIN wp_users ON
        wp_users.id = wp_comments.user_id
WHERE wp_comments.user_id <> 0 AND wp_users.id IS NULL -- DELETE
-- WHERE wp_users.id IS NOT NULL -- OK
ORDER BY wp_comments.user_id;
