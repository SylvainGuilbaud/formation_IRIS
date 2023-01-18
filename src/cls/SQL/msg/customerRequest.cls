Class SQL.msg.customerRequest Extends Ens.Request
{

// ID,last_name,first_name,city,active,category,gender,created,inserted,lastupdate 

Property id As %Integer;

Property active As %String;

Property firstname As %String [ SqlFieldName = first_name ];

Property lastname As %String [ SqlFieldName = last_name ];

Property city As %String;

Property category As %Integer;

Property created As %TimeStamp;

Property inserted As %TimeStamp;

Property lastupdate As %TimeStamp;

Property gender As %String;

Storage Default
{
<Data name="customerRequestDefaultData">
<Subscript>"customerRequest"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
<Value name="2">
<Value>active</Value>
</Value>
<Value name="3">
<Value>firstname</Value>
</Value>
<Value name="4">
<Value>lastname</Value>
</Value>
<Value name="5">
<Value>city</Value>
</Value>
<Value name="6">
<Value>category</Value>
</Value>
<Value name="7">
<Value>created</Value>
</Value>
<Value name="8">
<Value>inserted</Value>
</Value>
<Value name="9">
<Value>lastupdate</Value>
</Value>
<Value name="10">
<Value>gender</Value>
</Value>
</Data>
<DefaultData>customerRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
