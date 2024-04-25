Class kafka.utils Extends %RegisteredObject
{

/// Description
ClassMethod send() As %Status
{
        Set tSC = $$$OK
        
        set settings = ..settings()
        zw settings

        set client = ##class(%External.Messaging.Client).CreateClient(settings, .tSC)
        #; zw tSC
        // if tSC is an error, handle error scenario 
        // 

        Set producerSettings = "{""key.serializer"":""org.apache.kafka.common.serialization.StringSerializer""}"
        Set tSC = client.UpdateProducerConfig(producerSettings)

        Set topic = "quick-start-events"
        set msg = ""
        for i=1:1:1500 { set msg = msg_ $c(13,10)_i _ ":" _ ##class(%PopulateUtils).Mission()}
       
        w !,msg,!
        w !,"msg:",$l(msg),!
        Set value = msg, key = "OptionalTag"

        Set msg = ##class(%External.Messaging.KafkaMessage).%New()
        Set msg.topic = topic
        Set msg.value = value
        Set msg.key = key

        Set tSC = client.SendMessage(msg)
        zw tSC
        Return tSC
}

/// Description
ClassMethod settings() As %External.Messaging.Settings
{
        Set settings = ##class(%External.Messaging.KafkaSettings).%New()
        // Set settings.username = "amandasmith"
        // Set settings.password = "234sdsge"
        // Set settings.servers = "host.docker.internal:9092, 100.0.70.089:7070"
        Set settings.servers = "host.docker.internal:9092"
        Set settings.clientId = "testApp"
        // If Consumer, specify a consumer group
        Set settings.groupId = "G1"
        Set settings.securityprotocol="SASL_PLAINTEXT"
        Set settings.saslmechanism="PLAIN"
        // Set settings.truststorelocation="/etc/kafkatls/trustcerts.jks"
        // Set settings.truststorepassword="F00B&r!"
        Return settings
}

}
