Class codeGolf.SmileyFace Extends %UnitTest.TestCase
{

Method TestSolutions()
{
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count(")s).:D :~) ;~D :) xD"), 7)
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count(""), 0)
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count(":):(':D:O:;"), 2)
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count("let's put a smile on that face :o)"), 1)
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count("(smiley)"), 1)
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count("12 weirds :] :-> :> 8-) 8) :-} :} :o) :c) :^) =] =)"), 12)
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count(";] ;) ;-) winky"), 3)
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count("B^D 8D X‑D Laughing :D"), 4)
        Do $$$AssertEquals(##class(codeGolf.SmileyFace).Count("Sadness >:( :[ :{ :("), 0)
}

}
