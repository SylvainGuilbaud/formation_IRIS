SELECT 
a.id
,a.gender
,a.date_birth
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
,a.smoking_status
,a.stroke
FROM SQLUser.stroke_data_raw as a
JOIN sqluser.zip_codes as b
on a.zip = b.zip