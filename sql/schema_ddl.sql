@'
-- SQL DDL for bank_loan_data table 

CREATE TABLE bank_loan_data (
    id INT PRIMARY KEY,
    member_id INT NULL,
    loan_amount INT NULL,
    loan_status VARCHAR(50) NULL,
    emp_title VARCHAR(100) NULL,
    emp_length VARCHAR(30) NULL,
    grade VARCHAR(5) NULL,
    sub_grade VARCHAR(5) NULL,
    home_ownership VARCHAR(30) NULL,
    purpose VARCHAR(50) NULL,
    address_state VARCHAR(10) NULL,
    application_type VARCHAR(20) NULL,
    verification_status VARCHAR(50) NULL,
    issue_date DATE NULL,
    next_payment_date DATE NULL,
    last_payment_date DATE NULL,
    last_credit_pull_date DATE NULL,
    term VARCHAR(20) NULL,
    annual_income FLOAT NULL,
    dti FLOAT NULL,
    installment FLOAT NULL,
    int_rate FLOAT NULL,
    total_acc INT NULL,
    total_payment BIGINT NULL
    );

'@ | Out-File -Encoding utf8 sql\schema_ddl.sql