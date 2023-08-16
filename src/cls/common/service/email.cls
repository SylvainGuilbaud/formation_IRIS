Class common.service.email Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.EMail.InboundAdapter";

/// Configuration item(s) to which to send file stream messages
Property TargetConfigNames As %String(MAXLEN = 1000);

Parameter SETTINGS = "TargetConfigNames";

Method OnProcessInput(pInput As %Net.MailMessage, pOutput As %RegisteredObject) As %Status
{

    // Lets trace some
    $$$TRACE("Bcc="_pInput.Bcc)
    $$$TRACE("BinaryData="_pInput.BinaryData)
    $$$TRACE("Cc="_pInput.Cc)
    $$$TRACE("Charset="_pInput.Charset)
    $$$TRACE("ContentTransferEncoding="_pInput.ContentTransferEncoding)
    $$$TRACE("ContentType="_pInput.ContentType)
    $$$TRACE("Date="_pInput.Date)
    $$$TRACE("Dir="_pInput.Dir)
    $$$TRACE("FileName="_pInput.FileName)
    $$$TRACE("From="_pInput.From)
    $$$TRACE("Headers="_pInput.Headers)
    $$$TRACE("InlineAttachment="_pInput.InlineAttachment)
    $$$TRACE("Is7bit="_pInput.Is7bit)
    $$$TRACE("IsAlternative="_pInput.IsAlternative)
    $$$TRACE("IsBase64="_pInput.IsBase64)
    $$$TRACE("IsBinary="_pInput.IsBinary)
    $$$TRACE("IsHTML="_pInput.IsHTML)
    $$$TRACE("IsMultiPart="_pInput.IsMultiPart)
    $$$TRACE("MessageSize="_pInput.MessageSize)
    $$$TRACE("MultiPartType="_pInput.MultiPartType)
    $$$TRACE("Parts="_pInput.Parts)
    $$$TRACE("ReplyTo="_pInput.ReplyTo)
    $$$TRACE("Sender="_pInput.Sender)
    $$$TRACE("Subject="_pInput.Subject)
    $$$TRACE("TextData="_pInput.TextData)
    $$$TRACE("To="_pInput.To)

    Set tStatus = $$$OK

    // Check if mail message has multiple parts
    If pInput.IsMultiPart {
        Set tPartsCount = pInput.Parts.Count()
        $$$TRACE("This message has multiple parts; " _ tPartsCount)
        For tInd = 1:1:tPartsCount {
        Set tStatus = ..ProcessPart(pInput.Parts.GetAt(tInd))
        Quit:$$$ISERR(tStatus)
        }
    Quit tStatus
    }

    // Is not multipart
    Set pReq = ##class(common.msg.email).%New()
    Set pReq.Source = ..%ConfigName
    If pInput.IsBinary {
     Do pReq.Content.CopyFrom(pInput.BinaryData)
    }
    Else {
     Do pReq.Content.CopyFrom(pInput.TextData)
    }
    Set pReq.SourceFileName = pInput.FileName
    For iTarget=1:1:$L(..TargetConfigNames, ",") { 
    Set tOneTarget=$ZStrip($P(..TargetConfigNames,",",iTarget),"<>W")
    Continue:""=tOneTarget 
    Set tSC1 = ..SendRequestAsync(tOneTarget, pReq)
    Set:$$$ISERR(tSC1) tStatus = $$$ADDSC(tStatus,tSC1)
    }
    $$$TRACE("Attachment processed")
    Quit tStatus
}

Method ProcessPart(part As %Net.MailMessagePart) As %Status
{
    Set tStatus = $$$OK
    If part.FileName '= "" {
     Set pReq = ##class(common.msg.email).%New()
        Set pReq.Source = ..%ConfigName
        If part.IsBinary {
         Do pReq.Content.CopyFrom(part.BinaryData)
    } Else {
         Do pReq.Content.CopyFrom(part.TextData)
        }
    Set pReq.SourceFileName = part.FileName
    For iTarget=1:1:$L(..TargetConfigNames, ",") { 
    Set tOneTarget=$ZStrip($P(..TargetConfigNames,",",iTarget),"<>W")
    Continue:""=tOneTarget 
    Set tSC1 = ..SendRequestAsync(tOneTarget, pReq)
    Set:$$$ISERR(tSC1) tStatus = $$$ADDSC(tStatus,tSC1)
    }
        Quit tStatus
    } ElseIf (part.IsMultiPart) {
        Set tPartsCount = part.Parts.Count()
        For tInd = 1:1:tPartsCount {
      Set tStatus = ..ProcessPart(part.Parts.GetAt(tInd))
      Quit:$$$ISERR(tStatus)
        }    
    }
    Quit tStatus
}

/// Return an array of connections for drawing lines on the config diagram
ClassMethod OnGetConnections(Output pArray As %String, pItem As Ens.Config.Item)
{
    Do pItem.PopulateModifiedSettings()
    Set (tValue,tIndex)="" For {
    Set tSetting = pItem.ModifiedSettings.GetNext(.tIndex) Quit:tIndex=""
    If tSetting.Name="TargetConfigNames" Set tValue=tSetting.Value  Quit
    }
    For i=1:1:$L(tValue,",") { Set tOne=$ZStrip($P(tValue,",",i),"<>W") Continue:""=tOne  Set pArray(tOne)="" }
}

}
