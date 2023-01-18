Class Mapping.Extract1 Extends %Persistent [ StorageStrategy = NewStorage1 ]
{

Property ClientID As %Integer;

Index Master On ClientID [ IdKey ];

Property FullName As %String;

Property FirstChar1 As %String;

Property FirstChar2 As %String [ SqlComputeCode = { s {*}=$E({FullName},1)}, SqlComputed, Transient ];

Storage NewStorage1
{
<ExtentSize>100000</ExtentSize>
<SQLMap name="Map1">
<Data name="FirstChar1">
<RetrievalCode> s {*}=$E($P(^CF({L1},0),"^",1),1)</RetrievalCode>
</Data>
<Data name="FullName">
<Delimiter>"^"</Delimiter>
<Node>0</Node>
<Piece>1</Piece>
</Data>
<Global>^CF</Global>
<Subscript name="1">
<Expression>{ClientID}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^Mapping.Extract1S</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
