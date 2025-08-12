WITH annual_sum AS (
SELECT 
	product_name,
	year,
	round(avg(product_price_value_yearly)::numeric, 2) AS product_price_value,
	LAG (round(avg(product_price_value_yearly)::numeric, 2), 1) OVER (PARTITION BY product_name ORDER BY year) AS product_price_last_year,
	round(avg(avg_gross_salary_value_yearly)::NUMERIC, 2) AS avg_wages,
	LAG (round(avg(avg_gross_salary_value_yearly)::numeric, 2), 1) OVER (PARTITION BY product_name ORDER BY year) AS wage_last_year
FROM
	t_lenka_pagacova_project_sql_primary_final tlppspf
GROUP BY
	product_name,
	year
),
product_wage_changes AS (
	SELECT 
		product_name,
		year,
		(product_price_value - product_price_last_year) / product_price_last_year AS product_price_change, -- Zjištění rozdílu v ceně u produktů
		(avg_wages - wage_last_year) / wage_last_year AS wage_change -- Zjištění rozdílu ve mzdě 
	FROM annual_sum
)
SELECT 
	year,
	round(avg(product_price_change) * 100, 2) AS product_price_percentage_change, -- Přepočet na %
	round(avg(wage_change) * 100, 2) AS wage_percentage_change, -- Přepočet na %
	CASE
		WHEN round(avg(product_price_change) * 100) > round(avg(wage_change) * 100 + 10) THEN 'Ano, nárůst cen potravin je vyšší než nárůst mezd'
		ELSE 'Ne, nárůst cen není vyšší než nárůst mezd'
	END AS result
FROM 
	product_wage_changes
WHERE
	product_price_change IS NOT NULL 
	AND wage_change IS NOT NULL
GROUP BY
	year
ORDER BY 
	year;

