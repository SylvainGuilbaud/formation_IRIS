Class codeGolf.ParenthesisHell
{

ClassMethod IsValid(s As %String) As %Boolean
{
    #; return ..IsValid1(s)
    #; return ..IsValid2(s)
    #; return ..IsValid3(s)
    return ..IsValid4(s)
    #; return ..IsValid5(s)
}

ClassMethod IsValid1(s As %String) As %Boolean [ Language = python ]
{
import re;p=r'\([^()]*\)'
while re.search(p,s):s=re.sub(p,'',s)
return len(s)==0
}

ClassMethod IsValid2(s As %String) As %Boolean
{
    // Floats around them no good characters
    s s=$ZSTRIP(s,"*E","","()")
    // Erupts Combination jabs "(" followed by ")"
    // Relentless follow up until stringy looks unbalanced
    f {
        q:s'[("()") 
        s s=$Replace(s,"()","")
    }
    // Swings for the knock out
    return s=""
}

ClassMethod IsValid3(s As %String) As %Boolean
{
    write $$$URLENCODE(s),!
 return +##class(%iFind.Utils).TestSearchString($$$URLENCODE(s))
}

/// ( -> -0.5
/// ) -> 0.5
ClassMethod IsValid4(s As %String) As %Boolean
{
 s z=0,s=$zstrip(s,"*E",,"()") f  s c=$e(s,$i(i)) ret:c="" 'z ret:$i(z,$a(c)-40.5)>0 0
}

}
