# Which countries have shown the most consistent increase in clean electricity generation over the last  three decades? - done
CREATE TEMPORARY TABLE CleanEnergyGen
SELECT ROW_NUMBER() OVER() AS Position,  Area, `Year`, Variable, `Value in %`, `Rolling_Total`
FROM (SELECT Area, `Year`, Variable, Value AS 'Value in %', 
SUM(Value) OVER(PARTITION BY  Area, Variable ORDER BY Area, Year)  Rolling_Total
FROM euyearltwo
WHERE Category = 'Electricity generation' AND 
Variable IN ('Hydro, bioenergy and other renewables', 'Clean', 'Renewables','Wind and solar','Wind' ) AND
Unit = '%' AND
Value > 0 AND
Area != 'EU'
ORDER BY Year DESC,`Value` DESC, Area) AS Increas_Green_Energy_Production_Percent;

SELECT *
INTO OUTFILE 'D:/Branko/Projects/Data Analyst/Data sheets - excel/CleanEnergyGen.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
FROM CleanEnergyGen;

# Compare the trends in coal usage in electricity generation among EU vs. non-EU countries. - done
CREATE TEMPORARY TABLE CoalUsageCountries
SELECT Area, `Year`, CASE WHEN EU = 'Yes' THEN "EU" ELSE "non-EU" END AS EU_STATUS, Category, Variable, Unit, Value, SUM(Value) OVER(PARTITION BY  Area, Variable ORDER BY Area, Year)  Rolling_Total 
FROM euyearltwo
WHERE
Category = "Electricity generation" AND
Variable = "Coal" AND
Unit = "TWh" AND
Area != 'EU'
ORDER BY `EU_STATUS`;

SELECT *
INTO OUTFILE 'D:/Branko/Projects/Data Analyst/Data sheets - excel/CoalUsageCountries.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
FROM CoalUsageCountries;


# Which G20 countries in Europe have reduced fossil fuel usage the fastest in percentage terms? - done
SELECT Area , SUM(`YoY % change`), SUM(`YoY absolute change`) FROM euyearltwo
WHERE G20 = 'Yes' AND
Variable = "Fossil" AND
Category = "Electricity generation" AND
`YoY absolute change` < 0 AND
`YoY % change` < 0
GROUP BY Area
ORDER BY SUM(`YoY % change`) ASC
;

SELECT *
INTO OUTFILE 'D:/Branko/Projects/Data Analyst/Data sheets - excel/ReducedFossilFuel.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
FROM ReducedFossilFuel;

# Identify the top 5 countries with the highest per capita electricity demand in the latest available year. - done

SELECT Area, Year, Category, Variable, Value as highest_per_capita FROM euyearltwo
WHERE `Year` = 2024 AND
Category = "Electricity demand" AND
Variable = 'Demand per capita'
ORDER BY `highest_per_capita` DESC
LIMIT 0, 5;

CREATE TEMPORARY TABLE HighElectricityDemand
SELECT Area, Year, Category, Variable, Value as highest_per_capita FROM euyearltwo
WHERE `Year` = 2024 AND
Category = "Electricity demand" AND
Variable = 'Demand per capita'
ORDER BY `highest_per_capita` DESC;
#LIMIT 0, 5;

SELECT *
INTO OUTFILE 'D:/Branko/Projects/Data Analyst/Data sheets - excel/HighElectricityDemand.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
FROM HighElectricityDemand;

# Which country had the largest year-over-year drop in coal-based electricity generation in any year? - done
SELECT Area, Year, Category, Variable, Value,`YoY % change`, `YoY absolute change` FROM euyearltwo
WHERE Variable = 'Coal' AND
Category = "Electricity Generation" AND
`YoY % change` is not null
ORDER BY `YoY % change` ASC
LIMIT 1;
