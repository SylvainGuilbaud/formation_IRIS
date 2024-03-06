Class formation.service.personne Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.EMail.InboundAdapter";

Property TargetConfigNames As %String(MAXLEN = 1000);

Parameter SETTINGS = "TargetConfigNames";

Method OnProcessInput(pInput As %Net.MailMessage, Output pOutput As %RegisteredObject) As %Status
{
	set sc=$$$OK
	kill ^Email
	
	$$$LOGINFO("ContentType:"_pInput.ContentType_" MultiPart:"_pInput.IsMultiPart_" HTML:"_pInput.IsHTML_" Binary:"_pInput.IsBinary)
	$$$LOGINFO("Charset:"_pInput.Charset)
	$$$LOGINFO("MsgParts:"_pInput.Parts.Count())

    set text=""
	do ..getMessageText(pInput,.text)
	set emailText=$zstrip(text,"*C")
    set request=##class(formation.RM.personne.Record).%New()

    #; #; ===========
    #; #; CAS N°1
    #; #; ===========
	/*
        Exemple d'un email avec contenu directement dans le corps du message avec séparateur
        ====================================================================================
		Bonjour,

		vous trouverez ci-joint les détails de la personne :

		.ID=42
        .DateNaissance=09/08/2001
		.Nom=Durand
		.Prenom=Lucie
		.Sexe=F
        .#fin des données#

		Cordialement,
		IRIS
        ====================================================================================
	*/
    #; #; ++++++++++
	#; #; début code
    #; #; ++++++++++
    #; 
    #; set separator="."
	#; set ID=$zstrip($Piece($Piece(emailText,separator,2),"=",2),"<>W")
	#; set DateNaissance=$zdh($zstrip($Piece($Piece(emailText,separator,3),"=",2),"<>W"),4)
	#; set Nom=$zstrip($Piece($Piece(emailText,separator,4),"=",2),"<>W")
	#; set Prenom=$zstrip($Piece($Piece(emailText,separator,5),"=",2),"<>W")
	#; set Sexe=$zstrip($Piece($Piece(emailText,separator,6),"=",2),"<>W")
	
    #; #; préparation du message de la requête à envoyer :
	#; set request.ID=ID
	#; set request.Nom=Nom
	#; set request.Prenom=Prenom
	#; set request.DateNaissance=DateNaissance
	#; set request.Sexe=Sexe
    #; 
    #; set sc=..SendRequestAsync(..TargetConfigNames,request)
	#; $$$LOGINFO(text)
    #; 
    #; #; ++++++++++
	#; #; fin code
    #; #; ++++++++++
    #; #; ===========
    #; #; FIN CAS N°1
    #; #; ===========


    #; #; ===========
    #; #; CAS N°2
    #; #; ===========
    /*
        Exemple d'un email avec contenu directement dans le corps du message en JSON
        ====================================================================================
		Bonjour,

		vous trouverez ci-joint les détails de la personne :

	    {
            "ID":1,
            "DateNaissance":"2008-03-06",
            "Nom":"Smith",
            "Prenom":"Cecile",
            "Sexe":"F"
        }

		Cordialement,
		IRIS
        ====================================================================================


    */
    #; #; ++++++++++
	#; #; début code
    #; #; ++++++++++
    #;
    #; set separator1="{"
    #; set separator2="}"

    #; set data = "{"_$zstrip(($piece($Piece(emailText,separator1,2),separator2,1)),"<>W")_"}"
    #; $$$LOGINFO("data:"_data)
	#; set sc = request.%JSONImport(data)
    #; set sc=..SendRequestAsync(..TargetConfigNames,request)
	#; $$$LOGINFO(text)
    #; 
    #; #; ++++++++++
	#; #; fin code
    #; #; ++++++++++
    #; #; ===========
    #; #; FIN CAS N°2
    #; #; ===========


    #; #; ===========
    #; #; CAS N°3
    #; #; ===========
    /*
        Exemple d'un email avec contenu en pièce-jointe au format CSV
        ====================================================================================
		Bonjour,

		vous trouverez ci-joint le fichier des personnes.

		Cordialement,
		IRIS
        ====================================================================================
    */
    #; #; ++++++++++
	#; #; début code
    #; #; ++++++++++
    #;
	set attachment=##class(%Stream.GlobalCharacter).%New()
	do ..getAttachment(pInput,.attachment)
	set ^Email("Attachment Data","attachment size")=attachment.Size
	do attachment.Rewind()
    set separator=";"
	while 'attachment.AtEnd {
    #;ID;DateNaissance;Nom;Prenom;Sexe
    #;123;06/03/2008;Smith;Lucie;F
    
		set line=attachment.ReadLine()
		set line=$zstrip(line,"*C")
		
        $$$LOGINFO("attachment "_line)

        if line [ "ID;DateNaissance;Nom;Prenom;Sexe" continue

		Set ID=$Piece(line,separator,1)
		Set DateNaissance=$zdh($Piece(line,separator,2),4)
		Set Nom=$Piece(line,separator,3)
		Set Prenom=$Piece(line,separator,4)
		Set Sexe=$Piece(line,separator,5)

        set request=##class(formation.RM.personne.Record).%New()
        set request.ID=ID
        set request.Nom=Nom
        set request.Prenom=Prenom
        set request.DateNaissance=DateNaissance
        set request.Sexe=Sexe

		set sc=..SendRequestAsync(..TargetConfigNames,request)
		set ^Email("Attachment Data",$i(^Email("Attachment Data")))=line
	}
    #; #; ++++++++++
	#; #; fin code
    #; #; ++++++++++
    #; #; ===========
    #; #; FIN CAS N°3
    #; #; ===========
	
	Quit sc
}

Method getMessageText(msg As %Net.MailMessage, ByRef text As %String)
{
	/// loop until IsMultiPart
	if msg.IsMultiPart {
		for i=1:1:msg.Parts.Count() {
				do ..getMessageText(msg.Parts.GetAt(i),.text)
	 	}
	}
	
	set contentType=msg.Headers.GetAt("content-type") 
	if (contentType["text/plain") && (msg.Headers.GetAt("content-disposition")'["attachment;") {
		do msg.TextData.Rewind() 
		while 'msg.TextData.AtEnd {
			set text=text_msg.TextData.Read() 
		}
	}
}

Method getAttachment(msg As %Net.MailMessage, ByRef attachment As %Stream.GlobalCharacter)
{
	$$$LOGINFO("content-disposition:"_msg.Headers.GetAt("content-disposition"))
	/// trace Headers content in ^Email
	set key=""
	do {
		set content=msg.Headers.GetNext(.key)
		set:key'="" ^Email("Headers",$i(^Email("Headers",key)),key)=content
	} while key'=""
	
	
	/// loop until IsMultiPart
	if msg.IsMultiPart {
		for i=1:1:msg.Parts.Count() {
				do ..getAttachment(msg.Parts.GetAt(i),.attachment)
	 	}
	}
	

    /// "content-type"="text/csv;" 
    /// "content-disposition"=1
   $$$LOGINFO("("_$i(nb)_") content-disposition:"_msg.Headers.GetAt("content-disposition")) 
   $$$LOGINFO("("_$i(nb)_") content-type:"_msg.Headers.GetAt("content-type")) 

   if (msg.Headers.GetAt("content-disposition")["attachment;") && (msg.Headers.GetAt("content-type")["text/csv") {
        $$$LOGINFO("("_$i(nb)_") binary:"_msg.IsBinary)
        
        if msg.IsBinary {
            do msg.BinaryData.Rewind() 
            do attachment.CopyFrom(msg.BinaryData)
            $$$LOGINFO("("_$i(nb)_") size:"_msg.BinaryData.Size)

        }
        else {
            do msg.TextData.Rewind() 
            do attachment.CopyFrom(msg.TextData)
            $$$LOGINFO("("_$i(nb)_") size:"_msg.TextData.Size)
        }
        $$$LOGINFO("("_$i(nb)_") attachment size:"_attachment.Size)
	}

	// when "content-type" contents "application/octet-stream"
	// and  "content-disposition" = "attachment; filename=attachedfile.txt"
	// return BinaryData (ByRef) 
	if (msg.Headers.GetAt("content-type")["application/octet-stream") && (msg.Headers.GetAt("content-disposition")["attachment;") {
		do msg.BinaryData.Rewind() 
		do attachment.CopyFrom(msg.BinaryData)
	}
	
	// when "content=disposition" = "inline; filename=attachedfile.png"
	// write BinaryData in /tmp
	if (msg.Headers.GetAt("content-disposition")["inline") || ((msg.Headers.GetAt("content-type")'["application/octet-stream") && (msg.Headers.GetAt("content-disposition")["filename=")) {
		do msg.BinaryData.Rewind() 
		set filename=$piece(msg.Headers.GetAt("content-disposition"),"filename=",2)
		set file=##class(%File).%New("/tmp/"_$zstrip(filename,"<>P"))
		do file.Open("WSN")
		do file.CopyFrom(msg.BinaryData)
		do file.Close()
	}
}

/// Description
ClassMethod MethodName() As %Status [Language=python]
{
import IRIS


}
ClassMethod OnGetConnections(Output pArray As %String, pItem As Ens.Config.Item)
{
	Do ##super(.pArray,pItem)
	If pItem.GetModifiedSetting("TargetConfigNames",.tValue) {
		For i=1:1:$L(tValue,",") { Set tOne=$ZStrip($P(tValue,",",i),"<>W")  Continue:""=tOne  Set pArray(tOne)="" }
	}
}

}
