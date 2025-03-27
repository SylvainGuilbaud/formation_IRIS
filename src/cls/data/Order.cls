Class data.Order Extends %Persistent
{

/// unique ID
Property uid As %String(MAXLEN = 256);

/// order status
Property orderStatus As %String(MAXLEN = 128);

/// requested ship date
Property requestedShipDate As %DateTime;

Method requestedShipDateSet(value As %String) As %Status
{
    if value="" {
        set i%requestedShipDate=""
    } elseif $LENGTH(value)=8 {
        set HOROLOG=##class(common.conversion).YYYYMMDDHHMISStoHorolog(value,.DateTime)
        set i%requestedShipDate=DateTime
    }
    set HOROLOG=##class(common.conversion).YYYYMMDDHHMISStoHorolog(value,.DateTime)
    set i%requestedShipDate=DateTime
    quit $$$OK
}

/// requested delivery date
Property requestedDeliveryDate As %DateTime;

Method requestedDeliveryDateSet(value As %String) As %Status
{
    set HOROLOG=##class(common.conversion).YYYYMMDDHHMISStoHorolog(value,.DateTime)
    set i%requestedDeliveryDate=DateTime
    quit $$$OK
}

/// committed ship date
Property committedShipDate As %DateTime;

Method committedShipDateSet(value As %String) As %Status
{
    set HOROLOG=##class(common.conversion).YYYYMMDDHHMISStoHorolog(value,.DateTime)
    set i%committedShipDate=DateTime
    quit $$$OK
}

/// committed delivery date
Property committedDeliveryDate As %DateTime;

Method committedDeliveryDateSet(value As %String) As %Status
{
    set HOROLOG=##class(common.conversion).YYYYMMDDHHMISStoHorolog(value,.DateTime)
    set i%committedDeliveryDate=DateTime
    quit $$$OK
}

/// order placed date
Property orderPlacedDate As %Date;

Method orderPlacedDateSet(value As %String) As %Status
{
    set i%orderPlacedDate=+##class(common.conversion).YYYYMMDDHHMISStoHorolog(value)
    quit $$$OK
}

/// change order date
Property changeOrderDate As %DateTime;

/// order value
Property orderValue As %Numeric;

/// order currency
Property orderCurrency As %String(MAXLEN = 128);

/// data source
Property dataSource As %String(MAXLEN = 128);

/// source order ID
Property sourceOrderId As %String(MAXLEN = 256);

Storage Default
{
<Data name="OrderDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>uid</Value>
</Value>
<Value name="3">
<Value>orderStatus</Value>
</Value>
<Value name="4">
<Value>requestedShipDate</Value>
</Value>
<Value name="5">
<Value>requestedDeliveryDate</Value>
</Value>
<Value name="6">
<Value>committedShipDate</Value>
</Value>
<Value name="7">
<Value>committedDeliveryDate</Value>
</Value>
<Value name="8">
<Value>orderPlacedDate</Value>
</Value>
<Value name="9">
<Value>changeOrderDate</Value>
</Value>
<Value name="10">
<Value>orderValue</Value>
</Value>
<Value name="11">
<Value>orderCurrency</Value>
</Value>
<Value name="12">
<Value>dataSource</Value>
</Value>
<Value name="13">
<Value>sourceOrderId</Value>
</Value>
</Data>
<DataLocation>^data.OrderD</DataLocation>
<DefaultData>OrderDefaultData</DefaultData>
<IdLocation>^data.OrderD</IdLocation>
<IndexLocation>^data.OrderI</IndexLocation>
<StreamLocation>^data.OrderS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
