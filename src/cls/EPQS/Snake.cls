/// EPQS.Snake 
/// for use with 
/// Embedded Python QuickStart 
/// learning.intersystems.com/course/view.php?name=EPQS
/// 
/// Properties
///     Species
///     Measurements
/// 
/// Methods                     [Language]
///     %OnNew                  [ObjectScript]
///     NewMeasurementA         [ObjectScript]
///     NewMeasurementB         [Python]
///     SummarizeA              [ObjectScript]
///     SummarizeB              [Python]
///     GrowthChartA            [ObjectScript]
///     GrowthChartB            [Python]
/// 
Class EPQS.Snake Extends %Persistent
{

/// Species of the snake
Property Species As %String;

/// List of measurements of the snakes. 
/// Each measurement has a length, weight, and date.
Property Measurements As array Of EPQS.Measurement [ SqlFieldName = Meas ];

/// Create and save a new snake with no measurements taken yet.
/// Arguments
///      Species
Method %OnNew(Species As %String) As %Status
{
    set ..Species = Species
    return 1
}

/// Add a new measurement for a snake
/// Written in ObjectScript
/// Arguments
///      Length
///      Weight
Method NewMeasurementA(Length As %Numeric, Weight As %Numeric) As %Status
{
    // Using this snake's ID and the given length and weight, create and save a new measurement.
    set newMeasurement = ##class(EPQS.Measurement).%New(Length, Weight)

    // Add new measurement to array of measurements for this snake
    set nextIndex = ..Measurements.Count() + 1
    do ..Measurements.SetAt(newMeasurement, nextIndex)

    // Save this snake
    return ..%Save()
}

/// Add a new measurement for a snake
/// Written in Python
/// Arguments
///      Length
///      Weight
Method NewMeasurementB(Length As %Numeric, Weight As %Numeric) As %Status [ Language = python ]
{
# import the python package iris for access to IRIS classes.
import iris

# Using this snake's ID and the given length and weight, create and save a new measurement.
new_measurement = iris.cls('EPQS.Measurement')._New(Length,Weight)

# Add new measurement to array of measurements for this snake
next_index = self.Measurements.Count() + 1
self.Measurements.SetAt(new_measurement, next_index)

# save this snake
return self._Save()
}

/// Access properties and print to terminal
/// Written in ObjectScript
Method SummarizeA() As %Status
{
    // send summary info to console
    write !, "Snake ID: ",..%Id()
    write !, "Species: ",..Species
    write !,..Measurements.Count(), " Measurements"

    // return okay status
    return 1
}

/// Access a snake's properties and print to terminal
/// Written in Python
Method SummarizeB() As %Status [ Language = python ]
{

# send summary info to console
print("Snake ID: " + str(self._Id()) + "\r")
print("Species: " + self.Species + "\r")
print(str(len(self.Measurements)) + " Measurements\r")

# return OK status
return 1
}

/// Print pandas dataframe of measurements
/// Written in ObjectScript
Method GrowthChartA() As %Status
{
    // Use %SYS.Python.Import to import pandas
    set pandas = ##class(%SYS.Python).Import("pandas")

    // Create and execute SQL query to retrieve measurements data.
    set tSQL = "select Snake, element_key, Length, Weight, ""date"" "_ 
                "from EPQS.Measurement as measurement "_ 
                "inner join EPQS.Snake_Meas as sm "_
                "on sm.Meas = measurement.ID "_
                "where Snake = "_..%Id()

    set tStatement = ##class(%SYS.Python.SQL).prepare(tSQL)
    set tResult = tStatement.execute()

    // Convert SQL result set to pandas dataframe using %SYS.Python.SQLResultSet method dataframe()
    set df = tResult.dataframe()

    // Convert dataframe to terminal-friendly string, print
    set dfstring = df."to_string"()
    set dfstring = $replace(dfstring, $c(10), $c(13,10))
    write !, dfstring

    // Return OK status
    return 1
}

/// Print pandas dataframe of a snake's measurements
/// Written in Python
Method GrowthChartB() As %Status [ Language = python ]
{

# import needed libraries
import iris
import pandas as pd

# create and execute SQL queries to get snake measurement;
q = 'select Snake, element_key, Length, Weight, "date" '\
'from EPQS.Measurement as measurement '\
'inner join EPQS.Snake_Meas as sm '\
'on sm.Meas = measurement.ID '\
f'where Snake = {self._Id()}'

rs = iris.sql.exec(q)

# convert SQL result set to pandas dataframe
df = rs.dataframe()

# convert dataframe to terminal-friendly string, print
dfstring = df.to_string()
dfstring = dfstring.replace("\n","\n\r")
print(dfstring)

# return OK status
return 1
}

Storage Default
{
<Data name="Measurements">
<Attribute>Measurements</Attribute>
<Structure>subnode</Structure>
<Subscript>"Measurements"</Subscript>
</Data>
<Data name="SnakeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Species</Value>
</Value>
</Data>
<DataLocation>^EPQS.SnakeD</DataLocation>
<DefaultData>SnakeDefaultData</DefaultData>
<IdLocation>^EPQS.SnakeD</IdLocation>
<IndexLocation>^EPQS.SnakeI</IndexLocation>
<StreamLocation>^EPQS.SnakeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
