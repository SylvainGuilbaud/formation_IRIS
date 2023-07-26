Class IPC.data Extends %Persistent [ StorageStrategy = SQL ]
{

Index IDKey On (IPP, IPPPseudo) [ IdKey ];

Property IPP As %String;

Property IPPPseudo As %String;

Property firstname As %String;

Property lastname As %String;

Property dob As %Date(FORMAT = 4);

ClassMethod init() As %Status
{
   kill ^IPC
   for i=1:1:100 {
      set id=$random(1000)+1000
      set data=##class(%PopulateUtils).FirstName()_"|"_##class(%PopulateUtils).LastName()_"|"_($random(50000)+25000)
      set ^IPC(id,"ID:"_id)=data
   }
   zw ^IPC
   return $$$OK
}

/// Description
Storage SQL
{
<Description>
<![CDATA[Description]]></Description>
<Property name="dob"/>
<Property name="firstname"/>
<Property name="lastname"/>
<SQLMap name="Map1">
<Data name="dob">
<Delimiter>"|"</Delimiter>
<Piece>3</Piece>
</Data>
<Data name="firstname">
<Delimiter>"|"</Delimiter>
<Piece>1</Piece>
</Data>
<Data name="lastname">
<Delimiter>"|"</Delimiter>
<Piece>2</Piece>
</Data>
<Global>^IPC</Global>
<Structure>delimited</Structure>
<Subscript name="1">
<Expression>{IPP}</Expression>
</Subscript>
<Subscript name="2">
<Expression>{IPPPseudo}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^IPC.dataS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
