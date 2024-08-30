Class common.conversion
{

/// Convert an Excel file to a CSV file
ClassMethod XLStoCSV(source As %String = "/data/sample.xlsx") As %Status [ Language = python ]
{
  import pandas as pd
  read_file = pd.read_excel(source)
  read_file.to_csv(source+'.csv', index = None, header=True, encoding='utf-8',sep='\\')
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

}
