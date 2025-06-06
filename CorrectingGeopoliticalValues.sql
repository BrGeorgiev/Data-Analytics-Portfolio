CREATE TABLE worktable LIKE euyearltwo;
INSERT INTO worktable SELECT * FROM euyearltwo;
SELECT * FROM worktable;


#България става член на Европейския съюз 1 Януари 2007, а данните показват, че винаги е била (Същото важи и за Румъния)
SELECT Area, Year, EU from worktable
WHERE (Area = "Bulgaria" OR Area = "Romania")
AND Year BETWEEN 1990 and 2006;

UPDATE worktable
SET EU = "No"
WHERE (Area = "Bulgaria" OR Area = "Romania")
AND Year BETWEEN 1990 and 2006;
# Проверка за всички останали държави в ЕС
-- 1. от 95' : Австрия, Финландия, Швеция

SELECT DISTINCT Area, Year, EU from worktable
WHERE (Area = "Austria" OR Area = "Finland" OR Area = "Sweden")
AND Year BETWEEN 1990 and 1994;

UPDATE worktable
SET EU = "No"
WHERE (Area = "Austria" OR Area = "Finland" OR Area = "Sweden")
AND Year BETWEEN 1990 and 1994;

-- 2. 04' Естония, Кипър, Латвия, Литва, Малта, Полша, Словакия, Словения, Унгария, Чехия
-- Cyprus, Malta, Poland, Slovenia, Slovakia, Hungary, Czechia, Estonia, Latvia, Lithuania
select distinct area, Year, EU from worktable
WHERE Area IN 
("Cyprus", "Poland", "Malta", "Slovenia", "Slovakia", 
"Hungary", "Czehua", "Estonia", "Latvia", "Lithuania")
AND  Year between 1990 and 2004;

UPDATE worktable
SET EU = "No"
WHERE Area IN 
("Cyprus", "Poland", "Malta", "Slovenia", "Slovakia", 
"Hungary", "Czehua", "Estonia", "Latvia", "Lithuania")
AND  Year between 1990 and 2004;

-- 3 от 13' - Хърватия

SELECT DISTINCT Area, Year, EU from worktable
WHERE Area = "Croatia"
AND  Year between 1990 and 2012;

UPDATE worktable
SET EU = "No"
WHERE Area = "Croatia"
AND  Year between 1990 and 2012;
-- 4 Великобритания е членка от 1973 до 2020 (в нашия случай от 1990)

SELECT distinct Area, Year, EU from worktable
where Area LIKE "%Kingdom";

UPDATE worktable
SET EU = "Yes"
WHERE Area LIKE "%Kingdom"
AND Year BETWEEN 1990 AND 2020

