/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.RouteLeg Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// unique ID
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// start location of the leg
Property startLocationId As %String(MAXLEN = 256);

ForeignKey startLocationIdFK(startLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index startLocationIdIndex On startLocationId;

/// end location of the leg
Property endLocationId As %String(MAXLEN = 256);

ForeignKey endLocationIdFK(endLocationId) References SC.Data.Location(uidIndex) [ NoCheck ];

Index endLocationIdIndex On endLocationId;

/// Type of the route leg, such as transportation leg, or manufacturing process leg, etc.
Property type As %String(MAXLEN = 128);

/// Mode of the route leg
Property mode As %String(MAXLEN = 128);

/// Status of the route leg, such as active, future, expired, etc.
Property status As %String(MAXLEN = 128);

/// route to which this leg belongs
Property route As %String(MAXLEN = 128);

/// Network to which this route/leg belongs
Property network As %String(MAXLEN = 128);

/// Lead time associate with this leg 
Property leadTime As %Numeric;

/// Unit of measure for lead time
Property leadTimeUom As %String(MAXLEN = 128);

/// Cost associate with this leg 
Property cost As %Numeric;

/// Currency for the cost
Property costCurrency As %String(MAXLEN = 128);

}
