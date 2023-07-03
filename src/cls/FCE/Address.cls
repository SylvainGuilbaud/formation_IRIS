/// Address properties for <class>FCE.RealEstate</class> and <class>FCE.MailingAddress</class>
Class FCE.Address Extends (%Populate, %XML.Adaptor, %JSON.Adaptor) [ Abstract ]
{

Property Street As %String [ Required ];

Property City As %String [ Required ];

Property State As %String(VALUELIST = "-NY-NJ-MA-TX") [ Required ];

// Property Zip As %String(PATTERN = "5n.1(1""-""4n)") [ Required ];

Property Zip As FCE.Regex(REGEX = "\d{5}(-\d{4})?") [ Required ];

Method Print()
{
	write !, ..Street
	write !, ..City, ", ", ..State, " ", ..Zip
}

}
