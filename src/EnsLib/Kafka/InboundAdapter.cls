/* Copyright (c) 2023 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

Class EnsLib.Kafka.InboundAdapter Extends (EnsLib.Messaging.Common, EnsLib.PEX.InboundAdapter) [ ClassType = "", Inheritance = right, ProcedureBlock, System = 4 ]
{

/// Kafka server host and port.
Property Servers As %String(MAXLEN = 200) [ InitialExpression = "localhost:9092" ];

/// Topic that the messages are read from.
Property Topic As %String(MAXLEN = 100);

/// Kafka consumer group ID. Within the same group, each message is only read once.
Property GroupID As %String(MAXLEN = 100);

/// Parameters to receive messages as JSON string 
Property ReceiveSettings As %String(MAXLEN = 300);

/// This is the ID name of the set of credentials values (Username, Password) to be used to access the Kafka server.
Property Credentials As %String(MAXLEN = 200);

Parameter SETTINGS = "Servers:Kafka Settings,Topic:Kafka Settings,GroupID:Kafka Settings,ReceiveSettings:Kafka Settings,Credentials:Kafka Settings:credentialsSelector";

Method OnInit() As %Status
{
	Set ..%remoteClassname = "com.intersystems.enslib.kafka.KafkaInboundAdapter"
	Set ..%gatewayName = "%Java Server"
	Set ..%gatewayExtraClasspaths = ..GetMessagingClientJARPaths()
	Quit ##super()
}

}
