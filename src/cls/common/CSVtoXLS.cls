Class common.CSVtoXLS Extends Ens.BusinessProcess
{

/// Description
ClassMethod XLStoCSV() As %Status [ Language = python ]
{
  import pandas as pd
  read_file = pd.read_excel (r'/data/a.xlsx')
  read_file.to_csv (r'/data/a.csv', index = None, header=True)
}

Method OnRequest(pRequest As Ens.StreamContainer, Output pResponse As Ens.StreamContainer) As %Status
{
    Set tsc = $$$OK

	; Create the response class
	Set pResponse = ##class(Ens.StreamContainer).%New()
	Set pResponse.Stream = ##class(%Stream.GlobalCharacter).%New()
	
	$$$TRACE("Size of Stream: "_pRequest.Stream.SizeGet())
    Set XlsString=..convertCSVtoXLS(pRequest.Stream.Read($$$MaxStringLength))
	Do pResponse.Stream.Write(XlsString)
	
	return tsc
}

ClassMethod convertCSVtoXLS(csvFile As %String(MAXLEN="")) As %String [ Language = python ]
{
    #; This function takes a CSV string as input and converts it into an XLS string.
    
    #; Parameters:
    #; csv_string (str): The CSV string to be converted
    
    #; Returns:
    #; str: Th

    import iris
    import pandas
    import xlwt
    import sys
    import csv
    import tempfile
    from io import StringIO
	
	# Read the CSVdata into a Pandas DataFrame
	
    df = pandas.read_csv(StringIO(csvFile), delimiter=";", decimal=",", dtype={'patno':str} )	
    # Create an instance of Workbook class from xlwt library	
    workbook = xlwt.Workbook()

    # Add a sheet to the workbook
    sheet = workbook.add_sheet('Sheet1')

    # Write the DataFrame values to the sheet
    for i, column in enumerate(df.columns):
        sheet.write(0, i, column)  # Write column headers
        for j, value in enumerate(df[column]):
            if ( str(value) != 'nan' ):       #catch empty cells
                sheet.write(j + 1, i, value)  # Write cell values

    # Write workbook to temporary file
    file = tempfile.TemporaryFile()

    # Save Workbook
    workbook.save(file)

    #Go to the beginning of the file
    file.seek(0)

    #Read from temporary File and return
    data = file.read()
    return(data)
}

/// Description
ClassMethod convert(csv As %String = "/data/CSV/SamplePerson.csv", xls As %String = "/data/CSV/SamplePerson.xlsx") As %Status [ Language = python ]
{
import pandas as pd
data = pd.read_csv(csv)

# Écrire le DataFrame dans un fichier Excel
data.to_excel(xls, index=False, engine='openpyxl')

print(f'Le fichier Excel a été créé : {xls}')
}

/// Description
ClassMethod test(csvFile As %String = "/data/CSV/SamplePerson.csv") As %Status
{
    Set sc = $$$OK

    set filename = $PIECE(csvFile,"/",*)
    set directory = $PIECE(csvFile,filename)
    set xlsFilename = $PIECE(filename,".") _ ".xls" 
    set xls = ##class(%File).%New(directory _ xlsFilename)
    set sc = xls.Open("WSN")
    do xls.Write(##CLASS(common.CSVtoXLS).convertCSVtoXLS(csvFile))
    Return sc
}

ClassMethod Decrypt(Stream As %Stream.GlobalCharacter, key As %String) As %Stream.GlobalCharacter [ Language = python ]
{
    import iris
    import os
    from cryptography.hazmat.primitives import hashes, padding
    from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
    from cryptography.hazmat.backends import default_backend
    from base64 import b64decode

    def stream_to_string(stream)-> str:
        string = ""
        stream.Rewind()
        while not stream.AtEnd:
                        string += stream.Read(1024)
        return string

    def string_to_stream(string:str):
        stream = iris.cls('%Stream.GlobalCharacter')._New()
        n = 1024
        chunks = [string[i:i+n] for i in range(0, len(string), n)]
        for chunk in chunks:
                        stream.Write(chunk)
        return stream

    # Convert the Base64 encoded key to bytes
    key_bytes = b64decode(key)

    cipher_bytes = bytes(stream_to_string(Stream),'iso-8859-1')

    # Extract the IV from the first 16 bytes of the cipher
    iv = cipher_bytes[:16]

    # Create the AES cipher object
    backend = default_backend()
    cipher = Cipher(algorithms.AES(key_bytes), modes.CBC(iv), backend=backend)
    decryptor = cipher.decryptor()

    # Decrypt the data, excluding the IV
    decrypted_bytes = decryptor.update(cipher_bytes[16:]) + decryptor.finalize()

    # Remove padding
    unpadder = padding.PKCS7(algorithms.AES.block_size).unpadder()
    decrypted_data = unpadder.update(decrypted_bytes) + unpadder.finalize()
    
    return string_to_stream(decrypted_data)
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
