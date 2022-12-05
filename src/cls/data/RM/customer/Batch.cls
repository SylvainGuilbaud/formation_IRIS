Class data.RM.customer.Batch Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Batch) [ Inheritance = right, ProcedureBlock ]
{

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader = "id,active,category,city,created,firstName,lastName";

Parameter HeaderTerm = "\x0a";

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 1;

Relationship Records As data.RM.customer.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Storage Default
{
<Data name="BatchDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>%Source</Value>
</Value>
</Data>
<DataLocation>^data.RM.customer.BatchD</DataLocation>
<DefaultData>BatchDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^data.RM.customer.BatchD</IdLocation>
<IndexLocation>^data.RM.customer.BatchI</IndexLocation>
<StreamLocation>^data.RM.customer.BatchS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
