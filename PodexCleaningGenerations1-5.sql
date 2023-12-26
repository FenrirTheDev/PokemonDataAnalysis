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

SELECT *
FROM CompletePokedexRaw;

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