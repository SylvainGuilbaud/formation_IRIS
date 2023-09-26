Class MT.data Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor) [ StorageStrategy = SQL ]
{

ClassMethod init() As %Status
{
   kill ^data
   set ^data($random(1000)+12345,0,0,0,0)="Homer\SIMPSON\45139\M\inspecteur de la sécurité à la centrale nucléaire de Springfield"
   set ^data($random(1000)+23456,$random(1000)+22222334343243,"M"_$random(245),"ZP-"_$random(10)_"C","191818YC")="Loïc\JEANROY\50788\M\Responsable Etude et Développement"
   set ^data($random(1000)+34567,$random(1000)+22222334343243,"M"_$random(245),"ZP-"_$random(10)_"C","191818YC")="Fabien\LEMELLE\56379\M\Analyste programmeur chez InfoGones"
   set ^data($random(1000)+45678,$random(1000)+22222334343243,"M"_$random(245),"ZP-"_$random(10)_"C","191818YC")="Sylvain\GUILBAUD\47139\M\Sales Engineer"
   zw ^data
   return $$$OK
}

Property firstname As %String;

Property lastname As %String;

Property dob As %Date(FORMAT = 4);

Property gender As %String(MAXLEN = 1);

Property title As %String(MAXLEN = "");

Property Key1 As %Integer;

Property Key2 As %Integer;

Property Key3 As %String;

Property CodeProduit As %String;

Property Key5 As %String;

Index IDIdx On (Key1, Key2, Key3, CodeProduit, Key5) [ IdKey ];

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
<Expression>{Key1}</Expression>
</Subscript>
<Subscript name="2">
<Expression>{Key2}</Expression>
</Subscript>
<Subscript name="3">
<Expression>{Key3}</Expression>
</Subscript>
<Subscript name="4">
<Expression>{CodeProduit}</Expression>
</Subscript>
<Subscript name="5">
<Expression>{Key5}</Expression>
</Subscript>
<Type>data</Type>
</SQLMap>
<StreamLocation>^MT.dataS</StreamLocation>
<Type>%Storage.SQL</Type>
}

}
