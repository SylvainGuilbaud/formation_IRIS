Class unittests.codeGolf.ParenthesisHell.ParenthesisHell Extends %UnitTest.TestCase
{

Method TestValid()
{
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("())"), $$$YES)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("(()())"), $$$YES)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("(((())))"), $$$YES)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("()(())((()))(())()"), $$$YES)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("(]{)"), $$$YES)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("(()()(()()(()()()()((()()(()(()((()((()()()((()((()()()((()((((()()(()()()()()()(((()(((()((()((((()(((()()(()()((()((()()()((()()(()()()()(()()()()(()()()()(()(())))))))))))))))))))))))))))))))))))))))))))))))))"), $$$YES)
}

Method TestInValid()
{
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("(]"), $$$NO)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("()(()(()))(()()"), $$$NO)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid(")("), $$$NO)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("()()("), $$$NO)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("((())"), $$$NO)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("())(()"), $$$NO)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid(")()"), $$$NO)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid(")"), $$$NO)
    Do $$$AssertEquals(##class(codeGolf.ParenthesisHell).IsValid("(()()(()()(()()()()((()()(()(()((()((()()()((()((()()()((()((((()()(()()()()()()(((()(((()((()((((()(((()()(()()((()((()()()((()()(()()()()(()()()()(()()()()(()(()))))))))))))))))))))))))))))))))))))))))))))))))"), $$$NO)
}

}
