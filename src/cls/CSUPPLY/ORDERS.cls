/// Generated by the Link Table wizard on 2025-06-26 19:29:04.  Note that you can access the data in this class only when the external database is accessible.
Class CSUPPLY.ORDERS Extends (%Library.Persistent, %Populate) [ Owner = {_SYSTEM}, Not ProcedureBlock, SqlRowIdPrivate, SqlTableName = ORDERS, StorageStrategy = GSQLStorage ]
{

/// Specifies details for the SQL Gateway Connection that this class uses
Parameter CONNECTION = "oracle,NOCREATE";

/// Specifies the external database that this class uses
Parameter EXTDBNAME = "Oracle";

/// Determines if INSERT statements for this external table attempt to retrieve auto-generated keys.  Set this to 0 if this external table does not support auto generated keys.
Parameter EXTERNALGENERATEDKEYS = 1;

/// Specifies the external table to which this class refers
Parameter EXTERNALTABLENAME = "C##SUPPLY.ORDERS";

Property ORDERDATE As %TimeStamp(EXTERNALSQLNAME = "ORDER_DATE", EXTERNALSQLTYPE = 93) [ SqlColumnNumber = 5, SqlFieldName = ORDER_DATE ];

Property PK As %Numeric(EXTERNALSQLNAME = "PK", EXTERNALSQLTYPE = 2, MINVAL = 0, SCALE = 0) [ Required, SqlColumnNumber = 2, SqlFieldName = PK ];

Property PRODUCTID As %Numeric(EXTERNALSQLNAME = "PRODUCT_ID", EXTERNALSQLTYPE = 2, MINVAL = 0, SCALE = 0) [ SqlColumnNumber = 3, SqlFieldName = PRODUCT_ID ];

Property QUANTITY As %Numeric(EXTERNALSQLNAME = "QUANTITY", EXTERNALSQLTYPE = 2, MAXVAL = 2000, MINVAL = 0, SCALE = 0) [ SqlColumnNumber = 4, SqlFieldName = QUANTITY ];

Index MainIndex On PK [ IdKey, PrimaryKey ];

Storage GSQLStorage
{
<StreamLocation>^CSUPPLY.ORDERSS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
