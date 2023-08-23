/// Singleton pattern implementation
Class utils.singleton Extends %Library.SystemBase
{

/// Global to store content
Parameter Global = "^Singleton";

/// Actual object content
/// It can be be anything: string or a dynamic object
Property Content As %String;

/// This method finds OREF for an object of a current class if it exists in a current process
ClassMethod GetOref() As %Integer
{
    // Get current classname
    Set Cls = $ClassName()
    Set OREF = $$$NULLOREF
    
    // This query returns a list of all object instances currently in memory within the current process.
    &sql(SELECT Count(OREF),OREF INTO :Count,:OREFTemp FROM %SYSTEM.OBJ_ObjectList() WHERE ClassName=:Cls)
    
    If Count'=0 {    
        Set OREF = OREFTemp
    }
    Return OREF
}

/// If no object of this class is found in process memory
/// then a new one would be returned
/// with Content value taken from global
/// 
/// If there is an object of this class in memory
/// then it would be returned
ClassMethod Get() As utils.singleton
{
    Set OREF = ..GetOref()
    If OREF = $$$NULLOREF {
        Set Obj = ..%New()
    } Else {
        // Convert integer-oref into real OREF
        Set Obj = $$$objIntToOref(OREF)
    }
    Return Obj
}

/// Test singleton object
/// Do ##class(utils.singleton).Test()
ClassMethod Test()
{
    Set a = ##class(utils.singleton).Get()
    Set a.Content = $Random(100)
    Set b = ##class(utils.singleton).Get()
    Write "object b: " _ b.Content,!
    Do a.Save()
    Kill
    Set c = ##class(utils.singleton).Get()
    Write "object c: " _ c.Content
}

/// Constructor, loads data from global
Method %OnNew() As %Status
{
    // Return:($Stack($Stack-2,"PLACE")'["Get") $$$ERROR($$$GeneralError, "Сall Get method")
    Set ..Content = $Get(@..#Global)
    Return $$$OK
}

/// Saves data to global
Method Save()
{
    Set @..#Global = ..Content
}

}
