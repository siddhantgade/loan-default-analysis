# Data Dictionary — Bank Loan Dataset

This dictionary documents the schema of the bank_loan_data dataset.  
It includes column names, SQL-style data types, and business definitions.  
----------------------------------------------------------------------------------------------------------------
| Column                | Type        | Description                                                            |
|-----------------------|-------------|------------------------------------------------------------------------|
| id                    | BIGINT      | Unique identifier for each loan record.                                |
| member_id             | BIGINT      | Unique identifier for the borrower.                                    |
| loan_amount           | INT         | Principal loan amount issued.                                          |
| loan_status           | VARCHAR(50) | Current status of the loan (e.g., Fully Paid, Charged Off, Current).   |
| emp_title             | VARCHAR(100)| Borrower’s job title (self-reported). May contain nulls or PII.        |
| emp_length            | VARCHAR(30) | Borrower’s years of employment (bucketed, e.g., < 1 year, 10+ years).  |
| grade                 | VARCHAR(5)  | Credit grade assigned by the lender (A–G).                             |
| sub_grade             | VARCHAR(5)  | More granular credit sub-grade (e.g., A1, B3, C5).                     |
| home_ownership        | VARCHAR(30) | Borrower’s home ownership status (e.g., RENT, OWN, MORTGAGE).          |
| purpose               | VARCHAR(50) | Stated purpose of the loan (e.g., debt consolidation, car, medical).   |
| address_state         | VARCHAR(10) | Two-letter state code of borrower’s address.                           |
| application_type      | VARCHAR(20) | Type of application — INDIVIDUAL or JOINT.                             |
| verification_status   | VARCHAR(50) | Status of income verification (e.g., Verified, Not Verified).          |
| issue_date            | DATE        | Date the loan was issued.                                              |
| next_payment_date     | DATE        | Scheduled date of the next loan payment.                               |
| last_payment_date     | DATE        | Date of the most recent payment made by the borrower.                  |
| last_credit_pull_date | DATE        | Date the lender last pulled the borrower’s credit report.              |
| term                  | VARCHAR(20) | Loan term in months (typically 36 or 60).                              |
| annual_income         | FLOAT       | Borrower’s self-reported annual income.                                |
| dti                   | FLOAT       | Debt-to-income ratio of the borrower.                                  |
| installment           | FLOAT       | Monthly installment due for the loan.                                  |
| int_rate              | FLOAT       | Annual interest rate of the loan (percentage).                         |
| total_acc             | INT         | Total number of borrowers’ credit accounts.                            |
| total_payment         | BIGINT      | Total payment made towards the loan (principal + interest).            |
----------------------------------------------------------------------------------------------------------------