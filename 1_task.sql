WITH salary_changes AS (
SELECT  
	year,
	avg_gross_salary_value_yearly,
	industry_name,
	industry_index,
	LAG (avg_gross_salary_value_yearly, 1, avg_gross_salary_value_yearly) OVER (PARTITION BY industry_name ORDER BY year) AS salary_last_year, -- Určení mzdy za předchozí rok pro srovnání
	CASE
		WHEN avg_gross_salary_value_yearly < LAG (avg_gross_salary_value_yearly, 1, avg_gross_salary_value_yearly) OVER (PARTITION BY industry_name ORDER BY year) THEN 'Klesají'
		ELSE 'Rostou'
	END AS salary_trend
FROM t_lenka_pagacova_project_sql_primary_final tlppspf
GROUP BY 
	year,
	industry_name,
	avg_gross_salary_value_yearly,
	industry_index
ORDER BY
	industry_name ASC
)
SELECT
	*
FROM salary_changes
WHERE salary_trend = 'Klesají' -- Chci zjistit, jestli někde klesají, nebo opravdu ve všech odvětví rostou
ORDER BY year;
