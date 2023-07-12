-- DROP TABLE Sample.Person
-- CREATE TABLE Sample.Person (
--         Name VARCHAR(25),
--         Age INT,
--         DOB DATE)

-- select * from Sample.Person

-- delete from Sample.Person

-- LOAD DATA FROM FILE '/data/sampledata/Sample.Person.csv' INTO Sample.Person

-- DROP TABLE Foteex_DigHU.sv8_Reent
-- CREATE TABLE Foteex_DigHU.sv8_Reent (
--     Reading VARCHAR(50),
--     Type_S_F VARCHAR(1),
--     Ch_1 numeric,
--     Ch_2 numeric,
--     "Ch_%RH" numeric,
--     "Ch_%PWM" numeric,
--     Ch_3 numeric,
--     Ch_RPM numeric,
--     Ch_4 numeric,
--     Ch_HMR numeric,
--     "Ch_%RH_atm" numeric,
--     "Ch_%Mv" numeric,
--     Int_T numeric
-- )

-- LOAD DATA FROM FILE '/data/(DigHU).sv8-Reent.csv' INTO Foteex_DigHU.sv8_Reent

-- select type_s_f,count(*) from Foteex_DigHU.sv8_Reent
-- group by Type_S_F

-- DROP TABLE Foteex_AV.sv8_sventh
-- CREATE TABLE Foteex_AV.sv8_sventh (
--     Reading VARCHAR(50),
--     Type_S_F VARCHAR,
--     Ch_1 numeric,
--     Ch_2 numeric,
--     Ch_A numeric,
--     Avg_V numeric,
--     Avg_VL numeric,
--     Avg_VC numeric,
--     Avg_VR numeric,
--     Int_T numeric
-- )

-- LOAD DATA FROM FILE '/data/Foteex.sv8-sventhv1.csv' INTO Foteex_AV.sv8_sventh

-- select * from Foteex_AV.sv8_sventh

-- select count(*) from Foteex_AV.sv8_sventh
-- where Type_S_F='S'

-- select type_s_f,count(*) from Foteex_AV.sv8_sventh
-- group by Type_S_F

update Foteex_DigHU.sv8_Reent set reading = '0000'||reading
where length(reading)=1

update Foteex_DigHU.sv8_Reent set reading = '000'||reading
where length(reading)=2

update Foteex_DigHU.sv8_Reent set reading = '00'||reading
where length(reading)=3

update Foteex_DigHU.sv8_Reent set reading = '0'||reading
where length(reading)=4

update Foteex_AV.sv8_sventh set reading = '0000'||reading
where length(reading)=1

update Foteex_AV.sv8_sventh set reading = '000'||reading
where length(reading)=2

update Foteex_AV.sv8_sventh set reading = '00'||reading
where length(reading)=3

update Foteex_AV.sv8_sventh set reading = '0'||reading
where length(reading)=4
