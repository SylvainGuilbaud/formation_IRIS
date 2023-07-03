/// Abstract person class
Class FCE.Person Extends (%Populate, %XML.Adaptor) [ Abstract ]
{

Property Name As %String [ Required ];

Property PrintName As %String [ Calculated, SqlComputeCode = { set {PrintName}=$piece({Name},",",2)_" "_$piece({Name},",",1)}, SqlComputed ];

Property Email As %String [ Required ];

Property DOB As %Date(FORMAT = 5, MAXVAL = "+$h");

Property Home As FCE.MailingAddress;

Property Work As FCE.MailingAddress;

}
