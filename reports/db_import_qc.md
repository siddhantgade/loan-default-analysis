# DB Import QC 

This report contains basic quality checks run on `financial_loan.csv` after import.


## Summary

- **Total rows:** 38576

## Null / Missingness (top 10)

- `emp_title`: 3.73%

- `id`: 0.0%

- `address_state`: 0.0%

- `application_type`: 0.0%

- `emp_length`: 0.0%

- `grade`: 0.0%

- `home_ownership`: 0.0%

- `issue_date`: 0.0%

- `last_credit_pull_date`: 0.0%

- `last_payment_date`: 0.0%


## Duplicates

- No duplicate `id` found.


## Date ranges

- `issue_date`: 2021-01-01 → 2021-12-12

- `next_payment_date`: 2021-02-08 → 2022-01-15

- `last_payment_date`: 2021-01-08 → 2021-12-15

- `last_credit_pull_date`: 2021-01-08 → 2022-01-20


## Top categorical value counts 

### `loan_status`

- Fully Paid: 32145

- Charged Off: 5333

- Current: 1098

### `purpose`

- Debt consolidation: 18214

- credit card: 4998

- other: 3824

- home improvement: 2876

- major purchase: 2110

- small business: 1776

- car: 1497

- wedding: 928

- medical: 667

- moving: 559

### `home_ownership`

- RENT: 18439

- MORTGAGE: 17198

- OWN: 2838

- OTHER: 98

- NONE: 3

### `grade`

- B: 11674

- A: 9689

- C: 7904

- D: 5182

- E: 2786

- F: 1028

- G: 313

### `sub_grade`

- B3: 2834

- A4: 2803

- A5: 2654

- B5: 2644

- B4: 2455

- C1: 2089

- B2: 1990

- C2: 1972

- B1: 1751

- A3: 1740

### `verification_status`

- Not Verified: 16464

- Verified: 12335

- Source Verified: 9777


## Numeric summaries 

### `loan_amount`

- count: 38576, mean: 11296.07, std: 7460.75, min: 500.0, 25%: 5500.0, 50%: 10000.0, 75%: 15000.0, max: 35000.0

### `annual_income`

- count: 38576, mean: 69644.54, std: 64293.68, min: 4000.0, 25%: 41500.0, 50%: 60000.0, 75%: 83200.5, max: 6000000.0

### `dti`

- count: 38576, mean: 0.13, std: 0.07, min: 0.0, 25%: 0.08, 50%: 0.13, 75%: 0.19, max: 0.3

### `installment`

- count: 38576, mean: 326.86, std: 209.09, min: 15.69, 25%: 168.45, 50%: 283.04, 75%: 434.44, max: 1305.19

### `int_rate`

- count: 38576, mean: 0.12, std: 0.04, min: 0.05, 25%: 0.09, 50%: 0.12, 75%: 0.15, max: 0.25

### `total_acc`

- count: 38576, mean: 22.13, std: 11.39, min: 2.0, 25%: 14.0, 50%: 20.0, 75%: 29.0, max: 90.0

### `total_payment`

- count: 38576, mean: 12263.35, std: 9051.1, min: 34.0, 25%: 5633.0, 50%: 10042.0, 75%: 16658.0, max: 58564.0


