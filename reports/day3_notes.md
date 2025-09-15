DAY 3 Notes

SQL KPI Queries Completed

Total loan applications

Month-to-date (MTD) loan applications

Previous MTD loan applications

Total funded amount (overall + previous month)

Total amount received (overall + previous month)

Average interest rate (overall + previous month)

Average debt-to-income ratio (overall, current month, previous month)

Good loan analysis (applications, % share, funded amount, total received amount)

Bad loan analysis (applications, % share, funded amount, total received amount)

Loan status (overall + current month)

Monthly trend by issue date

Regional analysis by state

Loan term analysis

Employee length analysis

Loan purpose analysis

Home ownership analysis

(Queries written and verified in SQL, connected with Power BI.)

🔗 Power BI Setup

Created loan_performance_dashboard.bi and connected to SQL database.

Data quality check in Power Query → used Column Quality view.

Example: emp_title is empty in some cases → expected, since not all applicants work or disclose employer.

Power Query preview only shows 1,000 rows (default sampling).

📅 Date Table & Time Intelligence

Created a Date Table using the CALENDAR function with min/max from dataset.

Ensured no duplicate rows (Date is primary key).

Added month column:

Month = FORMAT('Date Table'[Date], "mmmm")


Relationship: One-to-many from bank_loan_data[issue_date] → Date Table[Date].

This allows proper Time Intelligence functions (DAX).

📐 DAX Measures

PMTD Loan Applications

= CALCULATE([Total Loan Applications], 
            DATESMTD(DATEADD('Date Table'[Date], -1, MONTH)))


MoM Loan Applications Growth

= ([MTD Loan Applications] - [PMTD Loan Applications]) 
  / [PMTD Loan Applications]


(Same approach can be extended to funded amount, amount received, interest rate, etc.)

🎨 Dashboard Formatting

Canvas background: reduce transparency to 0%.

To manage layering → use Format → Send Backward/Forward.

📌 Key Learnings & Takeaways

Always create a dedicated Date Table for time intelligence (instead of relying on raw date fields).

Model View relationships are crucial → ensure correct one-to-many mapping.

Use MTD, PMTD, MoM DAX measures for trend analysis.

Power Query preview is limited (1000 rows), but calculations/visuals still run on full dataset.

Data quality issues (e.g., emp_title blanks) are not errors, but expected domain realities.