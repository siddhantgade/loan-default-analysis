use BankLoanDB;

select top 5 * from bank_loan_data

-- total loan applications
select count(id) AS total_loan_applications from bank_loan_data

-- MTD loan applications 
select count(id) AS MTD_total_loan_applications 
from bank_loan_data
where MONTH(issue_date) = 12 AND 
YEAR(issue_date) = 2021

-- Previous MTD loan applications 
select count(id) AS MTD_total_loan_applications 
from bank_loan_data
where MONTH(issue_date) = 11 AND 
YEAR(issue_date) = 2021

-- Total funded amount
select sum(loan_amount) AS MTD_total_funded_amount
from bank_loan_data
where MONTH(issue_date) = 12 AND 
YEAR(issue_date) = 2021

-- Total funded amount from previous month
select SUM(loan_amount) AS PMTD_total_funded_amount
from bank_loan_data
where month(issue_date) = 11 AND
YEAR(issue_date) = 2021

-- total amount received
select SUM(total_payment)
from bank_loan_data
where MONTH(issue_date) = 12 AND
year(issue_date) = 2021

-- total amount received from previous month
select SUM(total_payment)
from bank_loan_data
where MONTH(issue_date) = 11 AND
year(issue_date) = 2021

-- avg interest rate
select ROUND((sum(int_rate)/count(int_rate)),4) * 100 AS avg_interest_rate
from bank_loan_data

-- current month avg interest rate
SELECT AVG(int_rate) AS avg_interest_rate
FROM bank_loan_data
WHERE int_rate IS NOT NULL AND
	MONTH(issue_date) = MONTH((SELECT MAX(issue_date) FROM bank_loan_data))
	AND YEAR(issue_date)  = YEAR((SELECT MAX(issue_date) FROM bank_loan_data));

-- previous month avg interest rate
;WITH lm AS (
    -- Get the first day of the latest month in data
    SELECT DATEADD(month, DATEDIFF(month, 0, MAX(issue_date)), 0) AS cur_month_start
    FROM bank_loan_data
)
SELECT 
    (SELECT DATEADD(month, -1, cur_month_start) FROM lm) AS prev_month_start,
    (SELECT cur_month_start FROM lm) AS current_month_start,
    AVG(b.int_rate) AS prev_month_avg_interest_rate
FROM bank_loan_data b
CROSS JOIN lm
WHERE b.issue_date >= DATEADD(month, -1, lm.cur_month_start)
  AND b.issue_date <  lm.cur_month_start
  AND b.int_rate IS NOT NULL;

/*
DATEDIFF(month, 0, MAX(issue_date)) → counts how many whole months have elapsed between SQL Server’s base date 1900-01-01 (represented as 0) and MAX(issue_date). The result is an integer number-of-months.

DATEADD(month, <that integer>, 0) → add that many months to 1900-01-01. That yields the first day of the month containing MAX(issue_date) (e.g., 2021-12-01).

So lm returns exactly one row with a column cur_month_start = 'YYYY-MM-01'

CROSS JOIN lm attaches the single row from lm to every row of bank_loan_data. Practically this yields each b row plus a constant column lm.cur_month_start.

Because lm is one row, the join does not multiply rows in an unwanted way; it just makes lm.cur_month_start available to the WHERE clause and to the query context.
*/

-- average debt to income ratio
select avg(dti) * 100 AS averagedebttoincomratio
from bank_loan_data

-- average debt to income ratio for current month
;WITH lm AS (
    -- First day of the latest month in your data
    SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, MAX(issue_date)), 0) AS cur_month_start
    FROM bank_loan_data
)
SELECT
    lm.cur_month_start AS current_month_start,                -- first day of current month
    AVG(b.dti) * 100.0 AS averagedebttoincomratio_percentage  -- avg DTI × 100 = %
FROM bank_loan_data b
CROSS JOIN lm
WHERE b.issue_date >= lm.cur_month_start
  AND b.issue_date < DATEADD(MONTH, 1, lm.cur_month_start)
  AND b.dti IS NOT NULL
GROUP BY lm.cur_month_start;  

/*
first day of the month from a date

MAX(issue_date) - Finds the latest date in your table.
DATEDIFF(datepart, startdate, enddate) = number of boundaries crossed between startdate and enddate
MONTH → we’re counting whole month boundaries.
0 → this is shorthand for 1900-01-01 00:00:00.000 in SQL Server.
So this returns “the number of months between Jan 1, 1900 and the latest issue_date.”

From 1900-01-01 to 2021-12-12 = 1463 whole months.
So the expression returns 1463.

DATEADD(datepart, number, startdate) = add some interval to a date.

1463 months to 1900-01-01.

Result: 2021-12-01 00:00:00.000

DATEDIFF(MONTH, 0, date) = “how many months since 1900-01-01 until date.”

DATEADD(MONTH, that_number, 0) = “take 1900-01-01 and add back that many months.”

Net effect = the first day of the month containing date.
*/

-- average debt to income ratio for previous month
;WITH lm AS (
    SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, MAX(issue_date)), 0) AS cur_month_start
    FROM bank_loan_data
)
SELECT
    DATEADD(MONTH, -1, lm.cur_month_start)    AS prev_month_start,
    lm.cur_month_start                        AS current_month_start,
    AVG(b.dti)                                AS prev_month_avg_dti
FROM bank_loan_data b
CROSS JOIN lm
WHERE b.issue_date >= DATEADD(MONTH, -1, lm.cur_month_start)  -- prev month start (inclusive)
  AND b.issue_date <  lm.cur_month_start                     -- current month start (exclusive)
  AND b.dti IS NOT NULL
GROUP BY lm.cur_month_start;

-- good loan application percentage
SELECT 
    ROUND((COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN 1 END) * 100.0) / COUNT(id), 2)
        AS good_loan_percentage
FROM bank_loan_data;

-- good loan applications
select count(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN 1 END) 
    AS good_loans
from bank_loan_data

-- good loan funded amount
select sum(loan_amount) as good_loan_funded_amount
from bank_loan_data
where loan_status = 'Fully Paid' OR loan_status =  'Current'

-- good loan total received amount
select sum(total_payment) as good_loan_total_received_amount
from bank_loan_data
where loan_status IN ('Fully Paid', 'Current')

-- bad loan application percentage
select (COUNT(CASE WHEN loan_status = 'Charged off' THEN 1 END) * 100) / COUNT(id)
AS bad_loan_application_percentage
from bank_loan_data

-- BAD LOAN APPLICATIONS 
SELECT COUNT(ID) FROM
bank_loan_data
WHERE loan_status = 'Charged off'

-- BAD LOAN FUNDED AMOUNT
select sum(loan_amount) as bad_loan_funded_amount
from bank_loan_data
where loan_status IN ('Charged off')

-- BAD LOAN TOTAL AMOUNT RECEIVED
select sum(total_payment) as bad_loan_total_received_amount
from bank_loan_data
where loan_status IN ('Charged off')

-- loan status
select
        loan_status,
        COUNT(id) AS Total_loan_applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    from bank_loan_data
    group by loan_status;

    -- loan status of current month
select 
        loan_status,
        SUM(total_payment) AS MTD_Total_Amount_Received,
        SUM(loan_amount) AS MTD_Total_Funded_Amount
    from bank_loan_data
    where month(issue_date) = 12
    group by loan_status;

----------------OVERVIEW DASHBOARD-------------------
-- monthly Trend by isue date
select 
    MONTH(issue_date) AS Month_Number,
    DATENAME(MONTH, issue_date) AS month_name,
    count(id) AS Total_loan_applications,
    SUM(loan_amount) AS Total_funded_Amount,
    SUM(total_payment) AS Total_received_amount
    from bank_loan_data
    group by MONTH(issue_date), DATENAME(MONTH, issue_date)
    ORDER BY MONTH(issue_date);

-- Regional analysis by state
select 
    address_state AS State_Name,      
    count(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_amount
    from bank_loan_data
    GROUP BY address_state
    ORDER BY count(id) DESC;

-- Loan Term Analysis
select 
    term AS Loan_Term,      
    count(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_amount
    from bank_loan_data
    GROUP BY term
    ORDER BY term;

-- Employee Length Analysis
select 
    emp_length AS Employee_Tenure,      
    count(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_amount
    from bank_loan_data
    GROUP BY emp_length
    ORDER BY COUNT(id) DESC;

-- purpose
select 
    purpose AS Loan_pupose,      
    count(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_amount
    from bank_loan_data
    GROUP BY purpose
    ORDER BY count(id) DESC;

-- home ownership
select 
    home_ownership AS home_ownership,      
    count(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Received_amount
    from bank_loan_data
    GROUP BY home_ownership
    ORDER BY count(id) DESC;





   