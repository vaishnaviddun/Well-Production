# Well-Production
PostgreSQL-based analysis of Volve oil and gas production data using aggregations, window functions, CTEs, ranking, trend analysis, and production KPIs.

# Well Production Analysis (PostgreSQL)

## Project Overview
This project analyzes the Volve oil and gas production dataset using PostgreSQL.

The objective is to explore production trends, rank wells, calculate key production KPIs, and apply advanced SQL concepts, including:

- Aggregations
- GROUP BY
- HAVING
- CASE
- CTEs
- Window Functions
- Ranking Functions
- Trend Analysis
- Production KPIs

## Dataset

Dataset: Volve Monthly Production Data

Table: monthly_production

## SQL Skills Demonstrated

### Aggregations
- SUM()
- AVG()
- COUNT()

### Grouping
- GROUP BY
- HAVING

### Conditional Logic
- CASE

### Window Functions
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- LAG()
- LEAD()
- SUM() OVER()

### Advanced SQL
- CTE (WITH)
- Indexing
- Query Optimization

## Project Structure

```text
well-production/
│
├── data/
│   └── monthly_production.csv
│
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_data_quality.sql
│   ├── 03_basic_kpis.sql
│   ├── 04_production_analysis.sql
│   ├── 05_ranking.sql
│   ├── 06_window_functions.sql
│   ├── 07_trend_analysis.sql
│   ├── 08_business_kpis.sql
│   ├── 09_cte_having_case.sql
│   └── 10_indexes.sql
│
├── screenshots/
│
└── README.md
```

## Analysis Performed

  ### Data Quality Checks
  - Row Count
  - Null Analysis
  - Distinct Well Count
  - Date Range Validation

  ### Production Analysis
  - Total Oil Production
  - Total Gas Production
  - Total Water Production
  - Production by Year
  - Production by Month

  ### Well Performance Analysis
  - Top Producing Wells
  - Well Ranking
  - Dense Ranking
  - Production Categories
  
  ### Trend Analysis
  - Month-over-Month Change
  - Percentage Change
  - Running Total Production

## Key Findings

### Top Producing Wells

<img width="386" height="302" alt="image" src="https://github.com/user-attachments/assets/4d139d71-a237-42a3-9e7b-efd6e1733268" />

### Yearly Production Trend

<img width="273" height="408" alt="image" src="https://github.com/user-attachments/assets/a95ec955-29ad-40cf-b219-b43ebb542eb9" />

### Monthly Production Trend

<img width="1310" height="597" alt="image" src="https://github.com/user-attachments/assets/12dc871f-d455-46d0-a24a-37d0dae30b3f" />

### Well Rankings

<img width="467" height="307" alt="image" src="https://github.com/user-attachments/assets/4fc3eff3-f470-4897-a446-6099916277ae" />

## Technologies Used
- PostgreSQL
- pgAdmin
- SQL

## Author
Vaishnavi Agarwal
