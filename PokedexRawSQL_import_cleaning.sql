#Create Database To Query In
CREATE DATABASE PokemonProject;

#Declare What Database You Want To Work In
use PokemonProject;


#Create A Table To Import Extracted Data Into 
CREATE TABLE PokedexRaw
(redundant int
,Pokedex int
,Name varchar(25)
,Type varchar(60)
,Total varchar(25)
,HP varchar(25)
,Attack varchar(25)
,Defense varchar(25)
,SpecialAttack varchar(25)
,SpecialDefense varchar(25)
,Speed varchar(25)
);

#Correct Varchar Length (Leave for Future Resolution)
ALTER TABLE PokedexRaw
MODIFY Name VARCHAR(60);

#Show any restrictions for import/export feature Whic is the default in most MySQL settings (Not recommended for Professional Environments)
SHOW GLOBAL VARIABLES LIKE 'secure_file_priv';

#in C>ProgramData(HiddenFIle)>MySQL>MySQL Server 8.2>my
#comment out the original secure path file and create a new path set to null. Double up on backslashes
#next time test the same command from a local path

#This is the code snippet to import csv data into the table. (Issues with mysql pathfinder made us double up on backslashes)
#Ignore 1 LINES Code prevents duplication of header information
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.2\\Uploads\\Pokemon2024.csv"
INTO TABLE PokedexRaw
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#We have a duplication in our extracted data that will need cleaned. 1208/2417
#This code snippet gives us permission to delete alter and update our dataset.
SET SQL_SAFE_UPDATES = 0;

#Delete the duplication in files imported into the table.
DELETE
FROM PokedexRaw
WHERE redundant > 1208;


#I personally dont consider mega evolutions as seperate pokemon. I will not happen upon a mega evolution in the wild. 
#This query selects any pokemon with 'mega' in their name to confirm we only delte mega evolutions
SELECT *
FROM PokedexRaw
WHERE Name LIKE '%mega%';
#The results of our query show two records that need considered when deleting ur mega evolutions
#469 = Yanmega
#154 = Meganium

DELETE 
FROM PokedexRaw
WHERE Name LIKE '%mega%' and Pokedex <> 154 and Pokedex <> 469;

#Change our column name.
ALTER TABLE PokedexRaw
CHANGE redundant ID int;

#Add a new column to hold our type two information
ALTER TABLE PokedexRaw
ADD TypeTwo varchar(25);
#Add all type information into type two column
UPDATE PokedexRaw
SET TypeTwo = Type;



#-------------------------------------------------------------------------------------------------------
SELECT *
FROM PokedexRaw
WHERE Type = 'Fire' or Type = 'Water' or Type = 'Poison' or Type = 'Grass' or 
	  Type = 'Flying' or Type = 'Bug' or Type = 'Electric' or Type = 'Ice' or
      Type = 'Fighting' or Type = 'Normal' or Type = 'Fighting' or Type = 'Fairy' or
      Type = 'Dark' or Type = 'Ghost' or Type ='Steel' or Type = 'Dragon' or
      Type = 'Rock' or Type = 'Psychic';


UPDATE PokedexRaw
SET TypeTwo = ''
WHERE TypeTwo = 'Fire' or TypeTwo = 'Water' or TypeTwo = 'Poison' or TypeTwo = 'Grass' or 
	  TypeTwo = 'Flying' or TypeTwo = 'Bug' or TypeTwo = 'Electric' or TypeTwo = 'Ice' or
      TypeTwo = 'Fighting' or TypeTwo = 'Normal' or TypeTwo = 'Fighting' or TypeTwo = 'Fairy' or
      TypeTwo = 'Dark' or TypeTwo = 'Ghost' or TypeTwo ='Steel' or TypeTwo = 'Dragon' or
      TypeTwo = 'Rock' or TypeTwo = 'Psychic' or TypeTwo = 'Ground';


UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Fire ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Water ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Poison ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Grass ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Flying ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Bug ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Electric ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Ice ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Fighting ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Normal ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Fairy ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Dark ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Ghost ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Steel ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Dragon ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Rock ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Ground ','');
UPDATE PokedexRaw
SET TypeTwo = REPLACE(TypeTwo, 'Psychic ','');

#----------------------------------------------------------------------------------------------

UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Fire','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Water','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Poison','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Grass','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Flying','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Bug','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Electric','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Ice','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Fighting','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Normal','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Fairy','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Dark','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Ghost','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Steel','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Dragon','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Rock','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Ground','');
UPDATE PokedexRaw
SET Type = REPLACE(Type, ' Psychic','');

SELECT *
FROM PokedexRaw;

DROP TABLE PokedexRaw;

SELECT ID, Pokedex, Name, Type, TypeTwo, HP, Attack, Defense, SpecialAttack, SpecialDefense, Speed, Total
From PokedexRaw
INTO OUTFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.2\\Uploads\\PokedexRaw.csv"
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'