using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Runtime.Remoting.Channels;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;

String                                   ls_Basic, ls_UserName, ls_Password, ls_Body
Integer                                  li_Return
CoderObject                         lco_Code
HttpClient                             lhc_Client
lco_Code = Create CoderObject
lhc_Client = Create HttpClient
 
ls_UserName = "user_xyz"
ls_Password = "xxxxxxxxxx"
ls_Basic = lco_code.base64encode( Blob(ls_UserName + ":" + ls_Password , EncodingUTF8!))

Patient bsObj = new Patient()
{
    Nom = "nom patient",
    IPP = "IPP patient"
    // etc.
};

lhc_Client.SetRequestHeader( "Authorization", "Basic " + ls_Basic)

numero_episode = "12345678"

li_Return = lhc_Client.SendRequest("GET", " http://patient.portal.com/patient/" + numero_episode)

If li_Return = 1 And lhc_Client.GetResponseStatusCode() = 200 Then

                lhc_Client.GetResponseBody(ls_Body)

                MessageBox ("Reponse" ,ls_Body )

                using (var ms = new MemoryStream(Encoding.Unicode.GetBytes(ls_Body)))
                {
                // Deserialization from JSON
                DataContractJsonSerializer deserializer = new DataContractJsonSerializer(typeof(Patient));
                Patient bsObj2 = (Patient)deserializer.ReadObject(ms);
                Response.Write("Nom: " + bsObj2.Nom); 
                Response.Write("IPP: " + bsObj2.IPP); 
                // etc.
                }

End If
Destroy ( lco_Code )
Destroy ( lhc_Client )