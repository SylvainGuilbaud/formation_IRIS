/// This class maps 2 different globals:
/// 
/// ^mapping2("Simple",1)="Brendan Bannon^55192^SQL Manager"
/// ^mapping2("Simple",2)="Nicole Aaron^63375^Support Specialist"
/// ^mapping2("Simple",3)="Kyle Baxter^61155^Senior Support Specialist"
/// ^mapping2("Simple",4)="Prasad Kari^58471^Support Specialist"
/// ^mapping2("Simple",5)="Clive Morgan^57982^Senior Support Specialist"
///  
/// ^index("Simple","HireDate",55192,1)=""
/// ^index("Simple","HireDate",57982,5)=""
/// ^index("Simple","HireDate",58471,4)=""
/// ^index("Simple","HireDate",61155,3)=""
/// ^index("Simple","HireDate",63375,2)=""
/// 
/// 
/// ^mapping2 contains all the data for this table so that will be the Data Map.
/// 
/// ^index is a sorted list of HireDates.  That will be an Index Map in the same storage definition.
Class Mapping.subExample1 Extends Mapping.Example1 [ StorageStrategy = NewStorage2 ]
{

ClassMethod init() As %Status
{
    Set sc = $$$OK
    set ^mapping2("Simple",1)="2Brendan Bannon^55192^SQL Manager"
    set ^mapping2("Simple",2)="2Nicole Aaron^63375^Support Specialist"
    set ^mapping2("Simple",3)="2Kyle Baxter^61155^Senior Support Specialist"
    set ^mapping2("Simple",4)="2Ludovic Kari^58471^Support Specialist"
    set ^mapping2("Simple",5)="2Fabien Morgan^57982^Senior Support Specialist"
    
    set ^index("Simple","HireDate",55192,1)=""
    set ^index("Simple","HireDate",57982,5)=""
    set ^index("Simple","HireDate",58471,4)=""
    set ^index("Simple","HireDate",61155,3)=""
    set ^index("Simple","HireDate",63375,2)=""
    Return sc
}

/// Every class can only have 1 active Storage Definition.  
/// Each Storage Definition can have more than one map.
Storage NewStorage2
{
<Description>
<![CDATA[Every class can only have 1 active Storage Definition.  
Each Storage Definition can have more than one map.]]></Description>
<SQLMap name="HireDateIndex">
<Global>^index</Global>
<Subscript name="1">
<Expression>"Simple"</Expression>
</Subscript>
<Subscript name="2">
<Expression>"HireDate"</Expression>
</Subscript>
<Subscript name="3">
<Expression>{HireDate}</Expression>
</Subscript>
<Subscript name="4">
<Expression>{Sub2}</Expression>
</Subscript>
<Type>index</Type>
</SQLMap>
<SQLMap name="SimpleDataMap">
<Data name="HireDate">
<Delimiter>"^"</Delimiter>
<Piece>2</Piece>
</Data>
<Data name="Name">
<Delimiter>"^"</Delimiter>
<Piece>1</Piece>
</Data>
<Data name="Title">
<Delimiter>"^"</Delimiter>
<Piece>3</Piece>
</Data>
<Global>^mapping2</Global>
<Subscript name="1">
<Expression>"Simple"</Expression>
</Subscript>
<Subscript name="2">
<Expression>{Sub2}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^Mapping.Example1S</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
