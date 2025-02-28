/// Claudio Devecchi 2024-12-05
/// connect to mongodb using pymongo package
/// ex of mongouri: mongodb+srv://&ltdb_user&gt:&ltdb_password&gt@cluster0.y1uie.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0&tlsAllowInvalidCertificates=true
Class custom.crud Extends %RegisteredObject
{

/// return a %DynamicArray ResultSet from MongoDB
/// query is the dictionary for filtering
/// fields is the projection (empty json for all properties)
/// sort is for ordering (empty json for default order)
/// limit is the N first records. Default is 0 for all
ClassMethod Query(mongouri As %String, credentials As %String = "", dbName As %String, collectionName As %String, query As %DynamicObject, fields As %DynamicObject, sort As %DynamicObject, limit As %Integer = 0) As %DynamicObject [ WebMethod ]
{
    set uri = mongouri
    if credentials'="" set uri=..GetUri(uri,credentials)
    if '$Data(query)||'$IsObject(query) set query = {}
    if '$Data(fields)||'$IsObject(fields) set fields = {}
    if '$Data(sort)||'$IsObject(sort) set sort = {}
    if '$Data(limit) set limit = 0
    set tMongoResultSet = ..QueryMongoDB(uri,dbName,collectionName, query.%ToJSON(), fields.%ToJSON(), sort.%ToJSON(), limit)
    quit [].%FromJSON(tMongoResultSet)
}

/// objOrArray is the obj or array to be inserted or updated(one or more values) 
/// for update set filterForUpdate (can be individual(ex:_id) or many)
ClassMethod InsertOrUpdate(mongouri As %String, credentials As %String = "", dbName, collectionName, objOrArray As %DynamicObject, filterForUpdate As %DynamicObject) As %DynamicObject [ WebMethod ]
{
    if '$Data(filterForUpdate)||'$IsObject(filterForUpdate) set filterForUpdate = {}
    set uri = mongouri
    if credentials'="" set uri=..GetUri(uri,credentials)
    set result = ..InsertOrUpdateMongoDB(uri, dbName, collectionName, objOrArray.%ToJSON(),filterForUpdate.%ToJSON())
    quit {}.%FromJSON(result)
}

/// for mongoDB deletion (filter the object or objects to delete)
/// deleteMany is false by default
ClassMethod Delete(mongouri As %String, credentials As %String = "", dbName, collectionName, filter As %DynamicObject, deleteMany = 0) As %DynamicObject [ WebMethod ]
{
    if '$Data(deleteMany) set deleteMany = 0
    set uri = mongouri
    if credentials'="" set uri=..GetUri(uri,credentials)
    set result = ..DeleteMongoDB(uri, dbName, collectionName,filter.%ToJSON(), deleteMany)
    quit {}.%FromJSON(result)
}

/// given an mongo uri connection string, replaces <db_user> and <db_password> for IRIS credentials
ClassMethod GetUri(uri As %String, credentials As %String) As %String
{
    set tUri = uri
    set tClassname=$zobjmethod($this,"%ClassName",1) 
    set tSC=##Class(Ens.Config.Credentials).GetCredentialsObj(.tCred,tClassname,"Ens.Config.Credentials",credentials)
    If 'tSC { Throw ##Class(%Exception.StatusException).CreateFromStatus(tSC) }
    set tUri=$Replace($Replace($Replace($Replace($Replace($Replace($Replace(tUri,"<user>","<usr>"),"<db_user>","<usr>"),"<username>","<usr>"),"<password>","<pwd>"),"<db_password>","<pwd>"),"<pwd>",tCred.PasswordGet()),"<usr>",tCred.Username)
    quit tUri
}

/// for mongoDB deletion (filter the object or objects to delete)
/// deleteMany is false by default
ClassMethod DeleteMongoDB(uri, dbName, collectionName, filter, deleteMany) As %SYS.Python [ Language = python ]
{
    import json
    from datetime import date, datetime
    from bson import ObjectId
    from pymongo import MongoClient
    if not deleteMany:
        deleteMany = 0

    def is_iso_format(value):
        if not isinstance(value, str):
            return False
        if len(value) < 10 or value[4] != "-" or value[7] != "-":
            return False
        try:
            datetime.fromisoformat(value)
            return True
        except ValueError:
            return False

    def object_hook(d):
        for key, value in d.items():
            if is_iso_format(value):
                try:
                    # Try to convert strings to ISO datetime
                    d[key] = datetime.fromisoformat(value)
                except ValueError:
                    pass  # ignore
            if isinstance(value, str) and len(value) == 24:
                try:
                    d[key] = ObjectId(value)
                except Exception:
                    pass  # ignore
        return d

    def json_serial(obj):
        if isinstance(obj, (datetime, date)):
            return obj.isoformat()
        if isinstance(obj, ObjectId):
            return str(obj)
        raise TypeError ("Type %s not serializable" % type(obj))

    client = MongoClient(uri)
    db = client[dbName] 
    collection = db[collectionName]    
    filter = json.loads(filter, object_hook=object_hook)

    if deleteMany == 1:
        res = collection.delete_many(filter)
    else:
        res = collection.delete_one(filter)

    client.close()
    response = {
        "deleted_count": res.deleted_count,  
        "acknowledged": res.acknowledged  
    }
    return json.dumps(response,default=json_serial)
}

/// jsonObjOrArray is the obj or array to be inserted or updated(one or more values) 
/// for update set filterForUpdate (can be individual(ex:_id) or many)
ClassMethod InsertOrUpdateMongoDB(uri, dbName, collectionName, jsonObjorArray, filterForUpdate) As %SYS.Python [ Language = python ]
{
    import json
    from datetime import date, datetime
    from bson import ObjectId
    from pymongo import MongoClient

    def is_iso_format(value):
        if not isinstance(value, str):
            return False
        if len(value) < 10 or value[4] != "-" or value[7] != "-":
            return False
        try:
            datetime.fromisoformat(value)
            return True
        except ValueError:
            return False

    def object_hook(d):
        for key, value in d.items():
            if is_iso_format(value):
                try:
                    # Try to convert strings to ISO datetime
                    d[key] = datetime.fromisoformat(value)
                except ValueError:
                    pass  # ignore
            if isinstance(value, str) and len(value) == 24:
                try:
                    d[key] = ObjectId(value)
                except Exception:
                    pass  # ignore
        return d

    def json_serial(obj):
        if isinstance(obj, (datetime, date)):
            return obj.isoformat()
        if isinstance(obj, ObjectId):
            return str(obj)
        raise TypeError ("Type %s not serializable" % type(obj))

    client = MongoClient(uri)
    db = client[dbName] 
    collection = db[collectionName]    
    newData = json.loads(jsonObjorArray, object_hook=object_hook)
    filter = json.loads(filterForUpdate, object_hook=object_hook)

    if filter:
        newData = {"$set": newData}
        res = collection.update_many(filter,newData)
    elif type(newData) is dict:
        res = collection.insert_one(newData)
    elif type(newData) is list:
        res = collection.insert_many(newData)

    client.close()
    if filter:
        response = {
            "matched_count": res.matched_count,  
            "modified_count": res.modified_count,  
            "acknowledged": res.acknowledged  
        }
    elif type(newData) is dict:
        response = {
                "message": "Success",
                "inserted_id": res.inserted_id
        }
    elif type(newData) is list:
        response = {
                "message": "Success",
                "inserted_ids": res.inserted_ids
        }
    return json.dumps(response,default=json_serial)
}

/// return a %DynamicArray ResultSet from MongoDB
/// query is the dictionary for filtering
/// fields is the projection (empty json for all properties)
/// sort is for ordering (empty json for default order)
/// limit is the N first records. Default is 0 for all
ClassMethod QueryMongoDB(uri, dbName, collectionName, query, fields, sort, limit) As %SYS.Python [ Language = python ]
{
    import json
    from datetime import date, datetime
    from bson import ObjectId
    from pymongo import MongoClient

    def is_iso_format(value):
        if not isinstance(value, str):
            return False
        if len(value) < 10 or value[4] != "-" or value[7] != "-":
            return False
        try:
            datetime.fromisoformat(value)
            return True
        except ValueError:
            return False

    def object_hook(d):
        for key, value in d.items():
            if is_iso_format(value):
                try:
                    # Try to convert strings to ISO datetime
                    d[key] = datetime.fromisoformat(value)
                except ValueError:
                    pass  # ignore
            if isinstance(value, str) and len(value) == 24:
                try:
                    d[key] = ObjectId(value)
                except Exception:
                    pass  # ignore
        return d

    def json_serial(obj):
        if isinstance(obj, (datetime, date)):
            return obj.isoformat()
        if isinstance(obj, ObjectId):
            return str(obj)
        raise TypeError ("Type %s not serializable" % type(obj))

    query = json.loads(query, object_hook=object_hook)
    fields = json.loads(fields)
    sort = json.loads(sort)

    client = MongoClient(uri)
    db = client[dbName] 
    collection = db[collectionName]    
    results = collection.find(query, fields)
    if sort:
        results = results.sort(sort)
    if limit>0:
        results = results.limit(limit)
    res = []
    for record in results:
        res.append(record)
    client.close()
    return json.dumps(res,default=json_serial)
}

/// Validates the mongo connection, given an uri connection string
ClassMethod ValidateConnection(uri, timeout = 5) As %SYS.Python [ Language = python ]
{
    if not timeout:
        timeout = 5

    from pymongo import MongoClient
    from pymongo.errors import ConnectionFailure, InvalidURI

    def validate(uri):
        try:
            client = MongoClient(uri, serverSelectionTimeoutMS=timeout*1000)  
            client.server_info()  # Force an execution
            return "1"
        except InvalidURI:
            return "0:Invalid Connection String"
        except ConnectionFailure:
            return "0:Not Possible to Connect to MongoDB"
        except Exception as e:
            return "0:Unknown Error"

    return validate(uri)
}

XData %import [ MimeType = application/python ]
{
import pymongo
}

}
