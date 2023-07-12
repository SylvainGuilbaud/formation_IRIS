/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

/// Description
Class SC.Test.TestSalesOrderApi
{

ClassMethod testCreateSalesOrder()
{
    set json = {
    "uid": "SO-TEST-1003",
    "customerId": "CUST001",
    "orderStatus": "Open",
    "salesRegion": "USA",
    "shipToLocationId": "LOC-CUST-4",
    "requestedShipDate": "2022-02-18T16:58:35Z",
    "lineItems": [
        {
            "lineNumber": "10",
            "productId": "PROD001",
            "quantity": 100,
            "unitOfMeasure": "Each",
            "shipToLocationId": null,
            "status": "Active"
        },
        {
            "lineNumber": "20",
            "productId": "PROD005",
            "quantity": 20,
            "unitOfMeasure": "Each",
            "status": "Active"
        },
        {
            "lineNumber": "30",
            "productId": "PROD009",
            "quantity": 100,
            "unitOfMeasure": "Each",
            "status": "Active",
            "type": "Product"
        }
    ]
    }
    //set classname = ##class(SC.Core.Util.ScObjectUtil).getObjectClassName("SalesOrder")
    //set so = $System.OBJ.New(classname)
    //do so.%JSONImport(json)
    //set st = so.%Save()
    //if $$$ISOK(st) {
    //    write !,"Sales order created successfully."
    //}
    //else {
    //    do $system.Status.DisplayError(st)
    //    zw so
    //}
    set resp = ##class(SC.Core.API.Data.SalesOrderApiImpl).CreateSalesOrder(json)
    zw resp
}

ClassMethod testOrderLineFormat()
{
    set orderUid = "SO-TEST-1001"
    set lines = ##CLass(SC.Core.API.Data.SalesOrderApiImpl).GetSalesOrderLineArray(orderUid)
    //write !,lines.%ToJSON
    zw lines
}

}
