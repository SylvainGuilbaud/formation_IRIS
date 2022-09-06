Class SAM.aaa
{

ClassMethod send(text As %String) As %Status [ Language = python ]
{
    import smtplib
    from email.message import EmailMessage

    #; with open("/data/patient/test/patient.csv") as fp:
    #;     msg = EmailMessage()
    #;     msg.set_content(fp.read())
    msg = EmailMessage()
    msg.set_content("hello")

    #; me = "iris@me.com"
    #; you = "sylvain.guilbaud@me.com"
    msg['Subject'] = 'hello'

    # Send the message via our own SMTP server.
    #; s = smtplib.SMTP('smtp.free.fr')
    #; s.send_message(msg)

    smtp = smtplib.SMTP('smtp.free.fr', port='587')

    smtp.ehlo()  
    smtp.starttls()
    smtp.login('bigdata', 'BigData4Good.')  

    resp = smtp.sendmail('bigdata@free.fr',
                ['sylvain.guilbaud@me.com','sylvain.guilbaud@intersystems.com'],
                msg.as_string())
                
    smtp.quit()
    return resp
}
ClassMethod envoi(text as %String...) As %Status [ Language = objectscript ]
{
    set sc = $$$OK

    set m=##class(%Net.MailMessage).%New()
    set m.From="bigdata@free.fr"
         
    set m.IsHTML=1
        
    do m.To.Insert("sylvain.guilbaud@me.com")
    do m.To.Insert("sylvain.guilbaud@intersystems.com")
    set m.Subject="Sent by IRIS mail"
    set m.Charset="iso-8859-1"
    do m.TextData.Write("<HTML><HEAD><TITLE></TITLE>"_$char(13,10))
    do m.TextData.Write("<META http-equiv=Content-Type content=""text/html;charset=iso-8859-2""></HEAD>"_$char(13,10))
    do m.TextData.Write("<BODY><FONT face=Arial size=2>Test <B>Test</B></FONT>")
    #;for i = 1 : 1 : text {

    #;}
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

ClassMethod getAlert() As %String [ Language = objectscript ]
{
    set file = ##class(%File).%New("/data/alert.json")
    set sc = file.Open("RS")
    if sc {
        set data = ""
        while 'file.AtEnd {
            set data = data _ file.Read()
        }
        set json = [].%FromJSON(data)
        
        #; set text = [].%FromJSON()
    }
    return json.%ToJSON()
}

ClassMethod read() As %String [ Language = objectscript ]
{
    set packet = [].%FromJSON(..getAlert())

    set iter = packet.%GetIterator()
      while iter.%GetNext(.idx, .alert) {
            write "idx:",idx,!
            set msg = alert.annotations.description
            write "msg:",msg,!
            if alert.labels.severity = "critical" {set severity = 2} else {set severity = 1}
            do ##class(%SYS.System).WriteToConsoleLog(msg, 1, severity)
      }

    return 1
}
ClassMethod a1(a as %String...) As %String [ Language = objectscript ]
{
    write $Length(a)
    for i = 1:1:$length(a) {
        write a(i),!
    }
    return a

}

}
