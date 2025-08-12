WITH product_annual_changes AS (
	SELECT 
		product_name,
		year,
		round(avg(product_price_value_yearly)::numeric, 2) AS avg_product_price_value, -- Půrměrná roční cena potravin
		LAG (round(avg(product_price_value_yearly)::numeric, 2), 1) OVER (PARTITION BY product_name ORDER BY year) AS avg_product_last_year -- Zjištění ceny z předchozího roku pro srovnání
	FROM
		t_lenka_pagacova_project_sql_primary_final tlppspf
	GROUP BY
		product_name,
		year
),
product_change AS (
	SELECT 
		product_name,
		year,
		(avg_product_price_value - avg_product_last_year) / avg_product_last_year AS product_price_change -- O kolik se změnila cena potravin oproti předchozímu roku
	FROM product_annual_changes
)
SELECT 
	product_name,
	round(sum(product_price_change) * 100, 2) AS total_price_percentage_change -- Součet všech cenových změn a přepočet na %
FROM 
	product_change
GROUP BY
	product_name
HAVING  
	round(sum(product_price_change) * 100, 2) IS NOT NULL 
ORDER BY
	round(sum(product_price_change) * 100, 2) ASC;


