
-- DROP TABLE  data.patient

-- CREATE TABLE data.patient (
--     patient_no VARCHAR(50)
--     ,Nom_de_Nais VARCHAR(50)
--     ,prenoms VARCHAR(50)
--     ,Date_de_Nais VARCHAR(50)
--     ,rue VARCHAR(50)
--     ,cp VARCHAR(50)
--     ,localite VARCHAR(50)
--     ,codepaysadr VARCHAR(50)
--     ,patient INT
-- )

-- DROP TABLE data.episode
-- CREATE TABLE data.episode (
--     patient INT
--     ,Admission_No VARCHAR(50)
-- )

-- delete from data.patient
-- INSERT INTO data.patient VALUES ('123','HENDRIX','Jimi','19421127','rue des Lilas','12345','Seattle','USA',1)
-- INSERT INTO data.episode VALUES (1,'123456789')

-- SELECT * from data.patient

-- SELECT * from data.episode

-- SELECT p.patient_no IPP 
--               , Admission_No IEP 
--               , Nom_de_Nais NOM_NAIS 
--               , prenoms PRENOM 
--               , $extract(Date_de_Nais, 7, 8) _ '/' _ $extract(Date_de_Nais, 5, 6) _ '/' _       $extract(Date_de_Nais, 1, 4) DAT_NAIS 
--               , rue ADR_CONT 
--              , cp ADR_COD_POS 
--              , localite ADR_NOM_VIL 
--              , codepaysadr ADR_PAY_COD 
  
--     FROM data.patient p 
--               , data.episode e 
--      WHERE Admission_No = 123456789 
--      AND p.patient=e.patient
