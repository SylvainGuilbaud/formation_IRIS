/* Copyright (c) 2023 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

Class EnsLib.Kafka.OutboundAdapter Extends (EnsLib.Messaging.Common, EnsLib.PEX.OutboundAdapter) [ ClassType = "", Inheritance = right, ProcedureBlock, System = 4 ]
{

/// Kafka server host and port.
Property Servers As %String(MAXLEN = 200) [ InitialExpression = "localhost:9092" ];

/// Kafka producer client ID.
Property ClientID As %String(MAXLEN = 100) [ InitialExpression = "KafkaProduction" ];

/// This is the ID name of the set of credentials values (Username, Password).
Property Credentials As %String(MAXLEN = 200);

Parameter SETTINGS = "Servers:Kafka Settings,ClientID:Kafka Settings,Credentials:Kafka Settings:credentialsSelector";

Method OnInit() As %Status
{
	Set ..%remoteClassname = "com.intersystems.enslib.kafka.KafkaOutboundAdapter"
	Set ..%gatewayName = "%Java Server"
	Set ..%gatewayExtraClasspaths = ..GetMessagingClientJARPaths()
	Quit ##super()
}

Method SendMessage(message As EnsLib.Kafka.Message) As %Status
{
	Set tSC = $$$OK
	Try {
		Do ..%gatewayProxy.SendMessage(message)
	}
	Catch (ex) {
		Set tSC = ex.AsStatus()
	}
	Quit tSC
}

}
