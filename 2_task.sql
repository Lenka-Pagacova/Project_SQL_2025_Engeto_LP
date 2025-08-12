SELECT 
	product_name,
	year,
	round(avg(avg_gross_salary_value_yearly)::NUMERIC, 2) AS avg_salary, -- Zjištění průměrné roční mzdy
	round(avg(product_price_value_yearly)::NUMERIC, 2) AS avg_price_value, -- Zjištění průměrné roční ceny produktu
	round(avg(tlppspf.avg_gross_salary_value_yearly) / avg(product_price_value_yearly)) AS amount_of_product_to_salary, -- Kolik litrů / kg je možné si koupit při dané ceně + mzdě
	product_unit
FROM
	t_lenka_pagacova_project_sql_primary_final tlppspf
WHERE
	product_name IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované') -- Chci pouze mléko a chleba
	AND year IN (2006, 2018) -- První a poslední srovnatelné období
GROUP BY
	year,
	product_name,
	product_unit
ORDER BY
	product_name ASC;

