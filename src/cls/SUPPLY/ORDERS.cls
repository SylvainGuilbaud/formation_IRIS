/// 
Class SUPPLY.ORDERS Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, Owner = {irisowner}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = ORDERS ]
{

Property PK As %Library.Numeric(MAXVAL = 9223372036854775807, MINVAL = -9223372036854775808, SCALE = 0) [ Required, SqlColumnNumber = 2 ];

Property PRODUCTID As %Library.Numeric(MAXVAL = 9223372036854775807, MINVAL = -9223372036854775808, SCALE = 0) [ SqlColumnNumber = 3, SqlFieldName = PRODUCT_ID ];

Property QUANTITY As %Library.Numeric(MAXVAL = 9223372036854775807, MINVAL = -9223372036854775808, SCALE = 0) [ SqlColumnNumber = 4 ];

Property ORDERDATE As %Library.PosixTime [ SqlColumnNumber = 5, SqlFieldName = ORDER_DATE ];

Parameter USEEXTENTSET = 1;

/// Bitmap Extent Index auto-generated by DDL CREATE TABLE statement.  Do not edit the SqlName of this index.
Index DDLBEIndex [ Extent, SqlName = "%%DDLBEIndex", Type = bitmap ];

/// DDL Primary Key Specification
Index SYSC008591 On PK [ PrimaryKey, SqlName = SYS_C008591, Type = index, Unique ];

/// Foreign Key SYSC008592 created via DDL
ForeignKey SYSC008592(PRODUCTID) References SUPPLY.PRODUCTS(SYSC008589) [ SqlName = SYS_C008592 ];

Storage Default
{
<Data name="ORDERSDefaultData">
<Value name="1">
<Value>PK</Value>
</Value>
<Value name="2">
<Value>PRODUCTID</Value>
</Value>
<Value name="3">
<Value>QUANTITY</Value>
</Value>
<Value name="4">
<Value>ORDERDATE</Value>
</Value>
</Data>
<DataLocation>^dbPD.OnUK.1</DataLocation>
<DefaultData>ORDERSDefaultData</DefaultData>
<ExtentLocation>^dbPD.OnUK</ExtentLocation>
<IdFunction>sequence</IdFunction>
<IdLocation>^dbPD.OnUK.1</IdLocation>
<Index name="DDLBEIndex">
<Location>^dbPD.OnUK.2</Location>
</Index>
<Index name="IDKEY">
<Location>^dbPD.OnUK.1</Location>
</Index>
<Index name="SYSC008591">
<Location>^dbPD.OnUK.3</Location>
</Index>
<IndexLocation>^dbPD.OnUK.I</IndexLocation>
<StreamLocation>^dbPD.OnUK.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
