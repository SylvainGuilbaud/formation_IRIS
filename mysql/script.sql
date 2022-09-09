CREATE DATABASE formation CHARACTER SET = utf8mb4;
USE formation
CREATE USER 'formation' IDENTIFIED BY 'formation';
GRANT ALL ON formation.* TO 'formation';
CREATE TABLE formation.patient (
	id int NOT NULL,
    LastName varchar(255),
    FirstName varchar(255),
    DOB date,
    Sex varchar(10),
    PRIMARY KEY (id)
);