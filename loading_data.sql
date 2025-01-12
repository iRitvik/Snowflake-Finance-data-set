-- 11. Creating CSV file format specification
CREATE OR REPLACE FILE FORMAT my_csv_format
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    DATE_FORMAT = 'MM/YYYY';

-- 12. Loading data from staged files into tables
COPY INTO my_finance_db.finance_schema.cards_data
FROM @my_finance_db.finance_schema.finance_stage/cleaned_cards_data.csv
FILE_FORMAT = my_csv_format;

COPY INTO my_finance_db.finance_schema.users_data
FROM @my_finance_db.finance_schema.finance_stage/cleaned_users_data.csv
FILE_FORMAT = my_csv_format;

