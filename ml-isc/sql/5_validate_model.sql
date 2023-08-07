VALIDATE MODEL StrokeModel
AS StrokeValidation
USE StrokeModelTrained FROM stroke_eval

-- SELECT 
-- ID, CompletedAt, Log, Name, RunStatus, Settings, StartedAt, StatusCode, TrainedModel, TrainingRun, ValidationDuration, ValidationQuery
-- FROM %ML.ValidationRun

-- SELECT 
-- MODEL_NAME, TRAINED_MODEL_NAME, VALIDATION_RUN_NAME, METRIC_NAME, METRIC_VALUE, TARGET_VALUE
-- FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS