Class SC.Core.Data.SCException Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID of customer
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// Description of the exception
Property description As %String(MAXLEN = 1024);

/// Type of the exception
Property type As %String(MAXLEN = 128);

/// Reason of the exception
Property reason As %String(MAXLEN = 1024);

/// Category of the exception
Property category As %String(MAXLEN = 64);

/// Action taken
Property action As %String(MAXLEN = 128);

/// Source of the exception
Property source As %String(MAXLEN = 128);

/// Action details
Property actionDetails As %String(MAXLEN = 1024);

/// type of object this exception is attached to
Property associatedObjectType As %String(MAXLEN = 256);

/// Unique ID of the object this exception is attached to
Property associatedObjectId As %String(MAXLEN = 256);

}
