-- 13. Creating a restricted view for analysts
CREATE VIEW my_finance_db.finance_schema.cards_data_view AS
SELECT client_id, card_brand, card_type, credit_limit
FROM my_finance_db.finance_schema.cards_data;

-- 14. Setting up role permissions
GRANT USAGE ON DATABASE my_finance_db TO ROLE data_analyst;
GRANT USAGE ON SCHEMA finance_schema TO ROLE data_analyst;
GRANT SELECT ON FUTURE TABLES IN SCHEMA my_finance_db.finance_schema TO ROLE data_analyst;
GRANT USAGE ON WAREHOUSE MY_WAREHOUSE TO ROLE data_analyst;
GRANT USAGE ON WAREHOUSE MY_WAREHOUSE TO ROLE data_engineer;

-- 15. Displaying system information
SHOW ROLES;
SHOW USERS;
SHOW GRANTS TO ROLE data_analyst;

-- 16. Data Archiving Implementation
-- Creating archive table for historical data
CREATE OR REPLACE TABLE my_finance_db.finance_schema.cards_data_archive AS
SELECT * 
FROM my_finance_db.finance_schema.cards_data
WHERE acct_open_date < '2002-01-01';

-- Moving old data to archive and removing from main table
DELETE FROM my_finance_db.finance_schema.cards_data
WHERE acct_open_date < '2002-01-01';

-- Time travel query example for archived data
SELECT *
FROM my_finance_db.finance_schema.cards_data_archive
BEFORE (TIMESTAMP => '2025-01-10 13:02:00');

-- 17. Setting up Data Sharing
CREATE SHARE finance_data_share;
GRANT USAGE ON DATABASE MY_FINANCE_DB TO SHARE finance_data_share;
GRANT SELECT ON TABLE my_finance_db.finance_schema.cards_data TO SHARE finance_data_share;
GRANT SELECT ON TABLE my_finance_db.finance_schema.users_data TO SHARE finance_data_share;

-- 18. Performance Optimization
-- Clustering table for improved query performance
ALTER TABLE my_finance_db.finance_schema.cards_data
CLUSTER BY (client_id);

-- 19. Creating Materialized View for analytics
CREATE MATERIALIZED VIEW my_finance_db.finance_schema.cards_data_mv AS
SELECT client_id, card_brand, SUM(amount) AS total_spent
FROM my_finance_db.finance_schema.transactions_data
GROUP BY client_id, card_brand;