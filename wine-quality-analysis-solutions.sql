CREATE TABLE wine 
(
   fixed_acidity FLOAT,
   volatile_acidity FLOAT,	
   citric_acid	FLOAT,
   residual_sugar	FLOAT,
   chlorides FLOAT,
   free_sulfur_dioxide	FLOAT,
   total_sulfur_dioxide FLOAT,	 
   density FLOAT,
   pH	FLOAT,
   sulphates FLOAT,	
   alcohol FLOAT,
   quality FLOAT
);

SELECT * FROM wine;

1.  Find the average chemical composition of wines based on quality levels

SELECT quality, 
       ROUND(AVG(alcohol)::NUMERIC, 2) AS avg_alcohol, 
       ROUND(AVG(fixed_acidity)::NUMERIC, 2) AS avg_fixed_acidity, 
       ROUND(AVG(volatile_acidity)::NUMERIC, 2) AS avg_volatile_acidity, 
       ROUND(AVG(sulphates)::NUMERIC, 2) AS avg_sulphates
FROM wine
GROUP BY quality
ORDER BY quality DESC;

2.Find correlations between acidity and wine quality

SELECT quality, 
       ROUND(AVG(fixed_acidity)::NUMERIC, 2) AS avg_fixed_acidity, 
       ROUND(AVG(pH)::NUMERIC, 2) AS avg_pH
FROM wine
GROUP BY quality
ORDER BY quality DESC;

3. Find the top 3 wines with the highest alcohol content for each quality score.

WITH RankedWines AS (
    SELECT *, 
           RANK() OVER (PARTITION BY quality ORDER BY alcohol DESC) AS rank
    FROM wine
)
SELECT * FROM RankedWines WHERE rank <= 3;

4.Find wines that are "balanced" in acidity (pH close to 3.2–3.4) and have high quality.

SELECT * FROM wine
WHERE pH BETWEEN 3.2 AND 3.4
AND quality >= 7
ORDER BY quality DESC;

5.Which chemical factors have the highest correlation with wine quality?

SELECT 
    ROUND(CORR(quality, alcohol)::NUMERIC, 2) AS alcohol_corr,
    ROUND(CORR(quality, sulphates)::NUMERIC, 2) AS sulphates_corr,
    ROUND(CORR(quality, citric_acid)::NUMERIC, 2) AS citric_acid_corr,
    ROUND(CORR(quality, volatile_acidity)::NUMERIC, 2) AS volatile_acidity_corr,
    ROUND(CORR(quality, total_sulfur_dioxide)::NUMERIC, 2) AS total_sulfur_corr
FROM wine;