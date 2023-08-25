/// Description
Class utils.HL7
{

ClassMethod PrintPropertyPaths()
{
 set string="MSH|^~\&|MIHIN PATIENT GEN|1.2.3.4.5.9.99.999.9999.1004||2.16.840.1.113883.3.1481|20200103000000+0000||ADT^A01^ADT_A01|1092|P|2.6|1091|||||||||Windward General Hospital"_$C(13,10)_
            "EVN||20200110000000+0000|||||1.2.3.4.5.9.99.999.9999.1004"_
            "PID|1|3170|44c8a6bba5c743538e476a813256959b^^^^CKS~000003170^^^^SS||Santana^Pearl||19900609|F||2054-5^Black or African American^HL70005|364 NE Oak Circle^^Trenton^MI^48183||||||||000003170|||N^Not Hispanic or Latino^HL70189|||||||20200110000000+0000|N"_$C(13,10)_
            "PD1|||Windward General Hospital^^^^^^^^^1.2.3.4.5.9.99.999.9999.1004|9999992221^Johnston^Karl^^^^^^^^^^NPI^^^^^^^^MD"_$C(13,10)_
            "PV1|1|I|^^67^1.2.3.4.5.9.99.999.9999.1004||||9999992221^Johnston^Karl^^^^^^^^^^NPI||||||||||||17a5e3aa59a34ad5af017998278a5eb5||||||||||||||||||&HOME^20200110000000+0000|||||||20200103000000DG1|1||Z34.90^Normal pregnancy^I10||20200103000000+0000|F|^Become_Pregnant"_$C(13,10)_
            "IN1|1|1772^STATE HEALTH PLAN|1027|MEDICAID||||||||||||Santana^Pearl^Gladys|||364 NE Oak Circle^^Trenton^MI^48183"_$C(13,10)
 set target=##class(EnsLib.HL7.Message).ImportFromString(string,.status)
 if 'status {do $system.Status.DisplayError(status) quit}
 set target.DocType="2.6:ADT_A01"
 do target.GetContentArray(.propertyPaths,, target.DocType)
 for i=1:1:propertyPaths {
   for j=1:1:propertyPaths(i) {
     w i, ".", j, propertyPaths(i,j, "name"), !
   }
 }
}

/// Description
ClassMethod removeSegment(ByRef msgHL7 As EnsLib.HL7.Message) As %Status
{
    set sc = $$$OK
    set string="MSH|^~\&|MIHIN PATIENT GEN|1.2.3.4.5.9.99.999.9999.1004||2.16.840.1.113883.3.1481|20200103000000+0000||ADT^A01^ADT_A01|1092|P|2.6|1091|||||||||Windward General Hospital"_$C(13,10)_
            "EVN||20200110000000+0000|||||1.2.3.4.5.9.99.999.9999.1004"_
            "PID|1|3170|44c8a6bba5c743538e476a813256959b^^^^CKS~000003170^^^^SS||Santana^Pearl||19900609|F||2054-5^Black or African American^HL70005|364 NE Oak Circle^^Trenton^MI^48183||||||||000003170|||N^Not Hispanic or Latino^HL70189|||||||20200110000000+0000|N"_$C(13,10)_
            "PD1|||Windward General Hospital^^^^^^^^^1.2.3.4.5.9.99.999.9999.1004|9999992221^Johnston^Karl^^^^^^^^^^NPI^^^^^^^^MD"_$C(13,10)_
            "PV1|1|I|^^67^1.2.3.4.5.9.99.999.9999.1004||||9999992221^Johnston^Karl^^^^^^^^^^NPI||||||||||||17a5e3aa59a34ad5af017998278a5eb5||||||||||||||||||&HOME^20200110000000+0000|||||||20200103000000DG1|1||Z34.90^Normal pregnancy^I10||20200103000000+0000|F|^Become_Pregnant"_$C(13,10)_
            "IN1|1|1772^STATE HEALTH PLAN|1027|MEDICAID||||||||||||Santana^Pearl^Gladys|||364 NE Oak Circle^^Trenton^MI^48183"_$C(13,10)
    set msgHL7=##class(EnsLib.HL7.Message).ImportFromString(string,.status)
    if 'status {do $system.Status.DisplayError(status) quit}
    set msgHL7.DocType="2.6:ADT_A01"
    set sc = msgHL7.%Save()
    
    set msgTemp = msgHL7.%ConstructClone()
    set sc = msgTemp.%Save()
    write msgTemp.%Id(),!
    set ind = ""
    set EVNSeg = msgTemp.FindSegment("EVN",.ind)
    if EVNSeg '= ""
    {
        set res = msgTemp.RemoveSegmentAt(ind)
    }
    set msgHL7 = msgTemp
    #; set sc = msgHL7.%Save()
    write msgHL7.%Id(),!

    Return sc
}

}
