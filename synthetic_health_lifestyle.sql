-- 1. View first 10 rows
SELECT * FROM health_lifestyle LIMIT 10;

-- 2. Total number of records
SELECT COUNT(*) AS total_records FROM health_lifestyle;

-- 3. Gender distribution
SELECT gender, COUNT(*) AS count FROM health_lifestyle GROUP BY gender;

-- 4. Average age by gender
SELECT gender, AVG(age) AS avg_age FROM health_lifestyle GROUP BY gender;

-- 5. Overall average BMI
SELECT AVG(bmi) AS average_bmi FROM health_lifestyle;

-- 6. Count of obese individuals (BMI > 30)
SELECT COUNT(*) AS obese_count FROM health_lifestyle WHERE bmi > 30;

-- 7. Smokers with chronic disease
SELECT COUNT(*) AS smokers_with_disease 
FROM health_lifestyle 
WHERE smoker = 'Yes' AND chronic_disease = 'Yes';

-- 8. Avg stress level by smoker status
SELECT smoker, AVG(stress_level) AS avg_stress FROM health_lifestyle GROUP BY smoker;

-- 9. Chronic disease by alcohol consumption level
SELECT alcohol_consumption, COUNT(*) AS with_disease 
FROM health_lifestyle 
WHERE chronic_disease = 'Yes'
GROUP BY alcohol_consumption;

-- 10. Average sleep hours by diet quality
SELECT diet_quality, AVG(sleep_hours) AS avg_sleep FROM health_lifestyle GROUP BY diet_quality;

-- 11. People who sleep < 6 hours per night
SELECT COUNT(*) AS low_sleep_count FROM health_lifestyle WHERE sleep_hours < 6;

-- 12. Stress vs Sleep correlation (bucketed view)
SELECT 
  CASE 
    WHEN sleep_hours < 5 THEN 'Very Low'
    WHEN sleep_hours BETWEEN 5 AND 7 THEN 'Low'
    WHEN sleep_hours BETWEEN 7 AND 9 THEN 'Good'
    ELSE 'Excellent'
  END AS sleep_quality,
  AVG(stress_level) AS avg_stress
FROM health_lifestyle
GROUP BY sleep_quality;

-- 13. BMI category classification
SELECT 
  COUNT(*) FILTER (WHERE bmi < 18.5) AS underweight,
  COUNT(*) FILTER (WHERE bmi BETWEEN 18.5 AND 24.9) AS normal,
  COUNT(*) FILTER (WHERE bmi BETWEEN 25 AND 29.9) AS overweight,
  COUNT(*) FILTER (WHERE bmi >= 30) AS obese
FROM health_lifestyle;

-- 14. Most common exercise frequency
SELECT exercise_freq, COUNT(*) AS freq_count FROM health_lifestyle GROUP BY exercise_freq ORDER BY freq_count DESC LIMIT 1;

-- 15. Chronic disease vs diet quality
SELECT diet_quality, COUNT(*) AS chronic_count 
FROM health_lifestyle 
WHERE chronic_disease = 'Yes' 
GROUP BY diet_quality;

-- 16. Average BMI by gender
SELECT gender, AVG(bmi) AS avg_bmi FROM health_lifestyle GROUP BY gender;

-- 17. % of smokers in the dataset
SELECT 
  ROUND(100.0 * COUNT(*) FILTER (WHERE smoker = 'Yes') / COUNT(*), 2) AS smoker_percentage 
FROM health_lifestyle;

-- 18. Top 3 highest stress records
SELECT * FROM health_lifestyle ORDER BY stress_level DESC LIMIT 3;

-- 19. Sleep hour average by alcohol use
SELECT alcohol_consumption, AVG(sleep_hours) AS avg_sleep 
FROM health_lifestyle 
GROUP BY alcohol_consumption;

-- 20. Age group analysis
SELECT 
  CASE 
    WHEN age < 25 THEN 'Under 25'
    WHEN age BETWEEN 25 AND 40 THEN '25-40'
    WHEN age BETWEEN 41 AND 60 THEN '41-60'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS total
FROM health_lifestyle
GROUP BY age_group;

--BMI Category Counts
SELECT 
  'Underweight' AS category, COUNT(*) FROM health_lifestyle WHERE bmi < 18.5
UNION ALL
SELECT 'Normal', COUNT(*) FROM health_lifestyle WHERE bmi BETWEEN 18.5 AND 24.9
UNION ALL
SELECT 'Overweight', COUNT(*) FROM health_lifestyle WHERE bmi BETWEEN 25 AND 29.9
UNION ALL
SELECT 'Obese', COUNT(*) FROM health_lifestyle WHERE bmi >= 30;

--Stress Level vs Sleep Hours (Avg)
SELECT 
  ROUND(sleep_hours) AS sleep_hours,
  ROUND(AVG(stress_level), 2) AS avg_stress
FROM health_lifestyle
GROUP BY ROUND(sleep_hours)
ORDER BY sleep_hours;

--Chronic Disease by Gender
SELECT gender, COUNT(*) FILTER (WHERE chronic_disease = 'Yes') AS with_disease
FROM health_lifestyle
GROUP BY gender;

--Alcohol Use vs Chronic Disease
SELECT alcohol_consumption, COUNT(*) FILTER (WHERE chronic_disease = 'Yes') AS with_disease
FROM health_lifestyle
GROUP BY alcohol_consumption;




