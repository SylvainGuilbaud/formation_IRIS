Class BNA.Roland Extends %RegisteredObject
{
    /// Description
    Property PropertyName As %String;
    
    Index PropertyNameIndex On PropertyName [Unique];
}