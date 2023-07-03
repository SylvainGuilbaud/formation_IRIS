Class Good.SPMRMA Extends %Persistent [ StorageStrategy = NewStorage1 ]
{

Property Sub2 As %Integer;

Property VendorNum As %Integer;

Property num As %Integer;

Index Master On Sub2 [ IdKey ];

Storage NewStorage1
{
<SQLMap name="Map1">
<Data name="VendorNum">
<Delimiter>"^"</Delimiter>
<Piece>1</Piece>
</Data>
<Data name="num">
<Delimiter>"^"</Delimiter>
<Piece>2</Piece>
</Data>
<Global>^SPMRMA</Global>
<Subscript name="1">
<Expression>1</Expression>
</Subscript>
<Subscript name="2">
<Expression>{Sub2}</Expression>
</Subscript>
<Subscript name="3">
<Expression>"P"</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^Good.SPMRMAS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
