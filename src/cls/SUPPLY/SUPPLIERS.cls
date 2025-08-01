/// 
Class SUPPLY.SUPPLIERS Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, Owner = {irisowner}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = SUPPLIERS ]
{

Property PK As %Library.Numeric(MAXVAL = 9223372036854775807, MINVAL = -9223372036854775808, SCALE = 0) [ Required, SqlColumnNumber = 2 ];

Property NAME As %Library.String(MAXLEN = 100) [ SqlColumnNumber = 3 ];

Property EMAIL As %Library.String(MAXLEN = 255) [ SqlColumnNumber = 4 ];

Property PHONE As %Library.String(MAXLEN = 20) [ SqlColumnNumber = 5 ];

Parameter USEEXTENTSET = 1;

/// Bitmap Extent Index auto-generated by DDL CREATE TABLE statement.  Do not edit the SqlName of this index.
Index DDLBEIndex [ Extent, SqlName = "%%DDLBEIndex", Type = bitmap ];

/// DDL Primary Key Specification
Index SYSC008594 On PK [ PrimaryKey, SqlName = SYS_C008594, Type = index, Unique ];

Storage Default
{
<Data name="SUPPLIERSDefaultData">
<Value name="1">
<Value>PK</Value>
</Value>
<Value name="2">
<Value>NAME</Value>
</Value>
<Value name="3">
<Value>EMAIL</Value>
</Value>
<Value name="4">
<Value>PHONE</Value>
</Value>
</Data>
<DataLocation>^dbPD.EGSH.1</DataLocation>
<DefaultData>SUPPLIERSDefaultData</DefaultData>
<ExtentLocation>^dbPD.EGSH</ExtentLocation>
<IdFunction>sequence</IdFunction>
<IdLocation>^dbPD.EGSH.1</IdLocation>
<Index name="DDLBEIndex">
<Location>^dbPD.EGSH.2</Location>
</Index>
<Index name="IDKEY">
<Location>^dbPD.EGSH.1</Location>
</Index>
<Index name="SYSC008594">
<Location>^dbPD.EGSH.3</Location>
</Index>
<IndexLocation>^dbPD.EGSH.I</IndexLocation>
<StreamLocation>^dbPD.EGSH.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
