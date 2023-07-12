/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Import %Library

/// Utils used to build embedded BI cubes
Class SC.Core.Util.CubeUtil
{

/// Retrieve name of a carrier based on carrier uid
ClassMethod getCarrierName(carrierUid As %String) As %String
{
    set name = ""
    set objName = "Carrier"
    set obj = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objName, carrierUid)
    if ( obj '= "" ) { set name = obj.name}
    return name
}

/// Retrieve name of a product based on product uid
ClassMethod getProductName(prodUid As %String) As %String
{
    set name = ""
    set objName = "Product"
    set obj = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objName, prodUid)
    if ( obj '= "" ) { set name = obj.name}
    return name
}

/// Retrieve brand of a product based on product uid
ClassMethod getProductBrand(prodUid As %String) As %String
{
    set value = ""
    set objName = "Product"
    set obj = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objName, prodUid)
    if ( obj '= "" ) { set value = obj.productBrand}
    return value
}

/// Retrieve category of a product based on product uid
ClassMethod getProductCategory(prodUid As %String) As %String
{
    set value = ""
    set objName = "Product"
    set obj = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objName, prodUid)
    if ( obj '= "" ) { set value = obj.productCategory}
    return value
}

/// Retrieve class of a product based on product uid
ClassMethod getProductClass(prodUid As %String) As %String
{
    set value = ""
    set objName = "Product"
    set obj = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objName, prodUid)
    if ( obj '= "" ) { set value = obj.productClass}
    return value
}

/// Retrieve family of a product based on product uid
ClassMethod getProductFamily(prodUid As %String) As %String
{
    set value = ""
    set objName = "Product"
    set obj = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objName, prodUid)
    if ( obj '= "" ) { set value = obj.productFamily}
    return value
}

/// Retrieve name a customer based on customer uid
ClassMethod getCustomerName(customerUid As %String) As %String
{
    set name = ""
    set customerObject = "Customer"
    set customer = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(customerObject, customerUid)
    if ( customer '= "" ) { set name = customer.name}
    return name
}

/// Retrieve name a supplier based on supplier uid. Returns "" if no supplier record found.
ClassMethod getSupplierName(supplierUid As %String) As %String
{
    set name = ""
    set supplier = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Supplier", supplierUid)
    if ( supplier '= "" ) { set name = supplier.name}
    return name
}

/// Retrieve name a customer based on order uid
ClassMethod getOrderCustomerName(orderUid As %String) As %String
{
    set name = ""
    set orderObject = "SalesOrder"
    set order = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(orderObject, orderUid)
    if ( order '= "" ) { 
        set customerUid = order.customerId
        if customerUid '= "" {
            set customerObject = "Customer"
            set customer = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(customerObject, customerUid)
            if ( customer '= "" ) { set name = customer.name}
        }
    }    
    return name
}

/// Retrieve country for a customer based on customer uid
ClassMethod getOrderCustomerCountry(orderUid As %String) As %String
{
    set country = ""
    set orderObject = "SalesOrder"
    set order = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(orderObject, orderUid)
    if ( order '= "" ) { 
        set customerUid = order.customerId
        if customerUid '= "" {
            set customerObject = "Customer"
            set customer = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(customerObject, customerUid)
            if ( customer '= "" ) { 
                set locationId = customer.primaryLocationId
                if locationId '= "" {
                    set location =  ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Location", locationId)
                    set country = location.country
                }
            }
        }
    }    
    return country
    // The following code is an order of magnitude slower compared to above
    //set orderTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesOrder")
    //set customerTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Customer")
    //set locationTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Location")
    //Set sql = "SELECT l.country FROM "_locationTable_" AS l, "_customerTable_" AS c, "_
    //          orderTable_"AS o WHERE l.uid = c.primaryLocationId AND "_
    //          " c.uid = o.customerId AND o.uid ='"_orderUid_"'"
    //set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    //Set country = ""
    //if rs.%Next() {
    //    Set country = rs.%Get("country")
    //}
	//return country
}

/// Retrieve country for a customer based on customer uid
ClassMethod getCustomerCountry(customerUid As %String) As %String
{
    Set country = ""
    set customer = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Customer", customerUid)
    if ( customer '= "" ) { 
        set locationId = customer.primaryLocationId
        set country = ..getLocationCountry(locationId)
    }
    //set customerTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Customer")
    //set locationTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Location")
    //Set sql = "SELECT l.country FROM "_locationTable_" AS l, "_customerTable_" AS c "_
    //          "WHERE l.uid = c.primaryLocationId AND "_
    //          " c.uid = '"_customerUid_"'"
    //set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    //if rs.%Next() {
    //    Set country = rs.%Get("country")
    //}
	return country
}

/// Retrieve country for a supplier based on supplier uid
ClassMethod getSupplierCountry(supplierUid As %String) As %String
{
    Set country = ""
    set supplier = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Supplier", supplierUid)
    if ( supplier '= "" ) { 
        set locationId = supplier.primaryLocationId
        set country = ..getLocationCountry(locationId)
    }
	return country
}

/// Returns the country of a location
ClassMethod getLocationCountry(locUid As %String) As %String
{
    set country = ""
    if locUid '= "" {
        set location =  ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Location", locUid)
        if location '= "" {
            set country = location.country
        }
    }
    return country
}

/// Returns the state of a location
ClassMethod getLocationState(locUid As %String) As %String
{
    set state = ""
    if locUid '= "" {
        set location =  ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Location", locUid)
        if location '= "" {
            set state = location.stateProvince
        }
    }
    return state
}

/// Get the latest ship date for a given sales order (by uid), Null if no shipment exists
ClassMethod getSOLatestShipdate(soUid As %String) As %DateTime
{
    Set latest = ""
    set shipmentTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesShipment")
    set shipmentLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesShipmentLine")
    set orderLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesOrderLine")
    Set sql = "SELECT MAX(sos.actualShipDate) AS latestShipDate "_
              "FROM "_shipmentTable_" as sos, "_shipmentLineTable_" sosl, "_orderLineTable_" as sol "_
              "WHERE sosl.salesShipmentId = sos.uid AND sosl.salesOrderLineId = sol.uid "_
              "AND sol.salesOrderId = ? "
    set statement = ##class(%SQL.Statement).%New(1)
    set statement.%ObjectSelectMode = 1
    set sc = statement.%Prepare(sql)
    if $$$ISOK(sc) {
        set rs = statement.%Execute(soUid)
        if (rs.%SQLCODE = 0 && rs.%Next()) {
             Set latest = rs.%Get("latestShipDate")
        } else {
            set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
        }
    }
    $$$ThrowOnError(sc)
	return latest
}

/// Calculate the open quantity of an order which has not been shipped. Open quantity if the difference
/// between the total order line quantity (regardless of UOM) and the sum of all shipment lines 
/// quantities for the order. If the value is negative, that means more is shipped than what was 
/// ordered. Return a large number (999999999) if no shipment for the order
ClassMethod getSOOpenQuantity(soUid As %String) As %Numeric
{
    set value = 999999999
    set orderQuantity = ..getSOTotalQuantity(soUid)
    set shippedQuantity = ..getSOShippedQuantity(soUid)
    if (shippedQuantity '= "") && (orderQuantity '= "") {
        set value = orderQuantity - shippedQuantity
    }
    return value
}

/// Returns the total number of line quantity of a sales order
ClassMethod getSOTotalQuantity(soUid As %String) As %Numeric
{
    Set value = 0
    set orderLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesOrderLine")
    Set sql = "SELECT SUM(quantity) AS orderQuantity FROM "_orderLineTable_
              " WHERE salesOrderId = ? "
    set statement = ##class(%SQL.Statement).%New()
    set statement.%ObjectSelectMode = 1
    set sc = statement.%Prepare(sql)
    if $$$ISOK(sc) {
        set rs = statement.%Execute(soUid)
        if (rs.%SQLCODE = 0 && rs.%Next()) {
              Set value = rs.%Get("orderQuantity")
        } else {
            set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
        }
    }
    $$$ThrowOnError(sc)
	return value
}

ClassMethod getSOShippedQuantity(soUid As %String) As %Numeric
{
    Set value = ""
    set orderLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesOrderLine")
    set shipmentLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesShipmentLine")
    Set sql = "SELECT SUM(sosl.quantityShipped) AS shippedQuantity FROM "_orderLineTable_" AS sol, "_
               shipmentLineTable_" AS sosl WHERE sosl.salesOrderLineId = sol.uid "_
              " AND sol.salesOrderId = ? "
    set statement = ##class(%SQL.Statement).%New()
    set statement.%ObjectSelectMode = 1
    set sc = statement.%Prepare(sql)
    if $$$ISOK(sc) {
        set rs = statement.%Execute(soUid)
        if (rs.%SQLCODE = 0 && rs.%Next()) {
            Set value = rs.%Get("shippedQuantity")
        } else {
            set sc = $$$ERROR($$$SQLCode,SQLCODE,$g(%msg))
        }
    }
    $$$ThrowOnError(sc)
	return value
}

/// Returns the committed ship date of a sales order
ClassMethod getSOCommittedShipDate(soUid As %String) As %DateTime
{
    Set committed = ""
    set so = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("SalesOrder", soUid)
    if so '= "" {
        set committed = so.committedShipDate
    }
    return committed
}

/// Get the number of hours late of the last shipment for a SO compared to the committed ship date. 
/// A positive value is the number of hours late, a negative value means the hours early,
/// Return "" if either committed Ship date or shipments exists.
ClassMethod getSOLateShipHours(soUid As %String) As %Numeric
{
    set ret = ""
    set committed = ..getSOCommittedShipDate(soUid)
    if committed '= "" {
        Set latest = ..getSOLatestShipdate(soUid) 
        //w !,"latest = "_latest
        if latest '= "" {
            set ret = ..getDateTimeDiffInHours(committed, latest)
        }   
    } 
    Return ret
}

/// Calculate the difference between two DateTime object, and return the difference in hours.
/// A positive value means the toTime is after fromTime. If either value is "", return "".
ClassMethod getDateTimeDiffInHours(fromTime As %DateTime, toTime As %DateTime) As %Numeric
{
    set ret = ""
    if (fromTime '= "") && (toTime '= "") {
            set endDay = $piece($zdatetimeh(toTime,3),",",1)
            set endTime = $piece($zdatetimeh(toTime,3),",",2)
            set startDay = $piece($zdatetimeh(fromTime,3),",",1)
            set startTime = $piece($zdatetimeh(fromTime,3),",",2)
            //w !,endDay,!
            set ret = ( (endDay-startDay)*24 ) + ( (endTime-startTime)/3600 )
    }
    return ret
}

/// Get the number of hours late for an order, compared to a given target value.
/// Returns 
ClassMethod getSOLateDeliveryHours(soUid As %String, targetTime As %DateTime) As %Numeric
{
    set ret = ""
    set shipments = ..getAllShipmentsForOrder(soUid)
    if shipments '= "" {
        set latestDelivery = ""
        for i=1:1:shipments.Count() {
            set shipment = shipments.GetAt(i)
            set deliveryTime = ..getShipmentDeliveryTime(shipment)
            if latestDelivery = "" { set latestDelivery = deliveryTime }
            else {
                if (deliveryTime '= "") && (deliveryTime]latestDelivery) {
                    set latestDelivery = deliveryTime
                }
            }
        }
        if latestDelivery '= "" {
            set ret = ..getDateTimeDiffInHours(targetTime, latestDelivery)
        }
    }
    return ret
}

/// Returns a list of shipment objects related to a given sales order
ClassMethod getAllShipmentsForOrder(soUid As %String) As %ListOfObjects
{
    set ret = ""
    set shipmentLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesShipmentLine")
    set orderLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesOrderLine")
    set sql ="SELECT ssl.salesShipmentId AS shipmentId FROM "_shipmentLineTable_" AS ssl, "_
              orderLineTable_" AS sol WHERE ssl.salesOrderLineId = sol.uid "_
              "AND sol.salesOrderId = ? "
    set statement = ##class(%SQL.Statement).%New(1)
    set statement.%ObjectSelectMode = 1
    set sc = statement.%Prepare(sql)
    if $$$ISOK(sc) {
        set rs = statement.%Execute(soUid)
        if (rs.%SQLCODE = 0) {
            set ret = ##class(%ListOfObjects).%New()
            while rs.%Next() {
                Set shipmentId = rs.%Get("shipmentId")
                Set shipment = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("SalesShipment", shipmentId)
                do ret.Insert(shipment)
            }
        } else {
            $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
        }
    } else {
        $$$ThrowStatus(sc)
    }
    return ret
}

/// Return the delivery time of a shipment. FIrst try actualTimeOfArrival, if not available, try
/// estimatedTimeOfArrival.
ClassMethod getShipmentDeliveryTime(shipment As SC.Core.Data.SalesShipment) As %DateTime
{
    set ret = ""
    if shipment '= "" {
        set ret = shipment.actualTimeOfArrival
        if ret = "" {
            set ret = shipment.estimatedTimeOfArrival
        }
    }
    return ret
}

/// Retrieve product family for sales order. The response is a comma separated string
ClassMethod GetSOProductFamily(soId As %String) As %String
{
    set orderLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesOrderLine")
    set productTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Product")
    Set sql = "select p.productFamily from " _ productTable _ " as p, "_ orderLineTable _ " as sol "_
              " where p.uid = sol.productId AND sol.salesOrderId = '"_soId_"'"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    if rs.%SQLCODE < 0 {
        $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
    }
    Set family = ""
    while rs.%Next() {
        if family = "" {
            set family = rs.%Get("productFamily")
        }
        else {
            set family = family_","_rs.%Get("productFamily")
        }
    }
	return family
}

/// Retrieve product name(s) for sales order. The response is a comma separated string
ClassMethod GetSOProductName(soId As %String) As %String
{
    set orderLineTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("SalesOrderLine")
    set productTable = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("Product")
    Set sql = "select p.name from "_ productTable _" as p, "_ orderLineTable _" as sol "_
              " where p.uid = sol.productId AND sol.salesOrderId = '"_soId_"'"
    set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
    if rs.%SQLCODE < 0 {
        $$$ThrowStatus($$$ERROR($$$SQLCode,SQLCODE,$g(%msg)))
    }
    Set name = ""
    while rs.%Next() {
        if name = "" {
            set name = rs.%Get("name")
        }
        else {
            set name = name_","_rs.%Get("name")
        }
    }
	return name
}

/// Calculate the number of hours late between two given datetime. If the either value is missing,
/// return "".
ClassMethod getHoursLate(targetValue As %DateTime, actualValue As %DateTime) As %Numeric
{
    set ret = ""
    if (targetValue '= "") && (actualValue '= "") {
        set actualDay = $piece($zdatetimeh(actualValue,3),",",1)
        set actualTime = $piece($zdatetimeh(actualValue,3),",",2)
        set targetDay = $piece($zdatetimeh(targetValue,3),",",1)
        set targetTime = $piece($zdatetimeh(targetValue,3),",",2)
        set ret = ( (actualDay-targetDay)*24 ) + ( (actualTime-targetTime)/3600 )
        //w !,"hours late = ",ret
    } 
    Return ret
}

/// Calculate the number of hours late between two given datetime. If the actualValue if not provided
/// use the current time for the calculation. If the targetValue is not provided, return ""
ClassMethod getHoursLateWithDefaultActual(targetValue As %DateTime, actualValue As %DateTime) As %Numeric
{
    set ret = ""
    if actualValue = "" {
        set actualValue = $zdatetime($HOROLOG,3)
    }
    //w !,"actualValue = "_actualValue
    //w !,"targetValue = "_targetValue
    if targetValue '= "" {
        set actualDay = $piece($zdatetimeh(actualValue,3),",",1)
        set actualTime = $piece($zdatetimeh(actualValue,3),",",2)
        set targetDay = $piece($zdatetimeh(targetValue,3),",",1)
        set targetTime = $piece($zdatetimeh(targetValue,3),",",2)
        set ret = ( (actualDay-targetDay)*24 ) + ( (actualTime-targetTime)/3600 )
        //w !,"hours late = ",ret
    } 
    Return ret
}

/// Calculate the inventory aging status based on expiration date and product agingThreshold.
/// The return values are:
/// Expired: The expiration date of the inventory has passed.
/// Aging: The expiration date has not passed, but it is within the agingThrehold.
/// Undefined: if expiration date is not provded
/// Good: not meeting any of the condition above.
/// 
/// TODO: the logic here is not correct for aging inventory. Do not use, to be revisited later.
ClassMethod getInventoryAgingStatus(productId As %String, expirationDate As %DateTime) As %String
{
    set ret = "Undefined"
    if (expirationDate '= "" ) {
        set ret = "Good"
        set currentDate = $zdatetime($HOROLOG,3)
        set remainingDays = $piece($zdatetimeh(expirationDate,3),",",1) - $piece($zdatetimeh(currentDate,3),",",1)
        if remainingDays < 0 {
            set ret = "Expired"
        }
        else {
            set obj = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Product", productId)
            if ( obj '= "" ) { 
                set agingThreshold = obj.agingThreshold
                if (agingThreshold '= "") && (remainingDays <= agingThreshold ) {
                    set ret = "Aging"
                }
            }
        }
    }
    return ret
}

/// Calculate how many days from now to the target date. A negative value means the target date has passed.
/// Return "" if the targetDate is "". 
ClassMethod getDaysBefore(targetDate As %DateTime) As %Integer
{
    set ret = ""
    if targetDate '= "" {
        set currentDate = $zdatetime($HOROLOG,3)
        set ret = $piece($zdatetimeh(targetDate,3),",",1) - $piece($zdatetimeh(currentDate,3),",",1)
    }
    return ret
}

/// Calculate the inventory status for a product at a location, based on inventory thresholds.
/// Retuned value will be:
/// OutOfStock: if the inventory is less than or equal to 0
/// BelowMinimum: if the inventory is larger than 0 but less than or equal to lower Quantity threshold
/// AboveMaximum: if inventory is abouve upper Quantity threshold
/// Normal: for any other conditions
ClassMethod getInventoryStatusValue(inventory As %Numeric, productId As %String, locationId As String) As %String
{
    set ret = "Normal"
    if inventory <= 0 {
        set ret = "OutOfStock"
    }
    else {
        set threshold = ..getInventoryThresholdByProductLocation(productId, locationId)
        //w !,"Lower threshold",threshold.quantityLowerThreshold
        //w !,"Upper threshold",threshold.quantityUpperThreshold
        if threshold '= "" {
            if (threshold.quantityLowerThreshold '= ""  ) && (inventory <= threshold.quantityLowerThreshold) {
                
                set ret = "BelowMinimum"
            }
            elseif (threshold.quantityUpperThreshold '= ""  ) && (inventory >= threshold.quantityUpperThreshold) {
                set ret = "AboveMaximum"
            }        
        }
    }
    return ret
}

/// Determine the value of an issue object, based on object type.
ClassMethod getIssueImpactedValue(issueId As %Integer) As %Numeric
{
    Set ret = 0
    set issue = ##class(SC.Core.Util.ScObjectUtil).getObjectById("Issue", issueId)
    if issue '= "" {
        set objectType = issue.impactedObjectType
        if objectType '= "" {
            set objectId = issue.impactedObjectId
            if objectType = "SalesOrder" {
                set so = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objectType, objectId)
                if so '= "" {
                    set ret = so.orderValue
                }
            }
            elseif objectType = "PurchaseOrder" {
                set po = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objectType, objectId)
                if po '= "" {
                    set ret = po.orderValue
                }            
            }
            elseif objectType = "SalesShipment" {
                // TODO: add shipment value
            }
            elseif objectType = "SupplyShipment" {
                // TODO: add shipment value
            }
            elseif objectType = "ProductInventory" {
                set pi = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objectType, objectId)
                if pi '= "" {
                    set ret = pi.inventoryValue
                }     
            }
            else {
                // No value for other object types
            }
        }
        
    }
    Return ret
}

/// Determine the country of an issue impact, based on object type.
ClassMethod getIssueImpactedCountry(issueId As %Integer) As %Numeric
{
    Set ret = ""
    set issue = ##class(SC.Core.Util.ScObjectUtil).getObjectById("Issue", issueId)
    if issue '= "" {
        set objectType = issue.impactedObjectType
        if objectType '= "" {
            set objectId = issue.impactedObjectId
            if objectType = "SalesOrder" {
                set so = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objectType, objectId)
                if so '= "" {
                    set ret = ##class(SC.Core.Util.CubeUtil).getCustomerCountry(so.customerId)
                }
            }
            elseif objectType = "PurchaseOrder" {
                set po = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objectType, objectId)
                if po '= "" {
                    set ret = ##class(SC.Core.Util.CubeUtil).getSupplierCountry(po.supplierId)
                }            
            }
            elseif objectType = "SalesShipment" {
                // TODO: add shipment value
            }
            elseif objectType = "SupplyShipment" {
                // TODO: add shipment value
            }
            elseif objectType = "ProductInventory" {
                set pi = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid(objectType, objectId)
                if pi '= "" {
                    set ret = ##class(SC.Core.Util.CubeUtil).getLocationCountry(pi.siteLocationId)
                }     
            }
            else {
                // No country for other object types
            }
        }
        
    }
    Return ret
}

ClassMethod getInventoryQuantity(uid As %String) As %Numeric
{
    set inv = ""
    set inv = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("ProductInventory", uid)
    set quantity = ""
    if inv '= "" {
        set quantity = inv.quantity
    }
    return quantity
}

ClassMethod getInventoryThresholdFromInventoryId(uid As %String) As %ObjectHandle
{
    set inv = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("ProductInventory", uid)
    set locId = inv.siteLocationId
    set prodId = inv.productId
    return ..getInventoryThresholdByProductLocation(prodId, locId)
}

/// Get the inventory threshold object for a given product and location. 
/// Returns "" if either productId or locationId is null, or the threshold value not defined.
ClassMethod getInventoryThresholdByProductLocation(productId As String, locationId As String) As %ObjectHandle
{
    set ret = ""
    if (locationId '= "") && (productId '= "") {
        set thresholdId = ""
        set tableName = ##class(SC.Core.Util.ScObjectUtil).getObjectTableName("InventoryThreshold")
        set sql="select uid from "_tableName_" where productId = ? and siteLocationId = ?"
        set rs = ##class(%SQL.Statement).%ExecDirect(,sql, productId, locationId)
        if ( rs.%SQLCODE = 0 ) {
            if ( rs.%Next() '= 0 ) {
                set thresholdId = rs.uid
            }
        } else {
            if (rs.%SQLCODE '= 100) {
                $$$ThrowStatus($$$ERROR($$$SQLError, rs.%SQLCODE, $g(rs.%Message)))
            }
        }
        if thresholdId '= "" {
            set ret = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("InventoryThreshold", thresholdId)
        }
    }
    return ret
}

ClassMethod getInventoryOverLowerThreshold(uid As %String) As %Numeric
{
    set inv = ""
    set inv = ..getInventoryThresholdFromInventoryId(uid)
    set threshold = ""
    set val = ""
    if inv '= "" {
        set threshold = inv.quantityLowerThreshold
        if threshold '= "" {
            set val = ..getInventoryQuantity(uid) - threshold
        }
    }
    return val
}

ClassMethod getInventoryOverUpperThreshold(uid As %String) As %Numeric
{
    set inv = ""
    set inv = ..getInventoryThresholdFromInventoryId(uid)
    set threshold = ""
    set val = ""
    if inv '= "" {
        set threshold = inv.quantityUpperThreshold
        if threshold '= "" {
            set val = ..getInventoryQuantity(uid) - threshold
        }
    }
    return val
}

ClassMethod getDaysPastExpiration(uid As %String) As %Numeric
{
    set inv = ""
    set inv = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("ProductInventory", uid)
    set exp = ""
    set dif = ""
    if inv '= "" {
        set exp = inv.expirationDate
        if exp '= "" {
            set dif = ##class(%Library.UTC).Diff(##class(%Library.UTC).NowUTC(), exp)/(60*60*24)
        }
    }
    return dif
}

ClassMethod getInventoryCountry(uid As %String) As %String
{
    set inv = ""
    set inv = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("ProductInventory", uid)
    set loc = ""
    set country = ""
    if inv '= "" {
        set luid = inv.siteLocationId
        set loc = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Location", luid)
        if loc '= "" {
            set country = loc.country
        }
    }
    return country
}

ClassMethod getInventoryProductFamily(uid As %String) As %String
{
    set inv = ""
    set inv = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("ProductInventory", uid)
    set prod = ""
    set fam = ""
    if inv '= "" {
        set puid = inv.productId
        set prod = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Product", puid)
        if prod '= "" {
            set fam = prod.productFamily
        }
    }
    return fam
}

ClassMethod getInventoryProductCategory(uid As %String) As %String
{
    set inv = ""
    set inv = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("ProductInventory", uid)
    set prod = ""
    set cat = ""
    if inv '= "" {
        set puid = inv.productId
        set prod = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Product", puid)
        if prod '= "" {
            set cat = prod.productCategory
        }
    }
    return cat
}

ClassMethod getInventoryProductBrand(uid As %String) As %String
{
    set inv = ""
    set inv = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("ProductInventory", uid)
    set prod = ""
    set fam = ""
    if inv '= "" {
        set puid = inv.productId
        set prod = ##class(SC.Core.Util.ScObjectUtil).getObjectByUid("Product", puid)
        if prod '= "" {
            set fam = prod.productBrand
        }
    }
    return fam
}

}
