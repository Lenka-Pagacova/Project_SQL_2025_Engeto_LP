WITH annual_sum AS (
	SELECT 
		lp_second.year AS current_year,
		round(avg(lp_second.gdp)::numeric, 2) AS annual_avg_gdp, -- Průměrná hodnota HDP za každý rok
		round(avg(lp_primary.avg_gross_salary_value_yearly)::numeric, 2) AS annual_avg_salary, -- Průměrná roční hrubá mzda
		round(avg(lp_primary.product_price_value_yearly)::numeric, 2) AS annual_avg_price -- Průměrná roční cena produktu
	FROM t_lenka_pagacova_project_sql_secondary_final AS lp_second
	JOIN t_lenka_pagacova_project_sql_primary_final AS lp_primary
		ON lp_second.year = lp_primary.year
	GROUP BY lp_second.year
),
yearly_changes AS (
	SELECT 
		current_year,
		annual_avg_gdp,
		annual_avg_salary,
		annual_avg_price,
		(annual_avg_gdp - LAG (annual_avg_gdp, 1) OVER (ORDER BY current_year)) / LAG (annual_avg_gdp, 1) OVER (ORDER BY current_year) AS gdp_change, -- Meziroční změna HDP, stejný výpočet pak pro mzdu a cenu
		(annual_avg_salary - LAG (annual_avg_salary, 1) OVER (ORDER BY current_year)) / LAG (annual_avg_salary, 1) OVER (ORDER BY current_year) AS salary_change,
		(annual_avg_price - LAG (annual_avg_price, 1) OVER (ORDER BY current_year)) / LAG (annual_avg_price, 1) OVER (ORDER BY current_year) AS price_change
	FROM annual_sum
)
SELECT
	current_year,
	round(gdp_change * 100, 2) AS gdp_percentage_change, -- Převod na %, stejně tak pro mzdy a ceny
	round(salary_change * 100, 2) AS salary_percentage_change,
	round(price_change * 100, 2) AS price_percentage_change,
	round(LEAD(salary_change, 1) OVER (ORDER BY current_year) * 100, 2) AS next_year_salary_change_percentage, -- Umožní porovnat HDP v daném roce se změnou mezd v následujícím roce, to samé pro cenu
	round(LEAD(price_change, 1) OVER (ORDER BY current_year) * 100, 2) AS next_year_price_change_percentage
FROM yearly_changes
ORDER BY current_year;