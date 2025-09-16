
# Progress Log

This file tracks daily milestones for the Bank Loan Default Capstone project.  
Main README covers high-level overview; this log documents step-by-step progress.

---

## Day 1 — Project Setup
- Imported `financial_loan.csv` (~38k records) into SQL Server.
- Generated Date dimension table for time intelligence.
- Created repo scaffold with `.gitignore` and `README.md`.
- Committed anonymized 5-row dataset sample to `/data/inspected`.

---

## Day 2 — Documentation & QC
- Added `data_dictionary.md` (field definitions).
- Added `db_import_qc.md` (quality checks on SQL import).
- Verified schema DDL scripts in `/sql`.
- Initial EDA notes started in `/reports`.

---

## Day 3 — KPI SQL + Power BI
- Added `queries_day3.sql` with KPI queries (MTD, PMTD, MoM, ratios).
- Built `loan_performance_dashboard.pbix` with KPI visuals.
- Logged QC + observations in `day3_notes.md`.
- Created and merged feature branch: `feature/day3-sql-kpi-powerbi`.

---

## Day 4 — Slicers & Interactivity

- Added slicers for borrower `State`, loan `Grade`, and loan `Purpose`.
- Connected slicers across KPI cards, Good/Bad loan visuals, and Loan Status table.
- Enhanced Loan Status section with breakdown by status (Fully Paid, Current, Charged Off).
- Verified KPI-to-table consistency through SQL and Power BI.
- Dashboard base is now interactive

--
