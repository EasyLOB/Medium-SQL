
/*
wp_comments
    wp_commentmeta
*/

-- CLEAN comments metadata
SELECT
    CONCAT('DELETE FROM wp_commentmeta WHERE meta_id = ', wp_commentmeta.meta_id, ';') AS sqldelete,
    wp_commentmeta.meta_id,
    wp_commentmeta.meta_key,
    wp_commentmeta.meta_value,
    wp_commentmeta.comment_id,
    wp_comments.comment_ID
FROM
    wp_commentmeta
    LEFT JOIN wp_comments ON
        wp_comments.comment_ID = wp_commentmeta.comment_id
WHERE wp_comments.comment_ID IS NULL -- DELETE
-- WHERE wp_comments.comment_ID IS NOT NULL -- OK
ORDER BY wp_commentmeta.meta_id;
