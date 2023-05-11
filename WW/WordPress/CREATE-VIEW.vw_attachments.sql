/*
SELECT * FROM vw_attachments ORDER BY guid LIMIT 100;
*/
DROP VIEW IF EXISTS vw_attachments;

CREATE VIEW vw_attachments
AS 
SELECT
    attachments.id id,
    attachments.guid,
    attachments.post_mime_type
FROM
    wp_posts attachments
WHERE
    post_type = 'attachment';
