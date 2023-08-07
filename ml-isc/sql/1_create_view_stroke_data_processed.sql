CREATE VIEW stroke_data_processed 
AS
SELECT 
a.%ID as iris_id
,a.id
,a.gender
,a.date_birth
,datediff('yyyy',a.date_birth,'12/31/2020') as age
,a.hypertension
,a.heart_disease
,a.ever_married
,a.work_type
,a.zip
,b.location
,b.residence_type
,a.avg_glucose_level
,a.height_in
,a.weight_lb
,CASE 
WHEN a.weight_lb = 0 
THEN NULL
ELSE ROUND(a.weight_lb / SQUARE(a.height_in) * 703,1)
END as BMI
,a.smoking_status
,a.stroke
FROM SQLUser.stroke_data_raw as a
JOIN sqluser.zip_codes as b
on a.zip = b.zip

-- SELECT * 
-- FROM stroke_data_processed

