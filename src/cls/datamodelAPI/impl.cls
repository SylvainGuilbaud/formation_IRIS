/// API for InterSystems IRIS supply chain data model<br/>
/// Business logic class defined by OpenAPI in datamodelAPI.spec<br/>
/// Updated Mar 19, 2024 12:24:14
Class datamodelAPI.impl Extends %REST.Impl [ ProcedureBlock ]
{

/// If ExposeServerExceptions is true, then details of internal errors will be exposed.
Parameter ExposeServerExceptions = 1;

/// Returns the version of the backend.
ClassMethod GetBackendVersion() As %Stream.Object
{
    return ##class(App.Version).GetLatestVersion()
}

/// Returns the definition of the specified data objects<br/>
/// The method arguments hold values for:<br/>
///     objectName, object name<br/>
ClassMethod GetObjectDefinitionByName(objectName As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ObjectApiImpl).GetObjectDefinitionByName(objectName)
}

/// Get the list of all objects defined in the system
ClassMethod GetObjects() As %DynamicObject
{
    return ##class(SC.Core.API.Data.ObjectApiImpl).GetObjects()
}

/// Add a custom attribute to an object<br/>
/// The method arguments hold values for:<br/>
///     objectName, Object name<br/>
///     body<br/>
ClassMethod AddAttribute(objectName As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ObjectApiImpl).AddAttribute(objectName, body)
}

/// Returns details about a particular location<br/>
/// The method arguments hold values for:<br/>
///     locationId, ID of the Location<br/>
ClassMethod GetLocationById(locationId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.LocationApiImpl).GetLocationById(locationId)
}

/// Create a new location<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateLocation(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.LocationApiImpl).CreateLocation(body)
}

/// Delete existing location<br/>
/// The method arguments hold values for:<br/>
///     locationId, ID of the location<br/>
ClassMethod DeleteLocation(locationId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.LocationApiImpl).DeleteLocation(locationId)
}

/// Update one location<br/>
/// The method arguments hold values for:<br/>
///     locationId, ID of the location<br/>
///     body, New location info<br/>
ClassMethod UpdateLocation(locationId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.LocationApiImpl).UpdateLocation(locationId, body)
}

/// Get all locations
ClassMethod GetLocations() As %DynamicObject
{
    return ##class(SC.Core.API.Data.LocationApiImpl).GetLocations()
}

/// Get all customers in the server, truncate after certain number
ClassMethod GetCustomers() As %DynamicObject
{
    return ##class(SC.Core.API.Data.CustomerApiImpl).GetCustomers()
}

/// Returns details about a particular customer<br/>
/// The method arguments hold values for:<br/>
///     customerId, ID of the customer<br/>
ClassMethod GetCustomerById(customerId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.CustomerApiImpl).GetCustomerById(customerId)
}

/// Add a new customer<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateCustomer(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.CustomerApiImpl).CreateCustomer(body)
}

/// Delete existing Customer<br/>
/// The method arguments hold values for:<br/>
///     customerId, ID of the customer<br/>
ClassMethod DeleteCustomer(customerId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.CustomerApiImpl).DeleteCustomer(customerId)
}

/// Update one customer customer<br/>
/// The method arguments hold values for:<br/>
///     customerId, ID of the customer<br/>
///     body, New customer info<br/>
ClassMethod UpdateCustomer(customerId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.CustomerApiImpl).UpdateCustomer(customerId, body)
}

/// Get all products in the server, truncate after certain number
ClassMethod GetProducts() As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductApiImpl).GetProducts()
}

/// Returns details about a particular product<br/>
/// The method arguments hold values for:<br/>
///     productId, Unique ID of the product<br/>
ClassMethod GetProductById(productId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductApiImpl).GetProductById(productId)
}

/// Add a new product<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateProduct(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductApiImpl).CreateProduct(body)
}

/// Delete an existing product<br/>
/// The method arguments hold values for:<br/>
///     productId, Unique ID of the product<br/>
ClassMethod DeleteProduct(productId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductApiImpl).DeleteProduct(productId)
}

/// Update one product<br/>
/// The method arguments hold values for:<br/>
///     productId, Unique ID of the product<br/>
///     body, New product info<br/>
ClassMethod UpdateProduct(productId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductApiImpl).UpdateProduct(productId, body)
}

/// Get all suppliers in the server, truncate after certain number
ClassMethod GetSuppliers() As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplierApiImpl).GetSuppliers()
}

/// Returns details about a particular supplier<br/>
/// The method arguments hold values for:<br/>
///     supplierId, Unique ID of the supplier<br/>
ClassMethod GetSupplierById(supplierId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplierApiImpl).GetSupplierById(supplierId)
}

/// Add a new supplier<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSupplier(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplierApiImpl).CreateSupplier(body)
}

/// Delete an existing supplier<br/>
/// The method arguments hold values for:<br/>
///     supplierId, Unique ID of the supplier<br/>
ClassMethod DeleteSupplier(supplierId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplierApiImpl).DeleteSupplier(supplierId)
}

/// Update one supplier<br/>
/// The method arguments hold values for:<br/>
///     supplierId, Unique ID of the supplier<br/>
///     body, New supplier info<br/>
ClassMethod UpdateSupplier(supplierId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplierApiImpl).UpdateSupplier(supplierId, body)
}

/// Get all carriers in the server, truncate after certain number
ClassMethod GetCarriers() As %DynamicObject
{
    return ##class(SC.Core.API.Data.CarrierApiImpl).GetCarriers()
}

/// Returns details about a particular carrier<br/>
/// The method arguments hold values for:<br/>
///     carrierId, Unique ID of the carrier<br/>
ClassMethod GetCarrierById(carrierId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.CarrierApiImpl).GetCarrierById(carrierId)
}

/// Add a new carrier<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateCarrier(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.CarrierApiImpl).CreateCarrier(body)
}

/// Delete an existing carrier<br/>
/// The method arguments hold values for:<br/>
///     carrierId, Unique ID of the carrier<br/>
ClassMethod DeleteCarrier(carrierId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.CarrierApiImpl).DeleteCarrier(carrierId)
}

/// Update one carrier<br/>
/// The method arguments hold values for:<br/>
///     carrierId, Unique ID of the carrier<br/>
///     body, New carrier info<br/>
ClassMethod UpdateCarrier(carrierId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.CarrierApiImpl).UpdateCarrier(carrierId, body)
}

/// Get all BOMs in the server, truncate after certain number
ClassMethod GetBOMs() As %DynamicObject
{
    return ##class(SC.Core.API.Data.BomApiImpl).GetBOMs()
}

/// Returns details about a particular bill of material<br/>
/// The method arguments hold values for:<br/>
///     bomId, Unique ID of the BOM<br/>
ClassMethod GetBOMById(bomId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.BomApiImpl).GetBOMById(bomId)
}

/// Add a new BOM<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateBOM(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.BomApiImpl).CreateBOM(body)
}

/// Delete an existing BOM<br/>
/// The method arguments hold values for:<br/>
///     bomId, Unique ID of the BOM<br/>
ClassMethod DeleteBOM(bomId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.BomApiImpl).DeleteBOM(bomId)
}

/// Update one BOM<br/>
/// The method arguments hold values for:<br/>
///     bomId, Unique ID of the BOM<br/>
///     body, New BOM info<br/>
ClassMethod UpdateBOM(bomId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.BomApiImpl).UpdateBOM(bomId, body)
}

/// Get all demand plans in the server, truncate after certain number
ClassMethod GetDemandPlans() As %DynamicObject
{
    return ##class(SC.Core.API.Data.DemandPlanApiImpl).GetDemandPlans()
}

/// Returns details about a particular demand plan<br/>
/// The method arguments hold values for:<br/>
///     planId, Unique ID of the demand plan<br/>
ClassMethod GetDemandPlanById(planId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.DemandPlanApiImpl).GetDemandPlanById(planId)
}

/// Add a new demand plan<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateDemandPlan(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.DemandPlanApiImpl).CreateDemandPlan(body)
}

/// Delete an existing demand plan<br/>
/// The method arguments hold values for:<br/>
///     planId, Unique ID of the demand plan<br/>
ClassMethod DeleteDemandPlan(planId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.DemandPlanApiImpl).DeleteDemandPlan(planId)
}

/// Update one demand plan<br/>
/// The method arguments hold values for:<br/>
///     planId, Unique ID of the demand plan<br/>
///     body, New demand plan info<br/>
ClassMethod UpdateDemandPlan(planId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.DemandPlanApiImpl).UpdateDemandPlan(planId, body)
}

/// Get all exceptions in the server, truncate after certain number
ClassMethod GetExceptions() As %DynamicObject
{
    return ##class(SC.Core.API.Data.SCExceptionApiImpl).GetExceptions()
}

/// Returns details about a particular exception<br/>
/// The method arguments hold values for:<br/>
///     exceptionId, Unique ID of the exception<br/>
ClassMethod GetExceptionById(exceptionId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SCExceptionApiImpl).GetExceptionById(exceptionId)
}

/// Add a new exception<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateException(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SCExceptionApiImpl).CreateException(body)
}

/// Delete an existing exception<br/>
/// The method arguments hold values for:<br/>
///     exceptionId, Unique ID of the exception<br/>
ClassMethod DeleteException(exceptionId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SCExceptionApiImpl).DeleteException(exceptionId)
}

/// Update one exception<br/>
/// The method arguments hold values for:<br/>
///     exceptionId, Unique ID of the exception<br/>
///     body, New exception info<br/>
ClassMethod UpdateException(exceptionId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SCExceptionApiImpl).UpdateException(exceptionId, body)
}

/// Get all inventory thresholds in the server, truncate after certain number
ClassMethod GetInventoryThresholds() As %DynamicObject
{
    return ##class(SC.Core.API.Data.InventoryThresholdApiImpl).GetInventoryThresholds()
}

/// Returns details about a particular inventory threshold<br/>
/// The method arguments hold values for:<br/>
///     inventoryThresholdId, Unique ID of the inventory threshold<br/>
ClassMethod GetInventoryThresholdById(inventoryThresholdId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.InventoryThresholdApiImpl).GetInventoryThresholdById(inventoryThresholdId)
}

/// Add a new inventory threshold<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateInventoryThreshold(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.InventoryThresholdApiImpl).CreateInventoryThreshold(body)
}

/// Delete an existing inventory threshold<br/>
/// The method arguments hold values for:<br/>
///     inventoryThresholdId, Unique ID of the inventory threshold<br/>
ClassMethod DeleteInventoryThreshold(inventoryThresholdId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.InventoryThresholdApiImpl).DeleteInventoryThreshold(inventoryThresholdId)
}

/// Update one inventory threshold<br/>
/// The method arguments hold values for:<br/>
///     inventoryThresholdId, Unique ID of the inventory threshold<br/>
///     body, New inventory threshold info<br/>
ClassMethod UpdateInventoryThreshold(inventoryThresholdId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.InventoryThresholdApiImpl).UpdateInventoryThreshold(inventoryThresholdId, body)
}

/// Get all mfg orders in the server, truncate after certain number
ClassMethod GetMfgOrders() As %DynamicObject
{
    return ##class(SC.Core.API.Data.MfgOrderApiImpl).GetMfgOrders()
}

/// Returns details about a particular mfg order<br/>
/// The method arguments hold values for:<br/>
///     orderId, Unique ID of the mfg order<br/>
ClassMethod GetMfgOrderById(orderId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.MfgOrderApiImpl).GetMfgOrderById(orderId)
}

/// Add a new mfg order<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateMfgOrder(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.MfgOrderApiImpl).CreateMfgOrder(body)
}

/// Delete an existing mfg order<br/>
/// The method arguments hold values for:<br/>
///     orderId, Unique ID of the mfg order<br/>
ClassMethod DeleteMfgOrder(orderId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.MfgOrderApiImpl).DeleteMfgOrder(orderId)
}

/// Update one mfg order<br/>
/// The method arguments hold values for:<br/>
///     orderId, Unique ID of the mfg order<br/>
///     body, New mfg order info<br/>
ClassMethod UpdateMfgOrder(orderId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.MfgOrderApiImpl).UpdateMfgOrder(orderId, body)
}

/// Get all leadtime variants in the server, truncate after certain number
ClassMethod GetLeadtimeVariants() As %DynamicObject
{
    return ##class(SC.Core.API.Data.LeadtimeVariantApiImpl).GetLeadtimeVariants()
}

/// Returns details about a particular leadtime variant<br/>
/// The method arguments hold values for:<br/>
///     leadtimeVariantId, Unique ID of the leadtime variant<br/>
ClassMethod GetLeadtimeVariantById(leadtimeVariantId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.LeadtimeVariantApiImpl).GetLeadtimeVariantById(leadtimeVariantId)
}

/// Add a new leadtime variant<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateLeadtimeVariant(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.LeadtimeVariantApiImpl).CreateLeadtimeVariant(body)
}

/// Delete an existing leadtime variant<br/>
/// The method arguments hold values for:<br/>
///     leadtimeVariantId, Unique ID of the leadtime variant<br/>
ClassMethod DeleteLeadtimeVariant(leadtimeVariantId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.LeadtimeVariantApiImpl).DeleteLeadtimeVariant(leadtimeVariantId)
}

/// Update one leadtime variant<br/>
/// The method arguments hold values for:<br/>
///     leadtimeVariantId, Unique ID of the leadtime variant<br/>
///     body, New leadtime variant info<br/>
ClassMethod UpdateLeadtimeVariant(leadtimeVariantId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.LeadtimeVariantApiImpl).UpdateLeadtimeVariant(leadtimeVariantId, body)
}

/// Get all milestones in the server, truncate after certain number
ClassMethod GetMilestones() As %DynamicObject
{
    return ##class(SC.Core.API.Data.MilestonApiImpl).GetMilestones()
}

/// Returns details about a particular milestone<br/>
/// The method arguments hold values for:<br/>
///     milestoneId, Unique ID of the milestone<br/>
ClassMethod GetMilestoneById(milestoneId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.MilestonApiImpl).GetMilestoneById(milestoneId)
}

/// Add a new milestone<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateMilestone(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.MilestonApiImpl).CreateMilestone(body)
}

/// Delete an existing milestone<br/>
/// The method arguments hold values for:<br/>
///     milestoneId, Unique ID of the milestone<br/>
ClassMethod DeleteMilestone(milestoneId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.MilestonApiImpl).DeleteMilestone(milestoneId)
}

/// Update one milestone<br/>
/// The method arguments hold values for:<br/>
///     milestoneId, Unique ID of the milestone<br/>
///     body, New milestone info<br/>
ClassMethod UpdateMilestone(milestoneId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.MilestonApiImpl).UpdateMilestone(milestoneId, body)
}

/// Get all product suppliers in the server, truncate after certain number
ClassMethod GetProductSuppliers() As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductSupplierApiImpl).GetProductSuppliers()
}

/// Returns details about a particular product supplier<br/>
/// The method arguments hold values for:<br/>
///     prodSuplId, Unique ID of the product supplier<br/>
ClassMethod GetProductSupplierById(prodSuplId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductSupplierApiImpl).GetProductSupplierById(prodSuplId)
}

/// Add a new product supplier<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateProductSupplier(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductSupplierApiImpl).CreateProductSupplier(body)
}

/// Delete an existing product supplier<br/>
/// The method arguments hold values for:<br/>
///     prodSuplId, Unique ID of the product supplier<br/>
ClassMethod DeleteProductSupplier(prodSuplId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductSupplierApiImpl).DeleteProductSupplier(prodSuplId)
}

/// Update one product supplier<br/>
/// The method arguments hold values for:<br/>
///     prodSuplId, Unique ID of the product supplier<br/>
///     body, New product supplier info<br/>
ClassMethod UpdateProductSupplier(prodSuplId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductSupplierApiImpl).UpdateProductSupplier(prodSuplId, body)
}

/// Get all SLAs in the server, truncate after certain number
ClassMethod GetSLAs() As %DynamicObject
{
    return ##class(SC.Core.API.Data.SlaApiImpl).GetSLAs()
}

/// Returns details about a particular SLA<br/>
/// The method arguments hold values for:<br/>
///     slaId, Unique ID of the SLA<br/>
ClassMethod GetSLAById(slaId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SlaApiImpl).GetSLAById(slaId)
}

/// Add a new SLA<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSLA(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SlaApiImpl).CreateSLA(body)
}

/// Delete an existing SLA<br/>
/// The method arguments hold values for:<br/>
///     slaId, Unique ID of the SLA<br/>
ClassMethod DeleteSLA(slaId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SlaApiImpl).DeleteSLA(slaId)
}

/// Update one SLA<br/>
/// The method arguments hold values for:<br/>
///     slaId, Unique ID of the SLA<br/>
///     body, New SLA info<br/>
ClassMethod UpdateSLA(slaId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SlaApiImpl).UpdateSLA(slaId, body)
}

/// Get all supply plans in the server, truncate after certain number
ClassMethod GetSupplyPlans() As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyPlanApiImpl).GetSupplyPlans()
}

/// Returns details about a particular supply plan<br/>
/// The method arguments hold values for:<br/>
///     planId, Unique ID of the supply plan<br/>
ClassMethod GetSupplyPlanById(planId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyPlanApiImpl).GetSupplyPlanById(planId)
}

/// Add a new supply plan<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSupplyPlan(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyPlanApiImpl).CreateSupplyPlan(body)
}

/// Delete an existing supply plan<br/>
/// The method arguments hold values for:<br/>
///     planId, Unique ID of the supply plan<br/>
ClassMethod DeleteSupplyPlan(planId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyPlanApiImpl).DeleteSupplyPlan(planId)
}

/// Update one supply plan<br/>
/// The method arguments hold values for:<br/>
///     planId, Unique ID of the supply plan<br/>
///     body, New supply plan info<br/>
ClassMethod UpdateSupplyPlan(planId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyPlanApiImpl).UpdateSupplyPlan(planId, body)
}

/// Get all product inventories in the server, truncate after certain number
ClassMethod GetProductInventories() As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductInventoryApiImpl).GetProductInventories()
}

/// Returns details about a particular product inventory<br/>
/// The method arguments hold values for:<br/>
///     inventoryId, Unique ID of the product inventory<br/>
ClassMethod GetProductInventoryById(inventoryId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductInventoryApiImpl).GetProductInventoryById(inventoryId)
}

/// Add a new product inventory<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateProductInventory(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductInventoryApiImpl).CreateProductInventory(body)
}

/// Delete an existing product inventory<br/>
/// The method arguments hold values for:<br/>
///     inventoryId, Unique ID of the product inventory<br/>
ClassMethod DeleteProductInventory(inventoryId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductInventoryApiImpl).DeleteProductInventory(inventoryId)
}

/// Update one product inventory<br/>
/// The method arguments hold values for:<br/>
///     inventoryId, Unique ID of the product inventory<br/>
///     body, New product inventory info<br/>
ClassMethod UpdateProductInventory(inventoryId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductInventoryApiImpl).UpdateProductInventory(inventoryId, body)
}

/// Get all sales orders, truncate after certain number<br/>
/// The method arguments hold values for:<br/>
///     pageSize, Page size for pagination<br/>
///     pageIndex, index of the page, starting from 0<br/>
ClassMethod GetSalesOrders(pageSize As %Integer, pageIndex As %Integer) As %DynamicObject
{
    //return { "Status": "Pass"}
    return ##class(SC.Core.API.Data.SalesOrderApiImpl).GetSalesOrders()
}

/// Returns details about a particular sales order<br/>
/// The method arguments hold values for:<br/>
///     orderId, ID of the order<br/>
ClassMethod GetSalesOrderById(orderId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderApiImpl).GetSalesOrderById(orderId)
}

/// Create an sales order<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSalesOrder(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderApiImpl).CreateSalesOrder(body)
}

/// Delete existing sales order<br/>
/// The method arguments hold values for:<br/>
///     orderId, ID of the sales order<br/>
ClassMethod DeleteSalesOrder(orderId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderApiImpl).DeleteSalesOrder(orderId)
}

/// Update one sales order<br/>
/// The method arguments hold values for:<br/>
///     orderId, ID of the sales order<br/>
///     body, New sales order info<br/>
ClassMethod UpdateSalesOrder(orderId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderApiImpl).UpdateSalesOrder(orderId, body)
}

/// Get all sales order lines, truncate after certain number<br/>
/// The method arguments hold values for:<br/>
///     pageSize, Page size for pagination<br/>
///     pageIndex, index of the page, starting from 0<br/>
ClassMethod GetSalesOrderLines(pageSize As %Integer, pageIndex As %Integer) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderLineApiImpl).GetSalesOrderLines()
}

/// Returns details about a particular sales order line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the order line<br/>
ClassMethod GetSalesOrderLineById(lineId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderLineApiImpl).GetSalesOrderLineById(lineId)
}

/// Create an sales order line<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSalesOrderLine(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderLineApiImpl).CreateSalesOrderLine(body)
}

/// Delete existing sales order line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the sales order line<br/>
ClassMethod DeleteSalesOrderLine(lineId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderLineApiImpl).DeleteSalesOrderLine(lineId)
}

/// Update one sales order line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the sales order line<br/>
///     body, New sales order line info<br/>
ClassMethod UpdateSalesOrderLine(lineId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesOrderLineApiImpl).UpdateSalesOrderLine(lineId, body)
}

/// Get all purchase orders, truncate after certain number<br/>
/// The method arguments hold values for:<br/>
///     pageSize, Page size for pagination<br/>
///     pageIndex, index of the page, starting from 0<br/>
ClassMethod GetPurchaseOrders(pageSize As %Integer, pageIndex As %Integer) As %DynamicObject
{
    //return { "Status": "Pass"}
    return ##class(SC.Core.API.Data.PurchaseOrderApiImpl).GetPurchaseOrders()
}

/// Returns details about a particular purchase order<br/>
/// The method arguments hold values for:<br/>
///     orderId, ID of the order<br/>
ClassMethod GetPurchaseOrderById(orderId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderApiImpl).GetPurchaseOrderById(orderId)
}

/// Create an purchase order<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreatePurchaseOrder(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderApiImpl).CreatePurchaseOrder(body)
}

/// Delete existing purchase order<br/>
/// The method arguments hold values for:<br/>
///     orderId, ID of the purchase order<br/>
ClassMethod DeletePurchaseOrder(orderId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderApiImpl).DeletePurchaseOrder(orderId)
}

/// Update one purchase order<br/>
/// The method arguments hold values for:<br/>
///     orderId, ID of the purchase order<br/>
///     body, New purchase order info<br/>
ClassMethod UpdatePurchaseOrder(orderId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderApiImpl).UpdatePurchaseOrder(orderId, body)
}

/// Get all purchase order lines, truncate after certain number<br/>
/// The method arguments hold values for:<br/>
///     pageSize, Page size for pagination<br/>
///     pageIndex, index of the page, starting from 0<br/>
ClassMethod GetPurchaseOrderLines(pageSize As %Integer, pageIndex As %Integer) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderLineApiImpl).GetPurchaseOrderLines()
}

/// Returns details about a particular purchase order line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the order line<br/>
ClassMethod GetPurchaseOrderLineById(lineId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderLineApiImpl).GetPurchaseOrderLineById(lineId)
}

/// Create an purchase order line<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreatePurchaseOrderLine(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderLineApiImpl).CreatePurchaseOrderLine(body)
}

/// Delete existing purchase order line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the purchase order line<br/>
ClassMethod DeletePurchaseOrderLine(lineId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderLineApiImpl).DeletePurchaseOrderLine(lineId)
}

/// Update one purchase order line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the purchase order line<br/>
///     body, New purchase order line info<br/>
ClassMethod UpdatePurchaseOrderLine(lineId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.PurchaseOrderLineApiImpl).UpdatePurchaseOrderLine(lineId, body)
}

/// Get all sales shipments, truncate after certain number<br/>
/// The method arguments hold values for:<br/>
///     pageSize, Page size for pagination<br/>
///     pageIndex, index of the page, starting from 0<br/>
ClassMethod GetSalesShipments(pageSize As %Integer, pageIndex As %Integer) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentApiImpl).GetSalesShipments()
}

/// Returns details about a particular sales shipment<br/>
/// The method arguments hold values for:<br/>
///     shipmentId, ID of the sales shipment<br/>
ClassMethod GetSalesShipmentById(shipmentId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentApiImpl).GetSalesShipmentById(shipmentId)
}

/// Create an sales shipment<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSalesShipment(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentApiImpl).CreateSalesShipment(body)
}

/// Delete existing sales shipment<br/>
/// The method arguments hold values for:<br/>
///     shipmentId, ID of the sales shipment<br/>
ClassMethod DeleteSalesShipment(shipmentId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentApiImpl).DeleteSalesShipment(shipmentId)
}

/// Update one sales shipment<br/>
/// The method arguments hold values for:<br/>
///     shipmentId, ID of the sales shipment<br/>
///     body, New sales shipment info<br/>
ClassMethod UpdateSalesShipment(shipmentId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentApiImpl).UpdateSalesShipment(shipmentId, body)
}

/// Get all sales shipment lines, truncate after certain number<br/>
/// The method arguments hold values for:<br/>
///     pageSize, Page size for pagination<br/>
///     pageIndex, index of the page, starting from 0<br/>
ClassMethod GetSalesShipmentLines(pageSize As %Integer, pageIndex As %Integer) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentLineApiImpl).GetSalesShipmentLines()
}

/// Returns details about a particular sales shipment line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the shipment line<br/>
ClassMethod GetSalesShipmentLineById(lineId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentLineApiImpl).GetSalesShipmentLineById(lineId)
}

/// Create an sales shipment line<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSalesShipmentLine(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentLineApiImpl).CreateSalesShipmentLine(body)
}

/// Delete existing sales shipment line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the sales shipment line<br/>
ClassMethod DeleteSalesShipmentLine(lineId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentLineApiImpl).DeleteSalesShipmentLine(lineId)
}

/// Update one sales shipment line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the sales shipment line<br/>
///     body, New sales shipment line info<br/>
ClassMethod UpdateSalesShipmentLine(lineId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SalesShipmentLineApiImpl).UpdateSalesShipmentLine(lineId, body)
}

/// Get all supply shipments, truncate after certain number<br/>
/// The method arguments hold values for:<br/>
///     pageSize, Page size for pagination<br/>
///     pageIndex, index of the page, starting from 0<br/>
ClassMethod GetSupplyShipments(pageSize As %Integer, pageIndex As %Integer) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentApiImpl).GetSupplyShipments()
}

/// Returns details about a particular supply shipment<br/>
/// The method arguments hold values for:<br/>
///     shipmentId, ID of the supply shipment<br/>
ClassMethod GetSupplyShipmentById(shipmentId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentApiImpl).GetSupplyShipmentById(shipmentId)
}

/// Create an supply shipment<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSupplyShipment(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentApiImpl).CreateSupplyShipment(body)
}

/// Delete existing supply shipment<br/>
/// The method arguments hold values for:<br/>
///     shipmentId, ID of the supply shipment<br/>
ClassMethod DeleteSupplyShipment(shipmentId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentApiImpl).DeleteSupplyShipment(shipmentId)
}

/// Update one supply shipment<br/>
/// The method arguments hold values for:<br/>
///     shipmentId, ID of the supply shipment<br/>
///     body, New supply shipment info<br/>
ClassMethod UpdateSupplyShipment(shipmentId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentApiImpl).UpdateSupplyShipment(shipmentId, body)
}

/// Get all supply shipment lines, truncate after certain number<br/>
/// The method arguments hold values for:<br/>
///     pageSize, Page size for pagination<br/>
///     pageIndex, index of the page, starting from 0<br/>
ClassMethod GetSupplyShipmentLines(pageSize As %Integer, pageIndex As %Integer) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentLineApiImpl).GetSupplyShipmentLines()
}

/// Returns details about a particular supply shipment line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the shipment line<br/>
ClassMethod GetSupplyShipmentLineById(lineId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentLineApiImpl).GetSupplyShipmentLineById(lineId)
}

/// Create an supply shipment line<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateSupplyShipmentLine(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentLineApiImpl).CreateSupplyShipmentLine(body)
}

/// Delete existing supply shipment line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the supply shipment line<br/>
ClassMethod DeleteSupplyShipmentLine(lineId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentLineApiImpl).DeleteSupplyShipmentLine(lineId)
}

/// Update one supply shipment line<br/>
/// The method arguments hold values for:<br/>
///     lineId, ID of the supply shipment line<br/>
///     body, New supply shipment line info<br/>
ClassMethod UpdateSupplyShipmentLine(lineId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.SupplyShipmentLineApiImpl).UpdateSupplyShipmentLine(lineId, body)
}

/// Get all production capacity in the server, truncate after certain number
ClassMethod GetProductionCapacities() As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductionCapacityApiImpl).GetProductionCapacities()
}

/// Returns details about a particular production capacity<br/>
/// The method arguments hold values for:<br/>
///     productionCapacityId, Unique ID of the production capacity<br/>
ClassMethod GetProductionCapacityById(productionCapacityId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductionCapacityApiImpl).GetProductionCapacityById(productionCapacityId)
}

/// Add a new production capacity<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateProductionCapacity(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductionCapacityApiImpl).CreateProductionCapacity(body)
}

/// Delete an existing production capacity<br/>
/// The method arguments hold values for:<br/>
///     productionCapacityId, Unique ID of the production capacity<br/>
ClassMethod DeleteProductionCapacity(productionCapacityId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductionCapacityApiImpl).DeleteProductionCapacity(productionCapacityId)
}

/// Update one production capacity<br/>
/// The method arguments hold values for:<br/>
///     productionCapacityId, Unique ID of the production capacity<br/>
///     body, New production capacity info<br/>
ClassMethod UpdateProductionCapacity(productionCapacityId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ProductionCapacityApiImpl).UpdateProductionCapacity(productionCapacityId, body)
}

/// Get all shipping cost in the server, truncate after certain number
ClassMethod GetShippingCosts() As %DynamicObject
{
    return ##class(SC.Core.API.Data.ShippingCostApiImpl).GetShippingCosts()
}

/// Returns details about a particular shipping cost<br/>
/// The method arguments hold values for:<br/>
///     shippingCostId, Unique ID of the shipping cost<br/>
ClassMethod GetShippingCostById(shippingCostId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ShippingCostApiImpl).GetShippingCostById(shippingCostId)
}

/// Add a new shipping cost<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateShippingCost(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ShippingCostApiImpl).CreateShippingCost(body)
}

/// Delete an existing shipping cost<br/>
/// The method arguments hold values for:<br/>
///     shippingCostId, Unique ID of the shipping cost<br/>
ClassMethod DeleteShippingCost(shippingCostId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ShippingCostApiImpl).DeleteShippingCost(shippingCostId)
}

/// Update one shipping cost<br/>
/// The method arguments hold values for:<br/>
///     shippingCostId, Unique ID of the shipping cost<br/>
///     body, New shipping cost info<br/>
ClassMethod UpdateShippingCost(shippingCostId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.ShippingCostApiImpl).UpdateShippingCost(shippingCostId, body)
}

/// Get all issues in the system
ClassMethod GetIssues() As %DynamicObject
{
    //return {"Status": "ok"}
    return ##class(SC.Core.API.Data.IssueApiImpl).GetIssues()
}

/// Returns a specific issue by ID<br/>
/// The method arguments hold values for:<br/>
///     issueId, issue uid<br/>
ClassMethod GetIssueById(issueId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.IssueApiImpl).GetIssueById(issueId)
}

/// Create a new issue<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateIssue(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.IssueApiImpl).CreateIssue(body)
}

/// Delete existing Customer<br/>
/// The method arguments hold values for:<br/>
///     issueId, ID of the issue<br/>
ClassMethod DeleteIssue(issueId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.IssueApiImpl).DeleteIssue(issueId)
}

/// Update one issuer<br/>
/// The method arguments hold values for:<br/>
///     issueId, ID of the issue<br/>
///     body, New issue info<br/>
ClassMethod UpdateIssue(issueId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.IssueApiImpl).UpdateIssue(issueId, body)
}

/// Get all route legs in the system
ClassMethod GetRouteLegs() As %DynamicObject
{
    return ##class(SC.Core.API.Data.RouteLegApiImpl).GetRouteLegs()
}

/// Returns a specific route leg by ID<br/>
/// The method arguments hold values for:<br/>
///     routeLegId, Route leg uid<br/>
ClassMethod GetRouteLegById(routeLegId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.RouteLegApiImpl).GetRouteLegById(routeLegId)
}

/// Create a route leg<br/>
/// The method arguments hold values for:<br/>
///     body<br/>
ClassMethod CreateRouteLeg(body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.RouteLegApiImpl).CreateRouteLeg(body)
}

/// Delete existing route leg<br/>
/// The method arguments hold values for:<br/>
///     routeLegId, ID of the route leg<br/>
ClassMethod DeleteRouteLeg(routeLegId As %String) As %DynamicObject
{
    return ##class(SC.Core.API.Data.RouteLegApiImpl).DeleteRouteLeg(routeLegId)
}

/// Update one route leg<br/>
/// The method arguments hold values for:<br/>
///     routeLegId, Route leg uid<br/>
///     body, New route leg info<br/>
ClassMethod UpdateRouteLeg(routeLegId As %String, body As %DynamicObject) As %DynamicObject
{
    return ##class(SC.Core.API.Data.RouteLegApiImpl).UpdateRouteLeg(routeLegId, body)
}

}
