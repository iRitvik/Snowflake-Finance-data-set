# Finance Data Engineering Project

## Overview
This project implements a comprehensive financial data management system using Snowflake, focusing on credit card and user data management, security, and analytics. The system is designed to handle sensitive financial information with proper access controls and data governance.

## Features

### 🔐 Security and Access Control
- Role-based access control (RBAC) with separate roles for engineers and analysts
- Secure user management with dedicated permissions
- Restricted views for sensitive data
- Data masking for PII (Personally Identifiable Information)

### 📊 Data Management
- Credit card data storage and processing
- User demographic and financial information
- Historical data archiving
- Data sharing capabilities
- Time travel functionality for data recovery

### 🏗️ Infrastructure
- Auto-scaling warehouse configuration
- Optimized storage with clustering
- Internal staging area for data loading
- CSV file format specifications
- Materialized views for performance

### 📈 Analytics Support
- Predefined views for common analytics
- Aggregated data access
- Performance-optimized queries
- Historical data analysis capabilities

## Database Schema

### Cards Data Table
```sql
cards_data (
    id INT,
    client_id INT,
    card_brand VARCHAR(50),
    card_type VARCHAR(50),
    card_number VARCHAR(20),
    expires DATE,
    cvv VARCHAR(4),
    has_chip BOOLEAN,
    num_cards_issued INT,
    credit_limit DECIMAL(10, 2),
    acct_open_date DATE,
    year_pin_last_changed INT,
    card_on_dark_web BOOLEAN
)
```

### Users Data Table
```sql
users_data (
    id INT,
    current_age INT,
    retirement_age INT,
    birth_year INT,
    birth_month INT,
    gender VARCHAR(20),
    address VARCHAR(255),
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    per_capita_income DECIMAL(10, 2),
    yearly_income DECIMAL(10, 2),
    total_debt DECIMAL(10, 2),
    credit_score INT,
    num_credit_cards INT
)
```

## Setup and Configuration

### Prerequisites
- Snowflake account with ACCOUNTADMIN access
- Data loading source files (CSV format)
- Appropriate network access and security configurations

### Initial Setup Steps
1. Execute role and user creation scripts
2. Configure warehouse settings
3. Create database and schema
4. Set up staging area
5. Create and configure tables
6. Implement security measures
7. Load initial data

### Access Management
```sql
-- For Analysts
GRANT USAGE ON DATABASE my_finance_db TO ROLE data_analyst;
GRANT USAGE ON SCHEMA finance_schema TO ROLE data_analyst;
GRANT SELECT ON FUTURE TABLES IN SCHEMA my_finance_db.finance_schema TO ROLE data_analyst;

-- For Engineers
GRANT USAGE ON WAREHOUSE MY_WAREHOUSE TO ROLE data_engineer;
```

## Performance Optimization

### Clustering
Tables are clustered for optimal query performance:
```sql
ALTER TABLE my_finance_db.finance_schema.cards_data
CLUSTER BY (client_id);
```

### Materialized Views
Implemented for frequently accessed data patterns:
```sql
CREATE MATERIALIZED VIEW cards_data_mv AS
SELECT client_id, card_brand, SUM(amount) AS total_spent
FROM transactions_data
GROUP BY client_id, card_brand;
```

## Data Archiving
- Automated archiving for records older than 2002
- Time travel functionality for historical data access
- Separate archive tables for optimal storage management

## Data Sharing
- Secure data sharing implementation
- Granular control over shared data
- Support for cross-organization collaboration

## Best Practices
1. Always use appropriate roles for different operations
2. Regularly archive old data
3. Implement proper error handling
4. Monitor warehouse performance
5. Regular security audits
6. Backup critical data
7. Document all custom implementations

## Maintenance
- Regular monitoring of warehouse usage
- Periodic review of access permissions
- Storage optimization
- Performance tuning as needed

## Security Considerations
- All sensitive data is properly encrypted
- Access is strictly controlled through RBAC
- Regular security audits
- Compliance with financial data regulations

## Future Enhancements
- [ ] Implementation of real-time data processing
- [ ] Advanced analytics integration
- [ ] Machine learning model integration
- [ ] Enhanced reporting capabilities
- [ ] Automated data quality checks
- [ ] Extended archiving capabilities

## Contact
For questions or access requests, please contact your system administrator.
