/// EPQS.Measurement.cls for use with EPQS.Snake
/// Properties
///     Length
///     Weight
///     Date
/// 
Class EPQS.Measurement Extends %Persistent
{

/// Length of the snake in centimeters
Property Length As %Numeric;

/// Weight of the snake in grams
Property Weight As %String;

/// Date of the measurement
Property Date As %Date;

/// Log a new measurement, taking the current time
/// Arguments
///     Length
///     Weight
Method %OnNew(Length As %Numeric, Weight As %Numeric) As %Status [ Private, ServerOnly = 1 ]
{
    set ..Length = Length
    set ..Weight = Weight
    set ..Date = +$ztimestamp
    set sc = ..%Save()
    Quit sc
}

Storage Default
{
<Data name="MeasurementDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Length</Value>
</Value>
<Value name="3">
<Value>Weight</Value>
</Value>
<Value name="4">
<Value>Date</Value>
</Value>
</Data>
<DataLocation>^EPQS.MeasurementD</DataLocation>
<DefaultData>MeasurementDefaultData</DefaultData>
<IdLocation>^EPQS.MeasurementD</IdLocation>
<IndexLocation>^EPQS.MeasurementI</IndexLocation>
<StreamLocation>^EPQS.MeasurementS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
