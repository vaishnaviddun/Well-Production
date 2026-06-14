-- loading csv data to database
CREATE TABLE monthly_production_stg (
    wellbore_name TEXT,
    npdcode TEXT,
    year TEXT,
    month TEXT,
    on_stream_hrs TEXT,
    oil_sm3 TEXT,
    gas_sm3 TEXT,
    water_sm3 TEXT,
    gi_sm3 TEXT,
    wi_sm3 TEXT
);

COPY monthly_production_stg
FROM 'D:/SQL/monthly_production.csv'
CSV HEADER;

INSERT INTO monthly_production
SELECT
    wellbore_name,
    npdcode::INT,
    year::INT,
    month::INT,
    NULLIF(on_stream_hrs, 'NULL')::NUMERIC,
    NULLIF(REPLACE(oil_sm3, ',', ''), 'NULL')::NUMERIC,
    NULLIF(REPLACE(gas_sm3, ',', ''), 'NULL')::NUMERIC,
    NULLIF(REPLACE(water_sm3, ',', ''), 'NULL')::NUMERIC,
    NULLIF(REPLACE(gi_sm3, ',', ''), 'NULL')::NUMERIC,
    NULLIF(REPLACE(wi_sm3, ',', ''), 'NULL')::NUMERIC
FROM monthly_production_stg;

-- row count
SELECT COUNT(*) FROM monthly_production;

-- preview
SELECT * FROM monthly_production LIMIT 10;

-- unique wells
SELECT COUNT(DISTINCT wellbore_name) AS wells
FROM monthly_production;

-- date range
SELECT MIN(year), MAX(year)
FROM monthly_production;

-- missing values
SELECT
    COUNT(*) FILTER (WHERE oil_sm3 IS NULL) AS oil_nulls,
    COUNT(*) FILTER (WHERE gas_sm3 IS NULL) AS gas_nulls,
    COUNT(*) FILTER (WHERE water_sm3 IS NULL) AS water_nulls
FROM monthly_production;

-- total production
SELECT
    SUM(oil_sm3) AS total_oil,
    SUM(gas_sm3) AS total_gas,
    SUM(water_sm3) AS total_water
FROM monthly_production;

-- average monthly oil
SELECT AVG(oil_sm3)
FROM monthly_production;

-- top 10 wells
SELECT
    wellbore_name,
    SUM(oil_sm3) AS total_oil
FROM monthly_production
GROUP BY wellbore_name
ORDER BY total_oil DESC
LIMIT 10;

-- yearly production
SELECT
    year,
    SUM(oil_sm3) AS oil
FROM monthly_production
GROUP BY year
ORDER BY year;

-- monthly production
SELECT
    year,
    month,
    SUM(oil_sm3) AS oil
FROM monthly_production
GROUP BY year, month
ORDER BY year, month;

-- well by year
SELECT
    wellbore_name,
    year,
    SUM(oil_sm3) AS oil
FROM monthly_production
GROUP BY wellbore_name, year
ORDER BY wellbore_name, year;

-- rank wells
SELECT
    wellbore_name,
    SUM(oil_sm3) AS total_oil,
    RANK() OVER (
        ORDER BY SUM(oil_sm3) DESC
    ) AS rank
FROM monthly_production
GROUP BY wellbore_name;

-- row number
SELECT
    wellbore_name,
    year,
    month,
    ROW_NUMBER() OVER (
        PARTITION BY wellbore_name
        ORDER BY year, month
    ) AS rn
FROM monthly_production;

-- previous month
SELECT
    wellbore_name,
    year,
    month,
    oil_sm3,
    LAG(oil_sm3) OVER (
        PARTITION BY wellbore_name
        ORDER BY year, month
    ) AS prev_month
FROM monthly_production;

-- next month
SELECT
    wellbore_name,
    year,
    month,
    oil_sm3,
    LEAD(oil_sm3) OVER (
        PARTITION BY wellbore_name
        ORDER BY year, month
    ) AS next_month
FROM monthly_production;

-- running total
SELECT
    wellbore_name,
    year,
    month,
    oil_sm3,
    SUM(oil_sm3) OVER (
        PARTITION BY wellbore_name
        ORDER BY year, month
    ) AS cumulative_oil
FROM monthly_production;

-- monthly difference
SELECT
    wellbore_name,
    year,
    month,
    oil_sm3,
    oil_sm3 -
    LAG(oil_sm3) OVER (
        PARTITION BY wellbore_name
        ORDER BY year, month
    ) AS diff
FROM monthly_production;

WITH well_prod AS (
    SELECT
        wellbore_name,
        SUM(oil_sm3) AS total_oil
    FROM monthly_production
    GROUP BY wellbore_name
)
SELECT *
FROM well_prod
ORDER BY total_oil DESC;

-- having
SELECT
    wellbore_name,
    SUM(oil_sm3) AS total_oil
FROM monthly_production
GROUP BY wellbore_name
HAVING SUM(oil_sm3) > 50000;

-- classification
SELECT
    wellbore_name,
    SUM(oil_sm3) AS total_oil,
    CASE
        WHEN SUM(oil_sm3) > 100000 THEN 'High'
        WHEN SUM(oil_sm3) > 50000 THEN 'Medium'
        ELSE 'Low'
    END AS category
FROM monthly_production
GROUP BY wellbore_name;

CREATE INDEX idx_well_name
ON monthly_production(wellbore_name);

CREATE INDEX idx_year
ON monthly_production(year);

EXPLAIN
SELECT *
FROM monthly_production
WHERE wellbore_name = '15/9-F-1 C';