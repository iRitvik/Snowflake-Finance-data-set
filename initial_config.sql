-- 1. Initial Role and User Setup
USE ROLE ACCOUNTADMIN;
DROP ROLE warehouse_admin;  -- Removing existing warehouse_admin role if it exists

-- 2. Creating roles for different access levels
CREATE ROLE data_engineer;
CREATE ROLE data_analyst;

-- 3. Creating users and assigning default roles
CREATE OR REPLACE USER ross PASSWORD='ross@1' DEFAULT_ROLE=data_analyst;
CREATE USER  joey PASSWORD='joey@1' DEFAULT_ROLE=data_engineer;

-- 4. Granting roles to users
GRANT ROLE data_analyst TO USER ross;
GRANT ROLE data_engineer TO USER joey;

-- 5. Creating a new warehouse with specified parameters
-- XSMALL size for cost efficiency
-- Auto-suspends after 5 minutes of inactivity
-- Auto-resumes when queries are submitted
CREATE WAREHOUSE my_warehouse
WITH WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE;

-- 6. Setting up database and schema
CREATE DATABASE my_finance_db;
CREATE SCHEMA finance_schema;

-- 7. Creating an internal stage for file storage
CREATE OR REPLACE STAGE my_finance_db.finance_schema.finance_stage;
USE SCHEMA MY_FINANCE_DB.FINANCE_SCHEMA;

