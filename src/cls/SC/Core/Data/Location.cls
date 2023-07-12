/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Location object can be used to store any kind of addresses, such as those for
/// supplier, customers, ship-to, ship-from, manufacturing plant, warehouses, etc. 
/// It can also be used to save any geo location with coordinates without an address.
Class SC.Core.Data.Location Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// Unique ID of the location
Property uid As %String(MAXLEN = 256);

Index uidIndex On uid [ PrimaryKey ];

/// Location name
Property name As %String(MAXLEN = 256);

/// Location type
Property type As %String(MAXLEN = 128);

/// Location status
Property status As %String(MAXLEN = 128);

/// Location street address
Property street As %String(MAXLEN = 256);

/// Location city
Property city As %String(MAXLEN = 128);

/// Location state/province
Property stateProvince As %String(MAXLEN = 128);

/// Location state/province ISO2 code
Property stateProvinceIso2 As %String(MAXLEN = 2);

/// Location country
Property country As %String(MAXLEN = 128);

/// Location country ISO2 code
Property countryIso2 As %String(MAXLEN = 2);

/// Location country ISO3 code
Property countryIso3 As %String(MAXLEN = 3);

/// Location country IDD phone code
Property countryPhoneCode As %String(MAXLEN = 5);

/// Location postal code
Property postalCode As %String(MAXLEN = 128);

/// Location geo coordinate
Property coordinates As %String(MAXLEN = 128);

Property latitude As %String(MAXLEN = 128);

Property longitude As %String(MAXLEN = 128);

/// Location GS1 GLN 
Property gln As %String(MAXLEN = 128);

/// Location 3 digit iso code for currency
Property currencyIso3 As %String(MAXLEN = 3);

/// Location region
Property region As %String(MAXLEN = 128);

/// Location subregion
Property subregion As %String(MAXLEN = 128);

}
