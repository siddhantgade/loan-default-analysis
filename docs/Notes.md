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

Created loan\_performance\_dashboard.bi and connected to SQL database.



Data quality check in Power Query → used Column Quality view.

Example: emp\_title is empty in some cases → expected, since not all applicants work or disclose employer.

Power Query preview only shows 1,000 rows (default sampling).

📅 Date Table \& Time Intelligence

Created a Date Table using the CALENDAR function with min/max from dataset.

Ensured no duplicate rows (Date is primary key).

Added month column:

Month = FORMAT('Date Table'\[Date], "mmmm")



Relationship: One-to-many from bank\_loan\_data\[issue\_date] → Date Table\[Date].



This allows proper Time Intelligence functions (DAX).



📐 DAX Measures

PMTD Loan Applications

= CALCULATE(\[Total Loan Applications],
DATESMTD(DATEADD('Date Table'\[Date], -1, MONTH)))



MoM Loan Applications Growth

= (\[MTD Loan Applications] - \[PMTD Loan Applications])
/ \[PMTD Loan Applications]



(Same approach can be extended to funded amount, amount received, interest rate, etc.)

🎨 Dashboard Formatting

Canvas background: reduce transparency to 0%.

To manage layering → use Format → Send Backward/Forward.

📌 Key Learnings \& Takeaways

Always create a dedicated Date Table for time intelligence (instead of relying on raw date fields).

Model View relationships are crucial → ensure correct one-to-many mapping.

Use MTD, PMTD, MoM DAX measures for trend analysis.

Power Query preview is limited (1000 rows), but calculations/visuals still run on full dataset.

Data quality issues (e.g., emp\_title blanks) are not errors, but expected domain realities.



========================================================================================

4\) Slicers \& Loan Status Concepts



\### Slicers in Power BI

\- Act as \*\*interactive filters\*\* → translate user selection into `WHERE` conditions in queries.

\- Best used with \*\*categorical fields\*\* (`address\_state`, `grade`, `purpose`).

\- Cross-filtering must be enabled to ensure slicers affect all visuals consistently.

\- Dropdown slicers save space, checkbox/list slicers improve visibility.



\### Loan Status Analysis

\- Three core categories in the dataset: \*\*Fully Paid, Current, Charged Off\*\*.

\- \*\*Good Loans = Fully Paid + Current\*\*, \*\*Bad Loans = Charged Off\*\*.

\- Ratios are key metrics for portfolio quality:  

&nbsp; `Good Loan % = Good Loans / Total Loans`  

&nbsp; `Bad Loan % = Charged Off / Total Loans`.



\### Good vs Bad Loan Visuals

\- Donut charts highlight % share of Good vs Bad loans.

\- Supporting metrics (Applications, Funded Amount, Received Amount) give context.

\- Ensures stakeholders can see both \*\*proportion\*\* and \*\*absolute values\*\*.



\### Loan Status Table

\- Provides detailed breakdown with aggregations:  

&nbsp; - Loan Applications (COUNT)  

&nbsp; - Funded Amount (SUM)  

&nbsp; - Received Amount (SUM)  

&nbsp; - MTD/PMTD metrics  

&nbsp; - Interest Rate \& DTI (AVG)

\- Serves as a validation layer against KPI cards.



\### Key Learning

\- Slicers + status breakdown turn a static report into an \*\*interactive dashboard\*\*.

\- Always confirm slicers map to fields indexed or properly joined in SQL for performance.

\- Concept of “Good vs Bad” segmentation is directly tied to business insights (default risk).


====================================================================================================================
## Day 5 — Dashboard Enhancements, Sorting & Navigation

### 1. Format Painter
- Speeds up development by copying **visual formatting** (colors, labels, fonts, data labels) from one visual to another.  
- Best practice: finalize design on one KPI/visual → apply consistently across the page.  
- Saves time and enforces design consistency → key for professional dashboards.

---

### 2. Field Parameters
- Created a **dynamic parameter table** called `Select Measure` with options: *Received Amount*, *Funded Amount*, *Loan Applications*.  
- Used this as the **Y-axis in an area chart** → user can switch measures interactively.  
- Concept: **Field parameters** are a modern way to let end-users change visuals dynamically without bookmarks.  
- Interview angle: Compare **Field Parameters vs. Switch DAX**:
  - Field parameters = built-in, scalable, user-friendly.  
  - Switch DAX = older approach, harder to maintain.  

---

### 3. Sorting by Month
- Display issue month as `MMM` (e.g., Jan, Feb) for cleaner X-axis.  
- Problem: by default, Power BI sorts text alphabetically (Apr, Aug, Dec…).  
- Solution: created `MonthNumber` column (1–12) and used **Sort by Column** → sort `MMM` by `MonthNumber`.  
- Interview Q: *“How do you sort months correctly in Power BI?”*  
  - Answer: Create numeric column for month order → `Sort by Column` feature.  

---

### 4. Shape Map Visual
- Added **Shape Map** on overview page → visualizes metrics geographically (by borrower state).  
- Customized colors, legends, and titles for clarity.  
- Note: Shape Map is a **preview feature** → must be enabled in Options → Preview features.  
- Useful for **geospatial insights** like loan distribution by state.  

---

### 5. Donut Chart
- Added to overview page for Good vs Bad loan distribution.  
- Customized **rotation, slice size, color themes, labels**.  
- Best practice:  
  - Keep slice count < 6 for readability.  
  - Use **donut hole** for totals or % values.  
- Interview angle: *When to use donut vs pie chart?*  
  - Donut = better for showing part-to-whole + totals.  
  - Pie = less space for annotation.  

---

### 6. Bar Charts & Treemap
- Built bar charts (e.g., loan count by purpose/grade).  
- Built treemap for loan distribution (hierarchical categories).  
- Bar chart → better for exact comparison.  
- Treemap → better for relative proportion across categories.  

---

### 7. Edit Interactions
- Used **Edit Interactions** to control how slicers/visuals affect each other.  
- Example: slicer for loan grade filters charts, but doesn’t affect KPIs.  
- Best practice: prevent irrelevant slicers from confusing users.  
- Interview angle: *How do you manage unwanted slicer effects?* → Answer: Edit Interactions.  

---

### 8. Navigation & Layout
- Added **images and navigation buttons** on Page 1 → allows multi-page navigation (Overview → Details → Trends).  
- Buttons can trigger page navigation or bookmarks.  
- Improves **user experience**, makes dashboard feel like an app.  

---

### 🔑 Key Learnings (Day 5)
- Format Painter & consistent styling → dashboard polish.  
- Field Parameters → modern, scalable solution for dynamic measure switching.  
- Sorting months requires **numeric column + Sort by Column**.  
- Shape Map → geographical loan insights (preview feature).  
- Donut, bar, treemap → different strengths, choose based on insight need.  
- Edit Interactions → control story flow, reduce noise.  
- Navigation buttons → make multi-page reports intuitive.  


-----------------------------------------------------------------------------------------
Day 6 — Python EDA Notes
Jupyter Notebook Basics

Markdown cells allow formatted text.

# = H1 (largest heading), ## = H2, ### = H3, etc.
Fewer # → bigger heading size.
Use Markdown for titles, explanations, and structuring your notebook (recruiter-friendly).

Code cells are for Python; always run from top to bottom for reproducibility.

Reading Data

pd.read_excel(path) → loads Excel file into a DataFrame (df).
pd.read_csv(path) → use for CSV files (much faster).
Always check file type first; .csv vs .xlsx matters.

Common options:

usecols=[] → load only selected columns.
dtype={} → force column types on load.
low_memory=False → prevents mixed dtypes warning on large files.

Basic Exploration

df.head() → first 5 rows (use .head(10) for more).
df.tail() → last 5 rows.

Helps confirm data loaded correctly and no parsing issues.

Dimensions

df.shape → returns tuple (rows, columns).
df.shape[0] → number of rows.
df.shape[1] → number of columns.

Use print(f"Rows: {df.shape[0]}, Columns: {df.shape[1]}") for clean output.

Data Types
df.dtypes → shows data type of each column.
int64, float64 → numeric.
object → usually strings (needs cleaning).
datetime64[ns] → date/time.

Important for deciding preprocessing: e.g., categorical encoding, datetime parsing.

Descriptive Statistics
df.describe() → summary of numeric columns only by default:
count → non-missing values.
mean, std → average and spread.
min, 25%, 50%, 75%, max → quartiles & extremes.

Use df.describe(include='all') → includes object/categorical columns (count, unique, top, freq).

Professional Touches
Always start notebooks with imports + data load cell.
Follow with a Quick Info cell: shape, dtypes, describe.
Helps recruiters see you know structured EDA.
Before GitHub: do Kernel → Restart & Run All to ensure clean, reproducible outputs.
----------------------------------------------------------------------------------------------------------
Day 7 Notes

--> Parsing Dates Correctly (dayfirst vs monthfirst) Can Make or Break KPIs
Issue

In Python (pandas), my issue_date column was showing only 1 row for Dec 2021, even though I could clearly see many December dates in Excel. Because of this, my Month-to-Date (MTD) totals were tiny (~0.01M) instead of ~58M like in SQL/Power BI.

--> Cause

By default, pandas assumes dates are in month-first format (MM-DD-YYYY). But my dataset actually had day-first format (DD-MM-YYYY). This caused pandas to mis-read most December dates and collapse them.

--> Fix (What Worked)

Load the CSV with the correct setting:

df = pd.read_csv(path, parse_dates=['issue_date'], dayfirst=True)

--> Python Quick Notes

To find avg in python we use mean

To comment in python in jupyter we use #

--> Good Loan KPIs
good_loans = df[df['loan_status'].isin(["Fully Paid", "Current"])]

total_loan_applications = df['id'].count()

good_loan_applications = good_loans['id'].count()
good_loan_funded_amount = good_loans['loan_amount'].sum()
good_loan_received = good_loans['total_payment'].sum()

good_loan_funded_amount_millions = good_loan_funded_amount / 1000000
good_loan_received_millions = good_loan_received / 1000000

good_loan_percentage = (good_loan_applications / total_loan_applications) * 100

print("Good Loan Applications:", good_loan_applications)
print(f"Good Loan Funded Amount(in millions): {good_loan_funded_amount_millions:.2f}M")
print(f"Good Loan Received Amount(in millions): {good_loan_received_millions:.2f})M")
print(f"Good Loan Percentage: {good_loan_percentage:.2f}M")

-------------------------------------------------------------------------------------------
Monthly Funded Amount (Line + Area Chart)
Code
monthly_funded = (
    df.sort_values('issue_date')
      .assign(month_name=lambda x: x['issue_date'].dt.strftime('%b %Y'))
      .groupby('month_name', sort=False)['loan_amount']
      .sum()
      .div(1000000)
      .reset_index(name='loan_amount_millions')
)

plt.figure(figsize=(10,5))
x = range(len(monthly_funded))
y = monthly_funded['loan_amount_millions']

plt.fill_between(x, y, color='skyblue', alpha=0.5)
plt.plot(x, y, color='blue', linewidth=2)

for i, row in monthly_funded.iterrows():
    plt.text(
        i,
        row['loan_amount_millions'] + 0.1,
        f"{row['loan_amount_millions']:.2f}",
        ha='center',
        va='bottom',
        fontsize=9,
        rotation=0,
        color='black'
    )
plt.title('Total Funded Amount by Month', fontsize=14)
plt.xlabel('Month')
plt.ylabel('Funded Amount (In Millions)')
plt.xticks(ticks=x, labels=monthly_funded['month_name'], rotation=45)
plt.grid(True, linestyle = '--', alpha = 0.6)
plt.tight_layout()
plt.show()

--> Explanation
------->Data Prep

df.sort_values('issue_date')

What it does: Sorts the entire DataFrame in ascending order based on issue_date.

Why we do it: Ensures months appear chronologically (Jan → Feb → Mar) instead of alphabetically (Apr → Feb → Jan).
.assign(month_name=lambda x: x['issue_date'].dt.strftime('%b %Y'))

What it does: Creates a new column month_name with values like "Jan 2024".

Why we do it: Provides a simple string for grouping by month.

.groupby('month_name', sort=False)['loan_amount']

What it does: Groups rows by month_name, focusing only on loan_amount.
Why we do it: Aggregates all loan amounts within the same month.
Note: sort=False preserves chronological order.

.sum()

What it does: Adds up all loan amounts for each month.
Why we do it: Produces total funded loan amount per month.

.div(1000000)

What it does: Divides monthly totals by 1,000,000.

Why we do it: Converts large numbers into millions for readability.

Example:

issue_date	loan_amount
2024-03-15	250000
2024-02-10	500000
2024-02-28	750000
2024-03-20	1000000

Before .reset_index() (Series output):

month_name
Feb 2024    1.25
Mar 2024    1.25
Name: loan_amount, dtype: float64


After .reset_index(name='loan_amount_millions'):

month_name	loan_amount_millions
Feb 2024	1.25
Mar 2024	1.25

Why .reset_index() is important:

Before: result is a Series (month names = index, sums = values).
After: result is a clean DataFrame (month as column, sums renamed to loan_amount_millions).
Benefits: makes charting easier (explicit x and y columns).

-------> Setup Plot

plt.figure(figsize=(10,5))
Creates a new chart canvas, size 10x5 inches.

x = range(len(monthly_funded))
Generates numeric x positions [0, 1, 2, …] for each month.

y = monthly_funded['loan_amount_millions']
Selects monthly totals as y-values.

plt.fill_between(x, y, ...)
Shades the area under the line in skyblue (area chart effect).

plt.plot(x, y, ...)
Draws the line itself (blue, thickness=2).

------->Data Labels

for i, row in monthly_funded.iterrows():
Loops over each row in DataFrame.

i = numeric index (0,1,2…).

row = row data.

plt.text(...)
Adds text annotations above each point.

x-coordinate: i → aligns label with month index.

y-coordinate: row['loan_amount_millions'] + 0.1 → slightly above point.

Text content: f"{row['loan_amount_millions']:.2f}" → formats value with 2 decimals.

------->Styling:

ha='center' → horizontal center.

va='bottom' → bottom alignment.

fontsize=9 → small font.

rotation=0 → horizontal text.

color='black' → black labels.

------->Titles, Axes & Grid

plt.title(..., fontsize=14) → Adds chart title (larger font).

plt.xlabel('Month') → Names x-axis.

plt.ylabel('Funded Amount (In Millions)') → Names y-axis.

plt.xticks(...) → Replaces numeric x-ticks with month names, rotated 45° for readability.

plt.grid(True, linestyle='--', alpha=0.6) → Dashed semi-transparent grid.

plt.tight_layout() → Adjusts layout to fit labels.

plt.show() → Renders chart.

------->Why the Loop?

Matplotlib’s plt.text() can only annotate one point at a time.
To label all months:
Iterate through each row (iterrows()).
Get x-position (i).
Get y-value (row['loan_amount_millions']).
Place label above point.
Without loop → only one label, not per month.

-----------------------------------------------------------------------
Regional Analysis By State (Bar Chart)
Code
state_funding = df.groupby('address_state')['loan_amount'].sum().sort_values(ascending=True)
state_funding_millions = state_funding / 1000000

plt.figure(figsize=(10, 8))
bars = plt.barh(state_funding_millions.index, state_funding_millions.values, color='lightcoral')

for bar in bars:
    width = bar.get_width()
    plt.text(
        width + 1,
        bar.get_y() + bar.get_height() / 2,
        f'{width:.0f}M',
        va='center',
        fontsize=9
    )

plt.title('Total Funded Amount by state (in  Millions)')
plt.xlabel('Funded Amount ($ Millions)')
plt.ylabel('State')
plt.tight_layout()
plt.show()

Explanation

df.groupby('address_state')
Groups DataFrame rows by address_state so all loans from the same state are bundled.

['loan_amount'].sum()
Calculates total funded amount per state.

.sort_values(ascending=True)
Sorts states from lowest to highest funded amount. Result = Series (index=state, value=total).

Plotting (plt.barh)
state_funding_millions.index → y-axis labels (states).
state_funding_millions.values → x-axis values (amounts in millions).
color='lightcoral' → bar color.
bars stores bar objects for labeling.

Adding Data Labels (loop)
Iterate for bar in bars: to handle each bar individually.
width = bar.get_width() → bar length (value).
bar.get_y() + bar.get_height() / 2 → vertical center of bar (places text centered).
plt.text(width + 1, ..., f'{width:.0f}M', va='center', fontsize=9) → places integer-million label slightly right of bar end.

Final formatting
Titles and axis labels clarify units. plt.tight_layout() avoids clipping. plt.show() renders the figure.

---------------------------------------------------------------------------------------------------------------------------------

