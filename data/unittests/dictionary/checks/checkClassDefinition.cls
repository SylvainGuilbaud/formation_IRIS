Class unittests.dictionary.checks.checkClassDefinition Extends %UnitTest.TestCase
{

Method TestOK()
{
    Do $$$AssertEquals(##class(%Dictionary.ClassDefinition).%ExistsId("data.commande"), $$$YES)
    set a = ##class(%Dictionary.ClassDefinition).%OpenId("data.commande")
    if $ISOBJECT(a) {
        Do $$$AssertEquals(a.Super = "%Persistent,%Populate,%JSON.Adaptor,%XML.Adaptor" , $$$YES)
    }
}

Method TestKO()
{
    Do $$$AssertEquals('##class(%Dictionary.ClassDefinition).%ExistsId("data.commande"), $$$NO)
    set a = ##class(%Dictionary.ClassDefinition).%OpenId("data.commande")
    if $ISOBJECT(a) {
        Do $$$AssertEquals('(a.Super = "%Persistent,%Populate,%JSON.Adaptor,%XML.Adaptor") , $$$NO)
    }
}

}
