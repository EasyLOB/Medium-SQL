
/*
wp_posts
    wp_postmeta
    wp_term_relationships
        wp_term_taxonomy
            wp_term
*/

-- CLEAN posts metadata
SELECT
    CONCAT('DELETE FROM wp_postmeta WHERE meta_id = ', wp_postmeta.meta_id, ';') AS sqldelete,
    wp_postmeta.post_id,
    wp_postmeta.meta_key,
    wp_postmeta.meta_value,
    wp_posts.id,
    wp_posts.post_title
FROM
    wp_postmeta
    LEFT JOIN wp_posts ON
        wp_posts.id = wp_postmeta.post_id
WHERE wp_posts.id IS NULL -- DELETE
-- WHERE wp_posts.id IS NOT NULL -- OK
ORDER BY wp_postmeta.post_id;

-- CLEAN posts taxonomy ( wp_term_relationships ) 
SELECT
    CONCAT('DELETE FROM wp_term_relationships WHERE object_id = ', taxonomy_1.object_id, ';') AS sqldelete,
    taxonomy_1.object_id,
    posts.id,
    posts.post_title
FROM
    wp_term_relationships taxonomy_1
    LEFT JOIN wp_posts posts ON
        posts.id = taxonomy_1.object_id
WHERE posts.id IS NULL -- DELETE
-- WHERE posts.id IS NOT NULL -- OK
ORDER BY taxonomy_1.object_id;

-- CLEAN posts taxonomy ( wp_term_taxonomy ) 
SELECT
    CONCAT('DELETE FROM wp_term_taxonomy WHERE term_taxonomy_id = ', taxonomy_2.term_taxonomy_id, ';') AS sqldelete,
    taxonomy_2.term_taxonomy_id,
    taxonomy_2.term_id,
    taxonomy_2.taxonomy,
    taxonomy_1.object_id,
    taxonomy_3.name,
    posts.id,
    posts.post_title
FROM
    wp_term_taxonomy taxonomy_2
    LEFT JOIN wp_term_relationships taxonomy_1 ON
        -- [taxonomy_2.term_taxonomy_id] may be used in more than one [taxonomy_1.object_id] !!!
        taxonomy_1.term_taxonomy_id = taxonomy_2.term_taxonomy_id
    LEFT JOIN wp_terms taxonomy_3 ON
        taxonomy_3.term_id = taxonomy_2.term_id
    LEFT JOIN wp_posts posts ON
        posts.id = taxonomy_1.object_id        
WHERE taxonomy_1.object_id IS NULL -- DELETE
-- WHERE taxonomy_1.object_id IS NOT NULL -- OK
ORDER BY taxonomy_2.term_taxonomy_id;

/*
-- [taxonomy_2.term_taxonomy_id] may be used in more than one [taxonomy_1.object_id] !!!

SELECT
    taxonomy_1.object_id,
    taxonomy_2.term_taxonomy_id,
    taxonomy_2.term_id,
    taxonomy_2.taxonomy,
    taxonomy_3.name,
    posts.id,
    posts.post_title
FROM
    wp_term_relationships taxonomy_1
    INNER JOIN wp_term_taxonomy taxonomy_2 ON
        taxonomy_2.term_taxonomy_id = taxonomy_1.term_taxonomy_id 
    LEFT JOIN wp_terms taxonomy_3 ON
        taxonomy_3.term_id = taxonomy_2.term_id
    LEFT JOIN wp_posts posts ON
        posts.id = taxonomy_1.object_id
WHERE posts.id IS NULL
-- WHERE posts.id IS NOT NULL
ORDER BY posts.id;
*/
