Class petshop.model.User Extends (%Persistent, %JSON.Adaptor, %XML.Adaptor) [ Inheritance = right, ProcedureBlock ]
{

Property email As %String(MAXLEN = "");

Property firstName As %String(MAXLEN = "");

Property id As %Integer;

Property lastName As %String(MAXLEN = "");

Property password As %String(MAXLEN = "");

Property phone As %String(MAXLEN = "");

/// User Status
Property userStatus As %Integer;

Property username As %String(MAXLEN = "");

Storage Default
{
<Data name="UserDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>email</Value>
</Value>
<Value name="3">
<Value>firstName</Value>
</Value>
<Value name="4">
<Value>id</Value>
</Value>
<Value name="5">
<Value>lastName</Value>
</Value>
<Value name="6">
<Value>password</Value>
</Value>
<Value name="7">
<Value>phone</Value>
</Value>
<Value name="8">
<Value>userStatus</Value>
</Value>
<Value name="9">
<Value>username</Value>
</Value>
</Data>
<DataLocation>^petshop.model.UserD</DataLocation>
<DefaultData>UserDefaultData</DefaultData>
<IdLocation>^petshop.model.UserD</IdLocation>
<IndexLocation>^petshop.model.UserI</IndexLocation>
<StreamLocation>^petshop.model.UserS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
