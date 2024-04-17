Class python.file Extends %RegisteredObject
{

ClassMethod Test() [ Language = python ]
{
    import iris
    import os
    import re
    import glob
    import shutil
    import gzip
    from datetime import datetime

    # This piece of code sends a request to bbg, and receives a response of the format csv.gz 
    # At the moment, the credential file is being placed under /tmp/ps-credential.txt (Alter line 75)
    # The python module has been modfied in this instance of IRIS to pick up the credentials from this path.
    # The default output media type is application/json, but that has been changed to text/csv (Alter line 162)
    # The downloaded response csv.gz is being placed under /iris-durable-volume/dur/mgr/CUSTOMDATA/downloads
    from per_security import sample_301_data_request_callable

    sample_301_data_request_callable.run_sample_301()

    # Our job after this is two fold:
    # 1. Get the FileDirSourceBasePath - this is a system config.
    # 2. Unzip the contents of the response
    # 3. Place the csv file in the source directory
    # 4. Call super class' PerformLoad
    
    downloads_folder = "/iris-durable-volume/dur/mgr/CUSTOMDATA/downloads"
    sysBasePath = iris.cls('B360.SystemConfig').GetConfigValue("FileDirSourceBasePath")
    
    ########### These paths are only gonna be populated if we create a recipe/data source/data schema definition objects.
    # UNCOMMENT THESE LINES IN THE NEXT ITERATION
    #; sourcePath = os.path.normpath(os.path.join(sysBasePath,pSchemaDefinition.DataSource.InterfacePath,"Source"))
    #; workPath = os.path.normpath(os.path.join(sysBasePath,pSchemaDefinition.DataSource.InterfacePath,"Work"))
    #; archivePath = os.path.normpath(os.path.join(sysBasePath,pSchemaDefinition.DataSource.InterfacePath,"Archive"))

    # Hard-coding the source path, as I created a "BloombergFiles" data source on my local TV instance
    # "Bloomberg" is the Interface Path Location that was supplied at the time of data source creation
    sourcePath = os.path.normpath(os.path.join(sysBasePath,"Bloomberg","Source"))

    # Get the list of files in the downloads folder
    files = os.listdir(downloads_folder)

    # Check if there is exactly one file in the source folder
    if len(files) == 1:
        # Get the filename
        filename = files[0]

        # Check if the file is a .csv.gz file
        if filename.endswith('.csv.gz'):
            # Construct the full paths for source and destination
            downloads_path = os.path.join(downloads_folder, filename)
            destination_path = os.path.join(sourcePath, filename[:-3])

            # Extract the .csv.gz file
            with gzip.open(downloads_path, 'rb') as f_in:
                with open(destination_path, 'wb') as f_out:
                    shutil.copyfileobj(f_in, f_out)
            
            shutil.move(downloads_path, sourcePath)
            print("File extracted and moved successfully.")
    
    ################################## LOAD DATA LOGIC #####################################################################

    print("Trucating table...")
    # iris.cls(stagingTableName)._DeleteExtent()
    rs = iris.sql.exec("TRUNCATE TABLE {}".format('SDS_DataLoader_BO_BloombergCSV.SampleStagingTable'))
    
    print("Loading...")
    lastMeasuredTime  = datetime.now() 

    # This loads all columns
    cmd = "LOAD DATA FROM FILE '{}' INTO {}".format(destination_path, 'SDS_DataLoader_BO_BloombergCSV.SampleStagingTable')+' USING {"from":{"file":{"header":true, "columnseparator": "\u0002"}}}'
        
    # This works and loads only the two mentioned columns
    # cmd = "LOAD DATA FROM FILE '{}' COLUMNS ({}) INTO {} VALUES(effective_date, amount)".format(csvWorkFile, ",".join(sqlFieldType), stagingTableName)+' USING {"maxerrors": 1, "from":{"file":{"header":true, "columnseparator": "\u0002"}}}'

    print(cmd)

    try:
        rs = iris.sql.exec(cmd)
        rowCount=rs.ResultSet._ROWCOUNT

        currentTime  = datetime.now() 
        duration = currentTime-lastMeasuredTime
        duration_in_s = duration.total_seconds()
        loading_speed = rowCount/duration_in_s

        print("Loaded {} rows in {} seconds. A speed of {} records/s.".format(rowCount, duration_in_s, loading_speed))

    except Exception as exception:
        print(exception)


    # Call PerformLoad
    # UNCOMMENT IN THE NEXT ITERATION
    #iris.cls('SDS.DataLoader.BO.CSVFile.Operation').PerformLoad(pLoadItemRequest, pRecipe, pCurrentStagingItemRecord, pLastSuccessfulStagingItemRecord, pSchemaDefinition, pDataSource)
}

}
