Class instruments.operations.conversionXLStoCSV Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method OnMessage(pRequest As Ens.StreamContainer, Output pResponse As Ens.Response) As %Status
{
   set tSC = $$$OK
   set ^Debug("stream") = pRequest
   set filePath = pRequest.OriginalFilename
   set ^Debug("filePath") = pRequest.OriginalFilename
   set tSC = ..convertirXLStoCSV(filePath)
   return tSC
}

ClassMethod convertirXLStoCSV(source As %String = "/data/sample.xlsx") As %Status [ Language = python ]
{
  import pandas as pd
  read_file = pd.read_excel(source)
  read_file.to_csv(source+'.csv', index = None, header=True, encoding='utf-8',sep='\\')
  return True
}

}
