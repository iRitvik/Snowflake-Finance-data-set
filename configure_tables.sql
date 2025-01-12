-- 8. Creating table for credit card data
CREATE OR REPLACE TABLE cards_data (
    id INT,                      -- Unique identifier for each record
    client_id INT,               -- Foreign key linking to users_data
    card_brand VARCHAR(50),      -- Card issuer/brand name
    card_type VARCHAR(50),       -- Type of card (credit, debit, etc.)
    card_number VARCHAR(20),     -- Card number
    expires DATE,                -- Card expiration date
    cvv VARCHAR(4),              -- Card security code
    has_chip BOOLEAN,            -- Whether card has EMV chip
    num_cards_issued INT,        -- Number of cards issued to client
    credit_limit DECIMAL(10, 2), -- Card credit limit
    acct_open_date DATE,         -- Account opening date
    year_pin_last_changed INT,   -- Year of last PIN change
    card_on_dark_web BOOLEAN     -- Flag for compromised cards
);

-- 9. Creating table for user demographic and financial data
CREATE OR REPLACE TABLE users_data (
    id INT,                          -- Unique identifier for each user
    current_age INT,                 -- Current age of user
    retirement_age INT,              -- Planned retirement age
    birth_year INT,                  -- Year of birth
    birth_month INT,                 -- Month of birth
    gender VARCHAR(20),              -- User's gender
    address VARCHAR(255),            -- User's address
    latitude DECIMAL(9, 6),          -- Address latitude
    longitude DECIMAL(9, 6),         -- Address longitude
    per_capita_income DECIMAL(10, 2),-- Income per capita for area
    yearly_income DECIMAL(10, 2),    -- User's annual income
    total_debt DECIMAL(10, 2),       -- Total user debt
    credit_score INT,                -- User's credit score
    num_credit_cards INT             -- Total number of credit cards
);

-- 10. Setting up permissions for stage access
GRANT READ ON STAGE my_finance_db.finance_schema.finance_stage TO ROLE data_engineer;
GRANT READ ON STAGE my_finance_db.finance_schema.finance_stage TO ROLE data_analyst;
GRANT WRITE ON STAGE my_finance_db.finance_schema.finance_stage TO ROLE data_engineer;

