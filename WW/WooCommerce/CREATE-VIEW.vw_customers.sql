/*
SELECT * FROM vw_customers LIMIT 100;

SET @StartDate = CAST('2021-01-01' AS datetime);
SET @EndDate = CAST('2021-12-31' AS datetime);
SELECT * FROM vw_customers WHERE date_created BETWEEN @StartDate AND @EndDate ORDER BY company_name;
*/
DROP VIEW IF EXISTS vw_customers;

CREATE VIEW vw_customers
AS 
SELECT
    customers.id,
    customers.user_login login,
    CAST(customers.user_registered As date) date_created,
    --    
    MAX( CASE WHEN customers_1.meta_key = 'pw_user_status'             AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS status,
    MAX( CASE WHEN customers_1.meta_key = 'wp_capabilities'            AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS type,
    MAX( CASE WHEN customers_1.meta_key = 'first_name'                 AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS first_name,
    MAX( CASE WHEN customers_1.meta_key = 'last_name'                  AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS last_name,
    MAX( CASE WHEN customers_1.meta_key = 'billing_company'            AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS company_name,
    MAX( CASE WHEN customers_1.meta_key = 'billing_cpf'                AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS cpf, -- Brazil
    MAX( CASE WHEN customers_1.meta_key = 'billing_cnpj'               AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS cnpj, -- Brazil
    MAX( CASE WHEN customers_1.meta_key = 'billing_state_registration' AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS state_registration,
    MAX( CASE WHEN customers_1.meta_key = 'billing_address_1'          AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS address1,
    MAX( CASE WHEN customers_1.meta_key = 'billing_address_2'          AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS address2,
    MAX( CASE WHEN customers_1.meta_key = 'billing_district'           AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS district,
    MAX( CASE WHEN customers_1.meta_key = 'billing_state'              AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS state,
    MAX( CASE WHEN customers_1.meta_key = 'billing_city'               AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS city,
    MAX( CASE WHEN customers_1.meta_key = 'billing_country'            AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS country,  
    MAX( CASE WHEN customers_1.meta_key = 'billing_postcode'           AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS postcode,   
    MAX( CASE WHEN customers_1.meta_key = 'billing_email'              AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS email,
    MAX( CASE WHEN customers_1.meta_key = 'billing_phone'              AND customers_1.user_id = customers.id THEN customers_1.meta_value END ) AS phone
FROM
    wp_users customers
    LEFT JOIN wp_usermeta customers_1 ON
        customers_1.user_id = customers.id
GROUP BY
    customers.id;
