-- CREATE VIEW stroke_data_processed 
-- AS
-- SELECT 
-- a.%ID as iris_id
-- ,a.id
-- ,a.gender
-- ,a.date_birth
-- ,datediff('yyyy',a.date_birth,'12/31/2020') as age
-- ,a.hypertension
-- ,a.heart_disease
-- ,a.ever_married
-- ,a.work_type
-- ,a.zip
-- ,b.location
-- ,b.residence_type
-- ,a.avg_glucose_level
-- ,a.height_in
-- ,a.weight_lb
-- ,CASE 
-- WHEN a.weight_lb = 0 
-- THEN NULL
-- ELSE ROUND(a.weight_lb / SQUARE(a.height_in) * 703,1)
-- END as BMI
-- ,a.smoking_status
-- ,a.stroke
-- FROM SQLUser.stroke_data_raw as a
-- JOIN sqluser.zip_codes as b
-- on a.zip = b.zip

-- CREATE VIEW stroke_eval 
-- AS  
-- SELECT *
-- FROM stroke_data_processed
-- WHERE MOD(iris_id,10) in (0,1)

-- CREATE VIEW stroke_train 
-- AS  
-- SELECT *
-- FROM stroke_data_processed
-- WHERE MOD(iris_id,10) > 1

-- CREATE MODEL StrokeModel
-- predicting(stroke)
-- FROM stroke_train

-- SELECT 
-- ID, CreatedAt, DefaultIDColumnFound, DefaultTrainedModel, DefaultTrainingQuery, Description, Name, PredictingColumnNames, PredictingColumnTypes, WithColumnNames, WithColumnText, WithColumnTypes
-- FROM %ML.Model

-- TRAIN MODEL StrokeModel as StrokeModelTrained

-- SELECT 
-- ID, Model, ModelName, ModelType, Provider, TrainedAt, TrainingRun
-- FROM %ML.TrainedModel

-- VALIDATE MODEL StrokeModel
-- AS StrokeValidation
-- USE StrokeModelTrained FROM stroke_eval

-- SELECT 
-- ID, CompletedAt, Log, Name, RunStatus, Settings, StartedAt, StatusCode, TrainedModel, TrainingRun, ValidationDuration, ValidationQuery
-- FROM %ML.ValidationRun

-- SELECT 
-- MODEL_NAME, TRAINED_MODEL_NAME, VALIDATION_RUN_NAME, METRIC_NAME, METRIC_VALUE, TARGET_VALUE
-- FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS

SELECT 
Stroke
,PREDICT(StrokeModel use StrokeModelTrained) as predicition
,PROBABILITY(StrokeModel USE StrokeModelTrained) as PROBABILITY
,*
from stroke_eval
order by PROBABILITY DESC