
/*
wp_terms
    wp_termsmeta
*/

-- CLEAN terms metadata
SELECT
    CONCAT('DELETE FROM wp_termmeta WHERE meta_id = ', wp_termmeta.meta_id, ';') AS sqldelete,
    wp_termmeta.meta_id,
    wp_termmeta.meta_key,
    wp_termmeta.meta_value,
    wp_termmeta.term_id,
    wp_terms.term_ID
FROM
    wp_termmeta
    LEFT JOIN wp_terms ON
        wp_terms.term_ID = wp_termmeta.term_id
WHERE wp_terms.term_ID IS NULL -- DELETE
-- WHERE wp_terms.term_ID IS NOT NULL -- OK
ORDER BY wp_termmeta.meta_id;
