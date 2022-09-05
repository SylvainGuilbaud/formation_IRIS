/* Copyright (c) 2022 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

/// %JSON.Mapping is the internal class which represents the contents of the
/// XData block which defines a JSON Adaptor mapping.
Class %JSON.Mapping Extends (%RegisteredObject, %XML.Adaptor) [ System = 2 ]
{

Parameter NAMESPACE = "http://www.intersystems.com/jsonmapping";

Parameter XMLFORMAT = "literal";

Parameter XMLIGNOREINVALIDATTRIBUTE = 0;

/// See %JSONIGNOREINVALIDFIELD class parameter in %JSON.Adaptor
Property IgnoreInvalidField As %Boolean(XMLPROJECTION = "attribute") [ InitialExpression = 0 ];

/// See %JSONNULL class parameter in %JSON.Adaptor
Property Null As %Boolean(XMLPROJECTION = "attribute") [ InitialExpression = 0 ];

/// See %JSONIGNORENULL class parameter in %JSON.Adaptor
Property IgnoreNull As %Boolean(XMLPROJECTION = "attribute") [ InitialExpression = 0 ];

/// See %JSONMAPPING class parameter in %JSON.Adaptor
Property Mapping As %String(XMLPROJECTION = "attribute");

/// See %JSONREFERENCE class parameter in %JSON.Adaptor
Property Reference As %String(XMLPROJECTION = "attribute") [ InitialExpression = "OBJECT" ];

/// The list of property definitions
Property propertyList As list Of %JSON.MappingProperty(XMLNAME = "Property", XMLPROJECTION = "element");

}
