Class common.conversion
{

/// Convert a string containing YYYYMMDDHHMISS to a $Horolog value
ClassMethod YYYYMMDDHHMISStoHorolog(YYYYMMDDHHMISS As %String = "20250327193900", ByRef TimeStamp As %TimeStamp) As %Date
{
  set TimeStamp=""
  set YYYY = $EXTRACT(YYYYMMDDHHMISS,1,4)
  set MM = $EXTRACT(YYYYMMDDHHMISS,5,6)
  set DD = $EXTRACT(YYYYMMDDHHMISS,7,8)
  set HH = $EXTRACT(YYYYMMDDHHMISS,9,10)
  set MI = $EXTRACT(YYYYMMDDHHMISS,11,12)
  set SS = $EXTRACT(YYYYMMDDHHMISS,13,14)

  set DATETIME=YYYY_MM_DD_"T"_HH_":"_MI_":"_SS
  set ERRORDATE = "NOT A VALID DATE"
  set HOROLOG=$ZDATETIMEH(DATETIME,8,,,,,,,,ERRORDATE)
  set ERRORTS = "NOT A VALID TIMESTAMP"
  set TimeStamp = $ZDATETIME(HOROLOG,3,,,,,,,,,ERRORTS)
 
  return HOROLOG
}

ClassMethod test() As %Status
{
  set source="/data/sample.xlsx"
  set sc = ..XLStoCSV(source)
  return sc
}

/// Convert Celsius to Fahrenheit
ClassMethod CelsiusToFahrenheit(input As %Numeric = 0) As %Numeric
{
  return $num((input * (9/5)) + 32,4)
}

/// Convert Fahrenheit to Celsius
ClassMethod FahrenheitToCelsius(input As %Numeric = 0) As %Numeric
{
  return $num((input - 32) * (5/9),4)
}

ClassMethod convertXLStoCSV(source As %String = "/data/CSV/SamplePerson.xlsx") As %Status [ Language = python ]
{
import os
from datetime import datetime
import pandas as pd
now = datetime.now()
name, _ = os.path.splitext(source)
read_file = pd.read_excel(source)
target = name + '_' + now.strftime("%Y%m%d_%H%M%S") +'.csv'
read_file.to_csv(target, index = None, header = True, encoding='utf-8')
print(f'CSV: {target}')
}

ClassMethod convertCSVtoXLS(source As %String = "/data/CSV/SamplePerson.csv") As %Status [ Language = python ]
{
import os
from datetime import datetime
import pandas as pd
now = datetime.now()
name, _ = os.path.splitext(source)
data = pd.read_csv(source)
target = name + '_' + now.strftime("%Y%m%d_%H%M%S") +'.xlsx'
data.to_excel(target, index=False, engine='openpyxl')
print(f'Excel: {target}')
}

/// Convert an Excel file to a CSV file
ClassMethod XLStoCSV(source As %String = "/data/sample.xlsx") As %Status [ Language = python ]
{
  import pandas as pd
  read_file = pd.read_excel(source)
  read_file.to_csv(source+'.csv', index = None, header=True, encoding='utf-8',sep='\\')
}

}
