/* Copyright (c) 2022 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

/// Property superclass used to hold information about property parameters for %JSON.Adaptor.
Class %JSON.PropertyParameters [ System = 2 ]
{

/// The %JSONFIELDNAME parameter specifies the field name that this property is mapped to in JSON.
/// The default %JSONFIELDNAME is the property name.
Parameter %JSONFIELDNAME As STRING;

/// The %JSONINCLUDE parameter controls if this property will be included in the JSON output or input.
/// Possible values are INOUT, INPUTONLY, OUTPUTONLY and NONE.  The default is INOUT.
Parameter %JSONINCLUDE As STRING [ Constraint = "INOUT,INPUTONLY,OUTPUTONLY,NONE", Flags = ENUM ];

/// If %JSONNULL is true (=1), then unspecified properties are exported as the null value.
/// Otherwise the field corresponding to the property is just skipped during export. 
Parameter %JSONNULL As BOOLEAN;

/// %JSONIGNORENULL allows the programmer to override the default handling of empty strings for string properties.
/// This parameter applies to only true strings which is determined by XSDTYPE = "string" as well as JSONTYPE="string"
/// By default (%JSONIGNORENULL = 0), empty strings in the JSON input are stored as $c(0)
/// and $c(0) is written to JSON as the string "". A missing field in the JSON input is always stored as ""
/// and "" is always output to JSON according to the %JSONNULL parameter.<br>
/// If %JSONIGNORENULL is set = 1, then both missing fields in the JSON and empty strings are input as "",
/// and both "" and $c(0) are output as field values of "". 
Parameter %JSONIGNORENULL As BOOLEAN;

/// %JSONREFERENCE specifies the default value of the %JSONREFERENCE property parameter that specifies how to
/// project references to JSON.  %JSONREFERENCE may be specified for any property to override this default value.
/// Possible values of %JSONREFERENCE are "OBJECT", "ID", "OID", "GUID".<br>
/// ="OBJECT" is the default and indicates that the properties of the referenced class are used to represent the referenced object.<br>
/// ="ID" indicates that the id of a persistent or serial class is used to represent the reference.<br>
/// ="OID" indicates that the oid of a persistent or serial class is used to represent the reference.
///  The form of the oid as projected to JSON will be classname,id.<br>
/// ="GUID" indicates the GUID of a persistent class is used to represent the reference.<br>
Parameter %JSONREFERENCE As STRING [ Constraint = "OBJECT,ID,OID,GUID", Flags = ENUM ];

}
