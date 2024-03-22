Class Mapping.data1 Extends (%Persistent, %Populate) [ StorageStrategy = SQL ]
{

ClassMethod init() As %Status
{
   kill ^data
   set ^data("PSA",$INCREMENT(^data("PSA")))="Homer\SIMPSON\45139\M\inspecteur de la sécurité à la centrale nucléaire de Springfield"
   set ^data("PSA",$INCREMENT(^data("PSA")))="Olivia\VERDURIN\56379\F\artist"
   set ^data("PSA",$INCREMENT(^data("PSA")))="Jimi\HENDRIX\37220\M\guitarist"
   zw ^data
   write !,"SQL INSERT",!
   set id = $INCREMENT(^data("PSA"))
   &sql(insert into mapping.data1
         (Key2, dob, firstname, lastname, gender, title)
         values 
         (:id,to_date('14/03/1879','DD/MM/YYYY'),'Albert','EINSTEIN','M','theoretical physicist'))
   zw ^data  
   write !,"SQL UPDATE",!
   &sql(update mapping.data1 
         set title = title || ' as of '|| sysdate)
   zw ^data    
   write !,"SQL DELETE",!
   &sql(delete mapping.data1 
         where gender = 'M')
   zw ^data 
   write !,"OBJECT INSERT",!
   write ..Populate(6)
   zw ^data
   return $$$OK
}

Property firstname As %String(POPSPEC = "FirstName()");

Property lastname As %String(POPSPEC = "LastName()");

Property dob As %Date(FORMAT = 4);

Property gender As %String(MAXLEN = 1, VALUELIST = ",M,F");

Property title As %String(MAXLEN = "");

// Property Key1 As %Integer;

Property Key2 As %Integer [ InitialExpression = {$INCREMENT(^data("PSA"))} ];

// Property Key3 As %String;

// Property Key4 As %String;

// Property Key5 As %String;

Index IDIdx On Key2 [ IdKey ];

/// Description
Storage SQL
{
<Description>
<![CDATA[Description]]></Description>
<Property name="dob"/>
<Property name="firstname"/>
<Property name="gender"/>
<Property name="lastname"/>
<Property name="title"/>
<SQLMap name="Map1">
<Data name="dob">
<Delimiter>"\"</Delimiter>
<Piece>3</Piece>
</Data>
<Data name="firstname">
<Delimiter>"\"</Delimiter>
<Piece>1</Piece>
</Data>
<Data name="gender">
<Delimiter>"\"</Delimiter>
<Piece>4</Piece>
</Data>
<Data name="lastname">
<Delimiter>"\"</Delimiter>
<Piece>2</Piece>
</Data>
<Data name="title">
<Delimiter>"\"</Delimiter>
<Piece>5</Piece>
</Data>
<Global>^data</Global>
<Structure>delimited</Structure>
<Subscript name="1">
<Expression>"PSA"</Expression>
</Subscript>
<Subscript name="2">
<Expression>{Key2}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^MT.dataS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
