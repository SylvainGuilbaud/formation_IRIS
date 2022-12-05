Class formation.msg.replication Extends Ens.Request
{

Property idirisreplication As %Integer [ SqlFieldName = idiris_replication ];

Property sTable As %String [ InitialExpression = "EMPLOYES", Required ];

Property nIdentifiant As %Integer [ InitialExpression = 1, Required ];

Property dhDateCreation As %TimeStamp [ InitialExpression = {$zdt($h,3)} ];

Property sAction As %String(VALUELIST = ",HAjoute,HModifie,HSupprime") [ InitialExpression = "HAjoute", Required ];

Property sCle As %String [ InitialExpression = "EMPO_ID", Required ];

Index sTableIdx On sTable;

Index dhDateCreationIdx On dhDateCreation;

Index sCleIdx On sCle;

Index sActionIdx On sAction [ Type = bitmap ];

Storage Default
{
<Data name="replicationDefaultData">
<Subscript>"replication"</Subscript>
<Value name="1">
<Value>idirisreplication</Value>
</Value>
<Value name="2">
<Value>sTable</Value>
</Value>
<Value name="3">
<Value>nIdentifiant</Value>
</Value>
<Value name="4">
<Value>dhDateCreation</Value>
</Value>
<Value name="5">
<Value>sAction</Value>
</Value>
<Value name="6">
<Value>sCle</Value>
</Value>
</Data>
<DefaultData>replicationDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
