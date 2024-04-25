Class User.test Extends %Persistent [ StorageStrategy = TDA ]
{

Property CodeClient As %String;

Property Nom As %String;

Index NewIndex1 On CodeClient [ IdKey, Unique ];

Storage TDA
{
<SQLMap name="Map1">
<Data name="Nom">
<Delimiter>"~"</Delimiter>
<Piece>1</Piece>
</Data>
<Global>^test</Global>
<RowIdSpec name="1">
<Field>CodeClient</Field>
</RowIdSpec>
<Subscript name="1">
<Expression>{CodeClient}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^User.testS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
