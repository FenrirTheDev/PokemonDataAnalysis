SHOW DATABASES;
USE pokemonproject;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE CompletePokedexRaw
(ID int
,PokedexNumber int
,Name varchar(50)
,TypeOne varchar(25)
,TypeTwo varchar(25)
,HP int
,Attack int
,Defense int
,SpecialAttack int
,SpecialDefense int
,Speed int
,Total int
,PRIMARY KEY(ID)
);

DESCRIBE CompletePokedexRaw;

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.2\\Uploads\\PokedexRaw.csv"
INTO TABLE CompletePokedexRaw
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';


ALTER TABLE CompletePokedexRaw
ADD Generation int;

UPDATE CompletePokedexRaw
SET Generation = 1 
WHERE PokedexNumber > 0 and PokedexNumber < 152;

UPDATE CompletePokedexRaw
SET Generation = 2
WHERE PokedexNumber > 151 and PokedexNumber < 252;

UPDATE CompletePokedexRaw
SET Generation = 3
WHERE PokedexNumber > 251 and PokedexNumber < 387;

UPDATE CompletePokedexRaw
SET Generation = 4
WHERE PokedexNumber > 386 and PokedexNumber < 494;

UPDATE CompletePokedexRaw
SET Generation = 5
WHERE PokedexNumber > 493 and PokedexNumber < 650;

UPDATE CompletePokedexRaw
SET Generation = 6
WHERE PokedexNumber > 649 and PokedexNumber < 723;

UPDATE CompletePokedexRaw
SET Generation = 7
WHERE PokedexNumber > 722 and PokedexNumber < 810;

UPDATE CompletePokedexRaw
SET Generation = 8
WHERE PokedexNumber > 809 and PokedexNumber < 906;

UPDATE CompletePokedexRaw
SET Generation = 9
WHERE PokedexNumber > 905 and PokedexNumber < 1025;

INSERT INTO CompletePokedexRaw VALUES
(1209, 1205, 'Pecharunt', 'Poison','Ghost', 88, 88, 160, 88, 88, 88, 600, 9);

ALTER TABLE CompletePokedexRaw
ADD GenerationCount int;

SELECT Generation, COUNT(ID)
FROM CompletePokedexRaw
GROUP BY Generation
ORDER BY Generation;

UPDATE CompletePokedexRaw
SET GenerationCount = 130
WHERE Generation = 9;

SELECT *
FROM CompletePokedexRaw;

SELECT PokedexNumber
FROM CompletePokedexRaw
GROUP BY PokedexNumber
HAVING COUNT(*) >= 2;

#18 types


SELECT COUNT(ID) AS Pokemon_IN_TYPE, TypeOne
FROM CompletePokedexRaw
GROUP BY TypeOne;

SELECT Generation, AVG(Total)
FROM CompletePokedexRaw
GROUP BY Generation
ORDER BY Generation;

SELECT Generation, TypeOne, COUNT(TypeOne) AS GenerationAmount, GenerationCount, ROUND(COUNT(TypeOne)/GenerationCount * 100,2) AS GenerationPercentageOfTypeOne
FROM CompletePokedexRaw
#WHERE TypeOne = 'Bug'
GROUP BY Generation, TypeOne, GenerationCount
Order BY Generation, TypeOne;