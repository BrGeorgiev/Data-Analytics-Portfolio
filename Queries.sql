# YoY absolute change ,YoY % change
# Производство на енергия в Twh
SELECT `Area`,Variable, Unit, SUM(`Value`) AS Sum FROM euyearlTwo
WHERE Area != "EU" AND Variable = "Coal" AND Unit = "TWh"
group by Area, Variable, Unit
ORDER BY SUM(`value`) DESC;


SELECT Area, Year, Category, Variable, Unit, Value, `YoY absolute change` FROM euyearltwo
WHERE `YoY absolute change` > 0 AND Area = "Bulgaria" and Variable = "Net imports"
;
SELECT Area, Year, Variable, Unit, Value FROM euyearltwo
WHERE Variable = "Demand" AND Area = "Bulgaria"
ORDER BY Value DESC;
-- Анализ на Германия
-- Тенденция - намаляване на въглеродните емисии от 2000 до 2020
SELECT Area , Year, Category, Variable, Unit, Value FROM euyearltwo
WHERE Area = "Germany" AND 
(Year between 2000 AND 2020) AND 
Category = "Power sector emissions" AND 
Variable = "CO2 intensity"
ORDER BY Year DESC;

-- Наблюдение след обявения Atomausstieg

SELECT Area, Year, Category, Variable, Unit, Value, `YoY absolute change`, `YoY % change` FROM euyearltwo
WHERE Area = "Germany" and 
Variable = "Nuclear" AND 
Year between 2011 AND 2020 AND
Unit = "TWh"
ORDER BY `YoY % change` asc;

SELECT Area, SUM(`YoY % change`) FROM euyearltwo
WHERE Area = "Germany" and 
Variable = "Nuclear" AND 
Year between 2011 AND 2020 AND
Unit = "TWh"
GROUP BY Area

