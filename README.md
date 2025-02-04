# WineDataAnalysis


1. **Find the average chemical composition of wines based on quality levels**:
   '''sql
   SELECT quality, 
       ROUND(AVG(alcohol)::NUMERIC, 2) AS avg_alcohol, 
       ROUND(AVG(fixed_acidity)::NUMERIC, 2) AS avg_fixed_acidity, 
       ROUND(AVG(volatile_acidity)::NUMERIC, 2) AS avg_volatile_acidity, 
       ROUND(AVG(sulphates)::NUMERIC, 2) AS avg_sulphates
   FROM wine
   GROUP BY quality
   ORDER BY quality DESC;
   '''
