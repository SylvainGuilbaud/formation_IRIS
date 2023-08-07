# python cheat sheet

stroke_df = pd.DataFrame(patientlist, columns=['gender', 'age', 'ever_married',
'hypertension', 'heart_disease', 'work_type', 'Residence_type',
'avg_glucose_level', 'bmi', 'smoking_status'])

categorical_features = stroke_df.select_dtypes(include='object').columns
for col in categorical_features:
    stroke_df[col] = stroke_df[col].astype('category')
    
model = XGBClassifier()
model.load_model("/tmp/xgboost_export.json")
preds_proba = model.predict_proba(stroke_df)[:,1]

return preds_proba.tolist()
# https://www.youtube.com/watch?v=m4tfzds6weo
# https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa0ViWlhhczFpMmNMcDdHQ1ZSNktHSlgta0U4Z3xBQ3Jtc0tsMy1uVm8yYkszSkptSDhxWGxzc2dndUdvZE52QzZaYUhYVF9kenRGb0lwd3RyZk5nODJ5S1NQUkdfUjRTa2x3Z3lkNWU2N0ZOaW5hSDlQMTlwRFBySHpub1RLYnFaT2hiYVdHa293SU9tZW9YSHhkUQ&q=http%3A%2F%2Fwww.donwoodlock.com%2FML202-May2023%2Fml-isc.v3.zip&v=m4tfzds6weo