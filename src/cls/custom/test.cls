/// Sample Method to show how to use mongodb crud methods from iris
/// the same applies to interop (custom.outboundAdapter), but the uri and credentials are part of adapter/bo properties
/// example: ..Adapter.Query("mydb", "mycollection", {"_id":(tPatientId)})
Class custom.test Extends %RegisteredObject
{

ClassMethod TestMongoDBCrud() As %Status
{
        Set sc = $$$OK
        Set mongoUri = "mongodb+srv://root:example@localhost:27017/?retryWrites=true&w=majority&appName=Cluster0&tlsAllowInvalidCertificates=true"
        Set irisCredentials = "mongodb" //tthe credential must have been created or the username and password will be explicit in your connection string. In this case, this variable must be empty
        Write "=========================== Query Response ==============================",!
        /// query names that start with the A letter
        Set queryResponse = ##class(custom.crud).Query(mongoUri, irisCredentials, "sample_mflix", "users", {"name": {"$regex": "^A", "$options": "i"}},{"_id":1,"name":1})
        Set cursor = queryResponse.%GetIterator()
        While (cursor.%GetNext(.key,.value)) {
            Write value.%ToJSON(),!
        }
        Write "=========================================================================",!!
        Write "========================== Insert Response ==============================",!
        /// insert a new user
        Set newUser = {
            "name":"Claudio Devecchi Junior",
            "email":"devechi@inter.com"
        }
        // check if the user exists
        Set tClaudiosId = ""
        Set queryResponse = ##class(custom.crud).Query(mongoUri, irisCredentials, "sample_mflix", "users", {"name":"Claudio Devecchi Junior"})
        If queryResponse.%Size()=0 {
            Set insertResponse = ##class(custom.crud).InsertOrUpdate(mongoUri, irisCredentials, "sample_mflix", "users", newUser)
            Write insertResponse.%ToJSON(),!
            Set tClaudiosId = insertResponse.%Get("inserted_id")
        } else {
            Set tClaudiosId = queryResponse.%Get(0).%Get("_id")
            Write "Claudio Already Exists: _id: ",tClaudiosId,!
        }
        Write "=========================================================================",!!
        Write "========================== Update Response ==============================",!
        Write "Changes the email for _id: ",tClaudiosId,!
        Set beforeUpdateResponse = ##class(custom.crud).Query(mongoUri, irisCredentials, "sample_mflix", "users", {"_id":(tClaudiosId)})
        Write "before update:",!
        Write beforeUpdateResponse.%ToJSON(),!
        Set updateResponse = ##class(custom.crud).InsertOrUpdate(mongoUri, irisCredentials, "sample_mflix", "users", {"email":"claudio.devechi@inter.com"}, {"_id":(tClaudiosId)})
        Write updateResponse.%ToJSON(),!
        Set afterUpdateResponse = ##class(custom.crud).Query(mongoUri, irisCredentials, "sample_mflix", "users", {"_id":(tClaudiosId)})
        Write "after update:",!
        Write afterUpdateResponse.%ToJSON(),!
        Write "=========================================================================",!!
        Write "========================== Delete Response ==============================",!
        Set deleteResponse = ##class(custom.crud).Delete(mongoUri, irisCredentials, "sample_mflix", "users", {"_id":(tClaudiosId)})
        Write deleteResponse.%ToJSON(),!
        Write "=========================================================================",!!
        Return sc
}

}
