# Which countries have shown the most consistent increase in clean electricity generation over the last  three decades?
SELECT Area, `Year`, Variable, Value AS 'Value in %', 
SUM(Value) OVER(PARTITION BY  Area, Variable ORDER BY Area, Year)  Rolling_Total
FROM euyearltwo
WHERE Category = 'Electricity generation' AND 
Variable IN ('Hydro, bioenergy and other renewables', 'Clean', 'Renewables','Wind and solar','Wind' ) AND
Unit = '%' AND
Value > 0 AND
Area != 'EU'
ORDER BY Year DESC,`Value` DESC, Area
;

SELECT ROW_NUMBER() OVER() AS Position, Area, `Year`, Variable, `Value in %`, `Rolling_Total`
FROM (SELECT Area, `Year`, Variable, Value AS 'Value in %', 
SUM(Value) OVER(PARTITION BY  Area, Variable ORDER BY Area, Year)  Rolling_Total
FROM euyearltwo
WHERE Category = 'Electricity generation' AND 
Variable IN ('Hydro, bioenergy and other renewables', 'Clean', 'Renewables','Wind and solar','Wind' ) AND
Unit = '%' AND
Value > 0 AND
Area != 'EU'
ORDER BY Year DESC,`Value` DESC, Area) AS Increas_Green_Energy_Production_Percent;



# Compare the trends in coal usage in electricity generation among EU vs. non-EU countries.
SELECT Area, `Year`, EU, Category, Variable, Unit, Value, SUM(Value) OVER(PARTITION BY  Area, Variable ORDER BY Area, Year)  Rolling_Total 
FROM euyearltwo
WHERE EU = "Yes" AND
Category = "Electricity generation" AND
Variable = "Coal" AND
Unit = "TWh"
UNION 
SELECT Area, `Year`, EU, Category, Variable, Unit, Value, SUM(Value) OVER(PARTITION BY  Area, Variable ORDER BY Area, Year)  Rolling_Total 
FROM euyearltwo
WHERE EU = "No" AND
Category = "Electricity generation" AND
Variable = "Coal" AND
Unit = "TWh";

# Which G20 countries in Europe have reduced fossil fuel usage the fastest in percentage terms?
SELECT * FROM euyearltwo
WHERE G20 = 'Yes' AND
Variable = "Fossil" AND
Category = "Electricity generation";

SELECT Area , SUM(`YoY % change`), SUM(`YoY absolute change`) FROM euyearltwo
WHERE G20 = 'Yes' AND
Variable = "Fossil" AND
Category = "Electricity generation" AND
`YoY absolute change` < 0 AND
`YoY % change` < 0
GROUP BY Area
ORDER BY SUM(`YoY % change`) ASC
;



