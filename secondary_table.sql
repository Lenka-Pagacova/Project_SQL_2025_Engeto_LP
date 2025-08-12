CREATE TABLE IF NOT EXISTS t_lenka_pagacova_project_SQL_secondary_final AS 
	SELECT 
		c.country,
		c.continent,
		e.population,
		c.population_density,
		c.surface_area,
		e.gdp,
		e.gini,
		e.YEAR,
		c.government_type
	FROM countries AS c
		JOIN economies AS e
			ON c.country = e.country
			AND c.continent = 'Europe'
			AND c.country NOT IN ('Gibraltar', 'Faroe Islands') -- Gibraltar patří pod Británii a Faroe Islands patří pod Dánsko, proto jsem tyto země vyřadila jelikož se nejedná o samostatný stát
			;

	
	
