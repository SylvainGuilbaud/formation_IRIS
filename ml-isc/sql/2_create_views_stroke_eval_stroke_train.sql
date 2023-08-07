CREATE VIEW stroke_eval 
AS  
SELECT *
FROM stroke_data_processed
WHERE MOD(iris_id,10) in (0,1)

-- CREATE VIEW stroke_train 
-- AS  
-- SELECT *
-- FROM stroke_data_processed
-- WHERE MOD(iris_id,10) > 1

