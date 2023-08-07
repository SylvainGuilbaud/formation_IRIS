Class Demo.Web.REST Extends %CSP.REST
{

Parameter UseSession = 1;

Parameter CONVERTINPUTSTREAM = 1;

Parameter CHARSET = "utf-8";

Parameter HandleCorsRequest = 1;

XData UrlMap
{
<Routes>
        <!-- <Route Url="/probabilities" Method="GET" Call="IntegratedML"/> -->
        <Route Url="/probabilities" Method="GET" Call="EmbeddedPython"/>
    </Routes>
}

ClassMethod IntegratedML() As %Status
{
    #dim rs As %SQL.StatementResult
	#dim rsMetadata As %SQL.StatementMetadata

    set sc = $$$OK
    try {
        
        // Configuring response type to JSON
        set %response.ContentType = ..#CONTENTTYPEJSON
        
        // Creating the response object
        set response = {}
        set response.patients = []
        set response.requestResult = {}

		set table = "stroke_eval"
		kill qry
		set qry($increment(qry)) = "SELECT gender"
		set qry($increment(qry)) = ",age"
		set qry($increment(qry)) = ",hypertension"
		set qry($increment(qry)) = ",heart_disease"
		set qry($increment(qry)) = ",ever_married"
		set qry($increment(qry)) = ",work_type"
		set qry($increment(qry)) = ",zip"
		set qry($increment(qry)) = ",Residence_type"
		set qry($increment(qry)) = ",avg_glucose_level"
		set qry($increment(qry)) = ",bmi"
		set qry($increment(qry)) = ",smoking_status"
		// insert code for Step A3 below this line 
        set qry($increment(qry)) = ", PROBABILITY(StrokeModel USE StrokeModelTrained) as probability_stroke"
        
		set qry($increment(qry)) = $$$FormatText("FROM %1",table)
		set qry($increment(qry)) = "WHERE 1=1"
			
        set statement = ##class(%SQL.Statement).%New()
		if $$$ISERR(statement.%Prepare(.qry)){
			set sc = $$$ADDSC(sc,$$$ERROR($$$GeneralError,"Impossible to query data."))
			quit
		}
		set rs = statement.%Execute()
        set rsMetadata = rs.%GetMetadata()
        while rs.%Next() {
            set patient = {}
            for iCol=1:1:rsMetadata.columnCount {
                set col = rsMetadata.columns.GetAt(iCol)
                if (col.clientType=2) { // date
                    set $property(patient, col.colName) = $zdate(rs.%GetData(iCol), 3)
                } elseif col.clientType=8 { // time
                    set $property(patient, col.colName) = $ztime(rs.%GetData(iCol))
                } 
				else {
                        if (col.colName = "probability_stroke") {
                            set $property(patient, col.colName) = $fnumber(rs.%GetData(iCol),,5)
                            }
                        else {
                            set $property(patient, col.colName) = rs.%GetData(iCol)
                            }
                    }
            }
            do response.patients.%Push(patient)
        }
        set response.requestResult.status = "OK"
    } catch (err) {
        //
        // Ops! Something went wrong!
        //
        set response.requestResult.status="Error"
        set response.requestResult.exception=$System.Status.GetErrorText(err.AsStatus())
    }
    
    // Whatever the response is, let's send it
    write response.%ToJSON()
    
    return $$$OK
}

ClassMethod EmbeddedPython() As %Status
{
    #dim rs As %SQL.StatementResult
	#dim rsMetadata As %SQL.StatementMetadata
    set sc = $$$OK
    try {        
        // Configuring response type to JSON
        set %response.ContentType = ..#CONTENTTYPEJSON
        
        // Creating the response object
        set response = {}
        set response.patients = []
        set response.requestResult = {}
		set templist = {}
		set templist.patients = []
		
		set table = "stroke_eval"
		kill qry
		set qry($increment(qry)) = "SELECT gender"
		set qry($increment(qry)) = ",age"
		set qry($increment(qry)) = ",ever_married"
		set qry($increment(qry)) = ",hypertension"
		set qry($increment(qry)) = ",heart_disease"
		set qry($increment(qry)) = ",work_type"
		set qry($increment(qry)) = ",Residence_type"
		set qry($increment(qry)) = ",avg_glucose_level"
		set qry($increment(qry)) = ",bmi"
		set qry($increment(qry)) = ",smoking_status"
		set qry($increment(qry)) = $$$FormatText("FROM %1",table)
		set qry($increment(qry)) = "WHERE 1=1"
			
        set statement = ##class(%SQL.Statement).%New()
		if $$$ISERR(statement.%Prepare(.qry)){
			set sc = $$$ADDSC(sc,$$$ERROR($$$GeneralError,"Impossible to query data."))
			quit
		}
		set rs = statement.%Execute()
        set rsMetadata = rs.%GetMetadata()

        //instantiate Python builtins functionality and then use it to create a Python list that will hold all patients
        set builtins = ##class(%SYS.Python).Builtins()
        //insert code for Step B3 below this line
        set patientlist = builtins.list()


        set pythonpatient = ""
        while rs.%Next() {
            set patient = {}
            //instantiate a second Python list that will hold each individual patient's values  
            //insert code for Step B4 below this line
            set pythonpatient = builtins.list()

            for iCol=1:1:rsMetadata.columnCount {
                set col = rsMetadata.columns.GetAt(iCol)
                if (col.clientType=2) { // date
                    set $property(patient, col.colName) = $zdate(rs.%GetData(iCol), 3)
                    //add the column value to the Python list for this patient and format it properly since it is a date
                    if $IsObject(pythonpatient) do pythonpatient.append($zdate(rs.%GetData(iCol), 3))


                } elseif col.clientType=8 { // time
                    set $property(patient, col.colName) = $ztime(rs.%GetData(iCol))
                    //add the column value to the Python list for this patient and format it properly since it is a timestamp
                    if $IsObject(pythonpatient) do pythonpatient.append($ztime(rs.%GetData(iCol)))

                    
                } else {
					if (col.colName = "avg_glucose_level") || (col.colName = "bmi") {
						set $property(patient, col.colName) = $fnumber(rs.%GetData(iCol),,2)
					}
					else {
						set $property(patient, col.colName) = rs.%GetData(iCol)
					}
                    //add the column value to the Python list for this patient
                    if $IsObject(pythonpatient) do pythonpatient.append(rs.%GetData(iCol))

                    
                }
            }
            
            //now add the individual patient to the list of all patients and push them into a temporary JSON result
            //once we have the probability scores we will add those
            //insert code for Step B5 below this line 
            do patientlist.append(pythonpatient)
            //templist is the variable holding the JSON result that will go back to our Angular UI
            do templist.patients.%Push(patient)

        }
        set probs = ""
        //insert code for Step B6 below this line
        set probs = ..PythonProbabilities(patientlist)

        for i=1:1:probs.Count() {
               set prob = probs.GetAt(i)
               //retrieve the current patient from the temporary JSON list we built earlier
               set patient = templist.patients.%Get(i)
               if $get(patient) {
                   //add the probability score for that patient
                   set $property(patient,"probability_stroke") = $fnumber(prob,,5)
                   //add the patient to the overall JSON response that we will send back to the angular UI
                   do response.patients.%Push(patient)
               }
           }
    
        set response.requestResult.status = "OK"
    } catch (err) {
        //
        // Ops! Something went wrong!
        //
        set response.requestResult.status="Error"
        set response.requestResult.exception=$System.Status.GetErrorText(err.AsStatus())
    }
    
    // Whatever the response is, let's send it
    write response.%ToJSON()
    
    return $$$OK
}

ClassMethod PythonProbabilities(patientlist) [ Language = python ]
{
import pandas as pd
import numpy as np 
import pickle
from xgboost import XGBClassifier

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
}

}
