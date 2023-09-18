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

ClassMethod convertirXLSRudo1toCSV(source As %String) As %Status [ Language = python ]
{

    import pandas as pd

    read_file = pd.read_excel(source)

    read_file.to_csv(source+'.csv', index = None, header = True, encoding='utf-8')
}

}
