-- CREATE DATABASE formation CHARACTER SET = utf8mb4;
-- USE formation
CREATE USER 'formation' IDENTIFIED BY 'formation';
GRANT ALL ON formation.* TO 'formation';
CREATE TABLE formation.personne (
	id int NOT NULL,
    LastName varchar(255),
    FirstName varchar(255),
    DOB date,
    Sex varchar(10),
    FirstAction varchar(255),
    LastAction varchar(255),
    PRIMARY KEY (id)
);