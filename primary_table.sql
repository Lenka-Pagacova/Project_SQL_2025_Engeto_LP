CREATE TABLE IF NOT EXISTS t_lenka_pagacova_project_sql_primary_final AS 
	WITH YearlyPayroll AS (
	    SELECT
	        payroll_year,
	        industry_branch_code,
	        ROUND(AVG(value)::numeric, 2) AS avg_gross_salary_value_yearly -- Vypočítám průměrnou roční mzdu
	    FROM
	        czechia_payroll
	    WHERE
	        value_type_code = 5958 -- Průměrná hrubá mzda na zaměstnance
	        AND calculation_code = 100 -- kód pro čistou mzdu
	    GROUP BY
	        payroll_year,
	        industry_branch_code
	),
	YearlyPrices AS (
	    SELECT
	        DATE_PART('year', date_from) AS price_year,
	        category_code,
	        ROUND(AVG(value)::numeric, 2) AS product_price_value_yearly -- Vypočítám průměrnou roční cenu
	    FROM
	        czechia_price
	    WHERE
	        region_code IS NULL -- Celorepublikový průměr
	    GROUP BY
	        DATE_PART('year', date_from),
	        category_code
	)
	SELECT
	    yp.industry_branch_code AS industry_index,
	    cpib.name AS industry_name,
	    yp.payroll_year AS year, -- Rok (sjednocený)
	    yp.avg_gross_salary_value_yearly, -- Roční průměr mezd
	    ypc.category_code AS product_code,
	    cpc.name AS product_name,
	    cpc.price_value AS amount_of_product_base,
	    cpc.price_unit AS product_unit,
	    ypc.product_price_value_yearly -- Roční průměr cen
	FROM
	    YearlyPayroll AS yp
	JOIN
	    YearlyPrices AS ypc
	    ON yp.payroll_year = ypc.price_year
	LEFT JOIN -- Používám LEFT JOIN, protože některé industry nemusí mít ceny za produkty
	    czechia_price_category AS cpc
	    ON ypc.category_code = cpc.code
	LEFT JOIN -- Používám LEFT JOIN, pro případ, že by chyběla nějaká odvětví v payroll
	    czechia_payroll_industry_branch AS cpib
	    ON yp.industry_branch_code = cpib.code
	ORDER BY
	    yp.payroll_year,
	    yp.industry_branch_code,
	    ypc.category_code;
	
	
