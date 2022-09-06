Class SAM.alertHandler Extends %SAM.AbstractAlertsHandler
{

ClassMethod HandleAlerts(packet As %DynamicArray) As %Status
{
      set iter = packet.%GetIterator()
      while iter.%GetNext(.idx, .alert) {
            set msg = alert.annotations.description _ " in instance " _ alert.labels.instance _ " on " _ alert.ts
            if alert.labels.severity = "critical" {set severity = 2} else {set severity = 1}


            do ##class(%SYS.System).WriteToConsoleLog(msg, 1, severity)

            set sc = ..email(msg)

            if sc {
                do ##class(%SYS.System).WriteToConsoleLog("alert successfully sent by email", 1, 0)
            } else {
                do ##class(%SYS.System).WriteToConsoleLog("error while sending alert by email : " _  $system.Status.GetErrorText(sc), 1, 1)
            }

            
      }
      return $$$OK
}

ClassMethod email(text As %String) As %Status [ Language = objectscript ]
{

    set sc = $$$OK
    set m=##class(%Net.MailMessage).%New()
    set m.From="bigdata@free.fr"
    set m.IsHTML=1
    do m.To.Insert("sylvain.guilbaud@me.com")
    do m.To.Insert("sylvain.guilbaud@intersystems.com")
    set m.Subject="ALERT FROM SAM"
    set m.Charset="iso-8859-1"
    do m.TextData.Write("<HTML><HEAD><TITLE></TITLE>"_$char(13,10))
    do m.TextData.Write("<META http-equiv=Content-Type content=""text/html;charset=iso-8859-2""></HEAD>"_$char(13,10))
    do m.TextData.Write("<BODY>")

    do m.TextData.Write("<p>" _ text _$char(13,10))
    
    do m.TextData.Write("")
    do m.TextData.Write("</BODY></HTML>")

    set s=##class(%Net.SMTP).%New()
    set s.UseSTARTTLS = 1
    set s.SSLConfiguration = "SMTP"
    set s.smtpserver="smtp.free.fr"
    set s.port = 587
    set auth=##class(%Net.Authenticator).%New() 
	set auth.UserName="bigdata"
	set auth.Password="BigData4Good."
	set s.authenticator=auth 
    set sc=s.Send(m)

    return sc
}

}
