/// This class maps a global that stores more that one Row of data in a node.
/// 
/// The global structure looks like:
/// 
///  
/// ^glo(1)=r1P1^r1P2~r2P1^r2P2
/// ^glo(2)=r3P1^r3P2~R4P1^r4P2~r5P1^r5P2
/// 
/// Each row in this table has two properties.  The global above shows 5 rows of data, each row is delimited by the "~"
/// 
/// The two data properties are delimited by "^"  
/// 
/// The IDKey for the table is the subscript and the Piece location of the data.
/// 
/// so the IDKey for the row r4P1^r4P2 would be 2||2
/// 
Class Mapping.PieceCounter Extends %Persistent [ ClassType = persistent, ProcedureBlock, StorageStrategy = NewStorage1 ]
{

Index master On (Sub1, PieceCounter) [ IdKey, Unique ];

Property Sub1 As %Integer;

Property PieceCounter As %Integer;

Property Data1 As %String(TRUNCATE = 1);

Property Data2 As %String(TRUNCATE = 1);

Storage NewStorage1
{
<SQLMap name="Map1">
<Data name="Data1">
<Delimiter>"^"</Delimiter>
<Piece>1</Piece>
</Data>
<Data name="Data2">
<Delimiter>"^"</Delimiter>
<Piece>2</Piece>
</Data>
<Global>^glo</Global>
<Subscript name="1">
<Expression>{Sub1}</Expression>
</Subscript>
<Subscript name="2">
<AccessType>Piece</AccessType>
<Delimiter>"~"</Delimiter>
<Expression>{PieceCounter}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^Mapping.PieceCounterS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
