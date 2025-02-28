Class ProdEye.DB.ProdEyeDocument Extends %DocDB.Document [ Owner = {SuperUser}, ProcedureBlock ]
{

Property TimeOfQueryIdx As %Integer [ SqlComputeCode = { set {*}=$$%EvaluatePathOne^%DocDB.Document({%Doc},"$.TimeOFQueryIdx")
}, SqlComputed, SqlComputeOnChange = %Doc ];

Property ProfileName As %String;

Index TimeOfQueryIdx On TimeOfQueryIdx;

Index ProfileNameIdx On ProfileName;

Storage Default
{
<Data name="%Doc">
<Attribute>%Doc</Attribute>
<Structure>node</Structure>
<Subscript>"%Doc"</Subscript>
</Data>
<Data name="ProdEyeDocumentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>%LastModified</Value>
</Value>
<Value name="3">
<Value>TimeOfQueryIdx</Value>
</Value>
<Value name="4">
<Value>ProfileName</Value>
</Value>
</Data>
<DataLocation>^BxmS.DCnI.1</DataLocation>
<DefaultData>ProdEyeDocumentDefaultData</DefaultData>
<ExtentLocation>^BxmS.DCnI</ExtentLocation>
<ExtentSize>1</ExtentSize>
<IdLocation>^BxmS.DCnI.1</IdLocation>
<Index name="IDKEY">
<Location>^BxmS.DCnI.1</Location>
</Index>
<Index name="ProfileNameIdx">
<Location>^BxmS.DCnI.3</Location>
</Index>
<Index name="TimeOfQueryIdx">
<Location>^BxmS.DCnI.2</Location>
</Index>
<IndexLocation>^BxmS.DCnI.I</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="%Doc">
<AverageFieldSize>1045</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%DocumentId">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="%LastModified">
<AverageFieldSize>25</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="TimeOfQueryIdx">
<AverageFieldSize>7</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<SQLMap name="TimeOfQueryIdx">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^BxmS.DCnI.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
