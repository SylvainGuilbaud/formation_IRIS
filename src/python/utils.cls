Class python.utils
{

Parameter ZIPFILE = "/data/customer.zip";

Parameter DIRECTORY = "/data/customer";

/// Description
ClassMethod test() As %Status
{
    set sc = $$$OK
    set unzipped = ##class(python.utils).UnZip(..#ZIPFILE,..#DIRECTORY)
    write "unzipped files in ",..#DIRECTORY,!,unzipped.%ToJSON(),!
    return sc
}

ClassMethod UnZip(pZipFileName As %String, pExtractToDir As %String) As %DynamicArray [ Language = python ]
{
    import zipfile
    import iris
    with zipfile.ZipFile(pZipFileName, 'r') as zip_ref:
        zip_ref.extractall(pExtractToDir)
        fileList = zip_ref.namelist()

    dynarray = iris.cls("%DynamicArray")._New()
    for file in fileList:
        dynarray._Push(file)
    return dynarray
}

}
