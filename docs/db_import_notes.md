# DB Import Notes — Day 1

- Converted Excel file to CSV and imported into MSSQL.
- Fixed datatype issues:
  - SMALLINT → INT for `loan_amount` and `total_payment`
  - Increased `emp_title` to VARCHAR(100) to resolve BCP column length error
- Kept `id` as PRIMARY KEY and allowed `emp_title` as NULL.
- Did **not** commit raw CSV (PII). Only committed `data/inspected/sample_preview.csv`.

---

## Errors & Fixes
- **Error**: "The given value of type string cannot be converted to type smallint for column 23"  
  **Fix**: Changed column to INT.
- **Error**: "Invalid column length from bcp client for colid 5"  
  **Fix**: Increased `emp_title` to VARCHAR(100).

---

## Next Steps
- Add data dictionary (`docs/data_dictionary.md`)
- Export schema DDL (`sql/schema_ddl.sql`)
- Run QC checks (`reports/db_import_qc.md`)
