/// crud operations for mongodb 
/// Claudi Devecchi 2024-12-05
Class custom.outboundAdapter Extends Ens.OutboundAdapter [ ClassType = "", ProcedureBlock, System = 4 ]
{

/// ex: mongodb+srv://&ltdb_user&gt:&ltdb_password&gt@cluster0.y1uie.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0&tlsAllowInvalidCertificates=true
Property MongoUri As %String(MAXLEN = "") [ InitialExpression = "mongodb+srv://<db_user>:<db_password>@clusterXXX.mongodb.net/?retryWrites=true&w=majority&appName=clusterXXX&tlsAllowInvalidCertificates=true" ];

/// Number of seconds to wait on each connection attempt
Property ConnectTimeout As %Numeric(MINVAL = 0) [ InitialExpression = 5 ];

/// Credentials for &ltdb_user&gt:&ltdb_password&gt string inside MongoUri (opaque)
Property Credentials As %String;

Parameter SETTINGS = "MongoUri:MongoDB,ConnectTimeout:MongoDB,Credentials:MongoDB:credentialsSelector";

Method OnInit() As %Status
{
    Set tSC=$$$OK
	Quit tSC
}

/// return a %DynamicArray ResultSet from MongoDB
/// query is the dictionary for filtering
/// fields is the projection (empty json for all properties)
/// sort is for ordering (empty json for default order)
/// limit is the N first records. Default is 0 for all
Method Query(dbName, collectionName, query As %DynamicObject, fields As %DynamicObject, sort As %DynamicObject, limit As %Integer = 0) As %DynamicObject [ WebMethod ]
{
    set uri = ..MongoUri
    if ..Credentials'="" set uri=##class(custom.crud).GetUri(uri,..Credentials)
    if '$Data(query)||'$IsObject(query) set query = {}
    if '$Data(fields)||'$IsObject(fields) set fields = {}
    if '$Data(sort)||'$IsObject(sort) set sort = {}
    if '$Data(limit) set limit = 0
    set tMongoResultSet = ##class(custom.crud).QueryMongoDB(uri,dbName,collectionName, query.%ToJSON(), fields.%ToJSON(), sort.%ToJSON(), limit)
    quit [].%FromJSON(tMongoResultSet)
}

/// objOrArray is the obj or array to be inserted or updated(one or more values) 
/// for update set filterForUpdate (can be individual(ex:_id) or many)
Method InsertOrUpdate(dbName, collectionName, objOrArray As %DynamicObject, filterForUpdate As %DynamicObject) As %DynamicObject [ WebMethod ]
{
    if '$Data(filterForUpdate)||'$IsObject(filterForUpdate) set filterForUpdate = {}
    set uri = ..MongoUri
    if ..Credentials'="" set uri=##class(custom.crud).GetUri(uri,..Credentials)
    set result = ##class(custom.crud).InsertOrUpdateMongoDB(uri, dbName, collectionName, objOrArray.%ToJSON(),filterForUpdate.%ToJSON())
    quit {}.%FromJSON(result)
}

/// for mongoDB deletion (filter the object or objects to delete)
/// deleteMany is false by default
Method Delete(dbName, collectionName, filter As %DynamicObject, deleteMany = 0) As %DynamicObject [ WebMethod ]
{
    if '$Data(deleteMany) set deleteMany = 0
    set uri = ..MongoUri
    if ..Credentials'="" set uri=##class(custom.crud).GetUri(uri,..Credentials)
    set result = ##class(custom.crud).DeleteMongoDB(uri, dbName, collectionName,filter.%ToJSON(), deleteMany)
    quit {}.%FromJSON(result)
}

}
