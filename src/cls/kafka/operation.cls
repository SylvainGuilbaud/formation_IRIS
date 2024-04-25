Class kafka.operation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.Kafka.Operation";

Property Host As %String;
Property Port As %Integer;
Property Topic As %String;
Property GroupId As %String;
Property AutoCommit As %Boolean;
Property PollTimeout As %Integer;
Property KafkaOperation As EnsLib.Kafka.Operation;

Method OnInit() As %Status
{
    Set ..KafkaOperation = ##class(EnsLib.Kafka.Operation).%New()
    Set ..KafkaOperation.Host = ..Host
    Set ..KafkaOperation.Port = ..Port
    Set ..KafkaOperation.Topic = ..Topic
    Set ..KafkaOperation.GroupId = ..GroupId
    Set ..KafkaOperation.AutoCommit = ..AutoCommit
    Set ..KafkaOperation.PollTimeout = ..PollTimeout
    
    Quit $$$OK
}

Method Send(message As %String) As %Status
{
    Try {
        Set status = ..KafkaOperation.Send(message)
        If $$$ISERR(status) {
            Write "Error sending message: ", $$$ERRORTEXT(status), !
        } else {
            Write "Message sent successfully!", !
        }
    } Catch ex {
        Write "Error: ", ex.DisplayString(), !
        Set status = $$$ERROR($$$GeneralError, ex.DisplayString())
    }
    Quit status
}

Method OnMessage(pRequest As MyApp.Request, Output pResponse As MyApp.Response) As %Status
{
    // Implement your message handling logic here
    // This method is called when a message is received from Kafka
    // pRequest contains the received message
    
    Quit $$$OK
}

}
