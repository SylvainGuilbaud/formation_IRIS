/* Copyright (c) 2022 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

/// %JSON.MappingProperty is the internal class which represents the Property elements in the
/// XData block which defines a JSON Adaptor mapping.
Class %JSON.MappingProperty Extends (%RegisteredObject, %XML.Adaptor) [ System = 2 ]
{

Parameter NAMESPACE = "http://www.intersystems.com/jsonmapping";

Parameter XMLFORMAT = "literal";

Parameter XMLIGNOREINVALIDATTRIBUTE = 0;

/// Property name.
Property Name As %String(XMLPROJECTION = "attribute") [ Required ];

/// See %JSONFIELDNAME property parameter in %JSON.Adaptor
Property FieldName As %String(XMLPROJECTION = "attribute");

/// See %JSONINCLUDE property parameter in %JSON.Adaptor
Property Include As %String(XMLPROJECTION = "attribute");

/// See %JSONNULL property parameter in %JSON.Adaptor
Property Null As %Boolean(XMLPROJECTION = "attribute");

/// See %JSONIGNORENULL property parameter in %JSON.Adaptor
Property IgnoreNull As %Boolean(XMLPROJECTION = "attribute");

/// See %JSONMAPPING property parameter in %JSON.Adaptor
Property Mapping As %String(XMLPROJECTION = "attribute");

/// See %JSONREFERENCE property parameter in %JSON.Adaptor
Property Reference As %String(XMLPROJECTION = "attribute");

}
