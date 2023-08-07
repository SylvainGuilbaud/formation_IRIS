CREATE MODEL StrokeModel
predicting(stroke)
FROM stroke_train

-- SELECT 
-- ID, CreatedAt, DefaultIDColumnFound, DefaultTrainedModel, DefaultTrainingQuery, Description, Name, PredictingColumnNames, PredictingColumnTypes, WithColumnNames, WithColumnText, WithColumnTypes
-- FROM %ML.Model