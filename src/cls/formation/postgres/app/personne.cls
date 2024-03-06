/// 
Class formation.postgres.app.personne Extends (Ens.Request, %JSON.Adaptor) [ ClassType = persistent, DdlAllowed, Final, Owner = {_SYSTEM}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = personne ]
{

Property id As %Library.String [ Required, SqlColumnNumber = 2 ];

Property lastname As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 3 ];

Property firstname As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 4 ];

Property dob As %Library.Date [ SqlColumnNumber = 5 ];

Property sex As %Library.String(MAXLEN = 10) [ SqlColumnNumber = 6 ];

Storage Default
{
<Data name="personneDefaultData">
<Subscript>"personne"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
<Value name="2">
<Value>lastname</Value>
</Value>
<Value name="3">
<Value>firstname</Value>
</Value>
<Value name="4">
<Value>dob</Value>
</Value>
<Value name="5">
<Value>sex</Value>
</Value>
</Data>
<DefaultData>personneDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
