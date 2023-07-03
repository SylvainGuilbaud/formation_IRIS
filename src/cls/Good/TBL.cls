Class Good.TBL Extends %Persistent [ StorageStrategy = NewStorage1 ]
{

Property VendorName As %Integer;

Property VendorNum As %Integer;

Index Master On VendorNum [ IdKey ];

Storage NewStorage1
{
<SQLMap name="Map1">
<Data name="VendorName">
<Delimiter>"^"</Delimiter>
<Piece>1</Piece>
</Data>
<Global>^TBL</Global>
<Subscript name="1">
<Expression>1</Expression>
</Subscript>
<Subscript name="2">
<Expression>"SPMSUP"</Expression>
</Subscript>
<Subscript name="3">
<Expression>{VendorNum}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^Good.TBLS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
