/* Copyright (c) 2023 by InterSystems Corporation.
   Cambridge, Massachusetts, U.S.A.  All rights reserved.
   Confidential property of InterSystems Corporation. */

Class EnsLib.Kafka.Message Extends (Ens.Request, %External.Messaging.KafkaMessage)
{

Storage Default
{
<Data name="MessageDefaultData">
<Subscript>"Message"</Subscript>
<Value name="1">
<Value>topic</Value>
</Value>
<Value name="2">
<Value>value</Value>
</Value>
<Value name="3">
<Value>key</Value>
</Value>
<Value name="4">
<Value>binaryValue</Value>
</Value>
</Data>
<DefaultData>MessageDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
