# README for Wine Quality Analysis Project

**1️. Import the dataset into PostgreSQL**. <br>
**2️. Run the SQL scripts in the provided order**. <br>
**3️. Analyze the results and draw insights**. <br>
<br>
**This project analyzes a wine quality dataset using PostgreSQL to extract insights about the chemical properties that impact wine quality. 
The dataset includes attributes like acidity, alcohol content, pH, and sulfur levels**.

**Dataset link**: [https://www.kaggle.com/datasets/sgus1318/winedata](https://www.kaggle.com/datasets/sgus1318/winedata)

  1. **Find the average chemical composition of wines based on quality levels**:
   ```sql
   SELECT quality, 
       ROUND(AVG(alcohol)::NUMERIC, 2) AS avg_alcohol, 
       ROUND(AVG(fixed_acidity)::NUMERIC, 2) AS avg_fixed_acidity, 
       ROUND(AVG(volatile_acidity)::NUMERIC, 2) AS avg_volatile_acidity, 
       ROUND(AVG(sulphates)::NUMERIC, 2) AS avg_sulphates
   FROM wine
   GROUP BY quality
   ORDER BY quality DESC;
   ```
  2. **Find correlations between acidity and wine quality**:
```sql
SELECT quality, 
       ROUND(AVG(fixed_acidity)::NUMERIC, 2) AS avg_fixed_acidity, 
       ROUND(AVG(pH)::NUMERIC, 2) AS avg_pH
FROM wine
GROUP BY quality
ORDER BY quality DESC;
```
  3. **Find the top 3 wines with the highest alcohol content for each quality score**:
```sql
WITH RankedWines AS (
    SELECT *, 
           RANK() OVER (PARTITION BY quality ORDER BY alcohol DESC) AS rank
    FROM wine
                    )
SELECT * FROM RankedWines WHERE rank <= 3;
```
  4. **Find wines that are "balanced" in acidity (pH close to 3.2–3.4) and have high quality**:
```sql
SELECT * FROM wine
WHERE pH BETWEEN 3.2 AND 3.4
AND quality >= 7
ORDER BY quality DESC;
```
  5. **Which chemical factors have the highest correlation with wine quality?**:
```sql
SELECT 
    ROUND(CORR(quality, alcohol)::NUMERIC, 2) AS alcohol_corr,
    ROUND(CORR(quality, sulphates)::NUMERIC, 2) AS sulphates_corr,
    ROUND(CORR(quality, citric_acid)::NUMERIC, 2) AS citric_acid_corr,
    ROUND(CORR(quality, volatile_acidity)::NUMERIC, 2) AS volatile_acidity_corr,
    ROUND(CORR(quality, total_sulfur_dioxide)::NUMERIC, 2) AS total_sulfur_corr
FROM wine;
```
