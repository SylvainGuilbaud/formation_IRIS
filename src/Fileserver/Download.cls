/// One download of a file. 
Class Fileserver.Download Extends %Persistent
{

/// Creation date of download  in <i>YYYY-MM-DD hh:mm:ss</i> format.
Property DateCreated As %TimeStamp;

/// Download (as in file transfer) may be initiatyed by a client until this date in <i>YYYY-MM-DD hh:mm:ss</i> format.
Property DateActiveUntil As %TimeStamp;

/// IP of a client initiated creation of download.
Property IP As %String;

/// Random letter combination. NOT a private key.
Property DownloadID As %String(MAXLEN = 100) [ Required ];

/// Number of filetransfers occured for this download.
Property DownloadCount As %Integer [ InitialExpression = "0", Required ];

Index DownloadIDIndex On DownloadID [ Unique ];

/// File to download.
Relationship File As Fileserver.File [ Cardinality = one, Inverse = Downloads, OnDelete = setnull ];

// Index FileIndex On FileTarg;

/// Generate and set DownloadID. Generates random upper case string, from 64 to 96 symbols 
Method DownloadIDGenerate() As %Status [ ServerOnly = 1 ]
{
		
	set temp = ""
	set length = 64 + $Random(33)
	for {
    	set temp = temp _ $Char(65 + $Random(25))
    	quit:$Length(temp)>length
	}

	set ..DownloadID = temp
	Quit $$$OK
}

Storage Default
{
<Data name="DownloadDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DateCreated</Value>
</Value>
<Value name="3">
<Value>DateActiveUntil</Value>
</Value>
<Value name="4">
<Value>IP</Value>
</Value>
<Value name="5">
<Value>DownloadID</Value>
</Value>
<Value name="6">
<Value>File</Value>
</Value>
<Value name="7">
<Value>FileTarg</Value>
</Value>
<Value name="8">
<Value>DownloadCount</Value>
</Value>
</Data>
<DataLocation>^Fileserver.DownloadD</DataLocation>
<DefaultData>DownloadDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Fileserver.DownloadD</IdLocation>
<IndexLocation>^Fileserver.DownloadI</IndexLocation>
<StreamLocation>^Fileserver.DownloadS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
