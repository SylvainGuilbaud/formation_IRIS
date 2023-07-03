Class Simple.Demo
{

/// First method in my first class 
ClassMethod Hello(name As %String, Output nameReversed As %String) As %String
{
 
	set affirmation = ""
	try {
 	    for i=1:1:$length(name) {write !, "Hello World!"}
 	    set nameReversed = $reverse(name)
    set affirmation = name _ " is your friend." 
	}
	catch ex {
	    write !, ex.Name, " error. Affirmation requires name argument."
	}
	return affirmation
}

ClassMethod a(name As %String) As %String
{
	write name,!
	return name
}

}
