/// A string datatype definition which extends <class>%Library.String</class> with additional regex pattern validation. <br>
Class FCE.Regex Extends %Library.String
{

/// Set PATTERN to empty and final as it is not relevant
Parameter PATTERN [ Final ];

/// Set VALUELIST to empty and final as it is not relevant
Parameter VALUELIST [ Final ];

/// Set DISPLAYLIST to empty and final as it is not relevant
Parameter DISPLAYLIST [ Final ];

/// Set a valid regex pattern for value validation
Parameter REGEX;

/// Tests if the logical value <var>%val</var>, which is a string, is valid.
ClassMethod IsValid(%val As %RawString) As %Status
{
	if (..#REGEX '= "") {
		try {
			if '$match(%val, ..#REGEX) {
				return $$$ERROR($$$DTPattern, %val, ..#REGEX)
			}
		} catch Ex {
			return $$$ERROR($$$URegexRuleSyntax)
		}
	}
	return $$$OK
}

}
