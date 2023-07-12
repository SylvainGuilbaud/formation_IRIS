Class datamodelAPI.spec Extends %REST.Spec [ ProcedureBlock ]
{

XData OpenAPI [ MimeType = application/json ]
{
{
    "swagger": "2.0",
    "info": {
        "version": "1.0",
        "title": "IRIS Supply Chain Data Model API",
        "description": "API for InterSystems IRIS supply chain data model",
        "contact": {
            "name": "Ming Zhou"
        }
    },
    "basePath": "/api/scdata/v1",
    "schemes": [
        "http"
    ],
    "consumes": [
        "application/json"
    ],
    "produces": [
        "application/json"
    ],
    "paths": {
        "/backend-version": {
            "get": {
                "description": "Returns the version of the backend.",
                "operationId": "GetBackendVersion",
                "produces": [
                    "text/plain"
                ],
                "responses": {
                    "200": {
                        "description": "The version of the backend",
                        "schema": {
                            "type": "string"
                        }
                    }
                }
            }
        },
        "/objects/{objectName}": {
            "get": {
                "description": "Returns the definition of the specified data objects",
                "operationId": "GetObjectDefinitionByName",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "objectName",
                        "type": "string",
                        "required": true,
                        "description": "object name"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Object definition",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ObjectDefinition"
                            }
                        }
                    }
                }
            }
        },
        "/objects": {
            "get": {
                "description": "Get the list of all objects defined in the system",
                "operationId": "GetObjects",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/attributes/{objectName}": {
            "post": {
                "description": "Add a custom attribute to an object",
                "operationId": "AddAttribute",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "objectName",
                        "type": "string",
                        "required": true,
                        "description": "Object name"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PropertyDefinition"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/customers/{customerId}": {
            "get": {
                "description": "Returns details about a particular customer",
                "operationId": "GetCustomerById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "customerId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the customer"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Customer"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one customer customer",
                "operationId": "UpdateCustomer",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "customerId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the customer"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New customer info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Customer"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Customer"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Customer not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing Customer",
                "operationId": "DeleteCustomer",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "customerId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the customer"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Customer not found"
                    }
                }
            }
        },
        "/customers": {
            "get": {
                "description": "Get all customers in the server, truncate after certain number\n",
                "operationId": "GetCustomers",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new customer",
                "operationId": "CreateCustomer",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Customer"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/locations/{locationId}": {
            "get": {
                "description": "Returns details about a particular location",
                "operationId": "GetLocationById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "locationId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the Location"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a Location by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Location"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one location",
                "operationId": "UpdateLocation",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "locationId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the location"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New location info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Location"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a customer by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Location"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Location not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing location",
                "operationId": "DeleteLocation",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "locationId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the location"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Location not found"
                    }
                }
            }
        },
        "/locations": {
            "get": {
                "description": "Get all locations",
                "operationId": "GetLocations",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create a new location",
                "operationId": "CreateLocation",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Location"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/salesorders/{orderId}": {
            "get": {
                "description": "Returns details about a particular sales order",
                "operationId": "GetSalesOrderById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrder"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one sales order",
                "operationId": "UpdateSalesOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrder"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Sales order not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing sales order",
                "operationId": "DeleteSalesOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Sales order not found"
                    }
                }
            }
        },
        "/salesorders": {
            "get": {
                "description": "Get all sales orders, truncate after certain number\n",
                "operationId": "GetSalesOrders",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrder"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an sales order",
                "operationId": "CreateSalesOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/salesorderlines/{lineId}": {
            "get": {
                "description": "Returns details about a particular sales order line",
                "operationId": "GetSalesOrderLineById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the order line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order line by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrderLine"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one sales order line",
                "operationId": "UpdateSalesOrderLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales order line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrderLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Sales order lie not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing sales order line",
                "operationId": "DeleteSalesOrderLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales order line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Sales order line not found"
                    }
                }
            }
        },
        "/salesorderlines": {
            "get": {
                "description": "Get all sales order lines, truncate after certain number\n",
                "operationId": "GetSalesOrderLines",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesOrderLine"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an sales order line",
                "operationId": "CreateSalesOrderLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/products/{productId}": {
            "get": {
                "description": "Returns details about a particular product",
                "operationId": "GetProductById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product by ID",
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    },
                    "404": {
                        "description": "product not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one product",
                "operationId": "UpdateProduct",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product",
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "product not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing product",
                "operationId": "DeleteProduct",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Product not found"
                    }
                }
            }
        },
        "/products": {
            "get": {
                "description": "Get all products in the server, truncate after certain number\n",
                "operationId": "GetProducts",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Product"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new product",
                "operationId": "CreateProduct",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created product",
                        "schema": {
                            "$ref": "#/definitions/Product"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/carriers/{carrierId}": {
            "get": {
                "description": "Returns details about a particular carrier",
                "operationId": "GetCarrierById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "carrierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the carrier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a carrier by ID",
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    },
                    "404": {
                        "description": "Carrier not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one carrier",
                "operationId": "UpdateCarrier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "carrierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the carrier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New carrier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a carrier",
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Carrier not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing carrier",
                "operationId": "DeleteCarrier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "carrierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the carrier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Carrier not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/carriers": {
            "get": {
                "description": "Get all carriers in the server, truncate after certain number\n",
                "operationId": "GetCarriers",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Carrier"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new carrier",
                "operationId": "CreateCarrier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created product",
                        "schema": {
                            "$ref": "#/definitions/Carrier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/suppliers/{supplierId}": {
            "get": {
                "description": "Returns details about a particular supplier",
                "operationId": "GetSupplierById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "supplierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supplier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supplier by ID",
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    },
                    "404": {
                        "description": "Supplier not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one supplier",
                "operationId": "UpdateSupplier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "supplierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supplier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supplier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supplier",
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Supplier not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing supplier",
                "operationId": "DeleteSupplier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "supplierId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supplier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Supplier not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/suppliers": {
            "get": {
                "description": "Get all suppliers in the server, truncate after certain number\n",
                "operationId": "GetSuppliers",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Supplier"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new supplier",
                "operationId": "CreateSupplier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created supplier",
                        "schema": {
                            "$ref": "#/definitions/Supplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/billofmaterials/{bomId}": {
            "get": {
                "description": "Returns details about a particular bill of material",
                "operationId": "GetBOMById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "bomId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the BOM"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a BOM by ID",
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    },
                    "404": {
                        "description": "BOM not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one BOM",
                "operationId": "UpdateBOM",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "bomId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the BOM"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New BOM info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a BOM",
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "BOM not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing BOM",
                "operationId": "DeleteBOM",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "bomId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the BOM"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "BOM not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/billofmaterials": {
            "get": {
                "description": "Get all BOMs in the server, truncate after certain number\n",
                "operationId": "GetBOMs",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/BOM"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new BOM",
                "operationId": "CreateBOM",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created supplier",
                        "schema": {
                            "$ref": "#/definitions/BOM"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/demandplans/{planId}": {
            "get": {
                "description": "Returns details about a particular demand plan",
                "operationId": "GetDemandPlanById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the demand plan"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a demand plann by ID",
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    },
                    "404": {
                        "description": "Demand plan not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one demand plan",
                "operationId": "UpdateDemandPlan",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the demand plan"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New demand plan info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a demand plan",
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing demand plan",
                "operationId": "DeleteDemandPlan",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the demand plan"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/demandplans": {
            "get": {
                "description": "Get all demand plans in the server, truncate after certain number\n",
                "operationId": "GetDemandPlans",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/DemandPlan"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new demand plan",
                "operationId": "CreateDemandPlan",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/DemandPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/scexceptions/{exceptionId}": {
            "get": {
                "description": "Returns details about a particular exception",
                "operationId": "GetExceptionById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "exceptionId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the exception"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a exception by ID",
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one exception",
                "operationId": "UpdateException",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "exceptionId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the exception"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New exception info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a exception",
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing exception",
                "operationId": "DeleteException",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "exceptionId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the exception"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/scexceptions": {
            "get": {
                "description": "Get all exceptions in the server, truncate after certain number\n",
                "operationId": "GetExceptions",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Exception"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new exception",
                "operationId": "CreateException",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/Exception"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/inventorythresholds/{inventoryThresholdId}": {
            "get": {
                "description": "Returns details about a particular inventory threshold",
                "operationId": "GetInventoryThresholdById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryThresholdId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the inventory threshold"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a inventory threshold by ID",
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one inventory threshold",
                "operationId": "UpdateInventoryThreshold",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryThresholdId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the inventory threshold"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New inventory threshold info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a inventory threshold",
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing inventory threshold",
                "operationId": "DeleteInventoryThreshold",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryThresholdId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the inventory threshold"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/inventorythresholds": {
            "get": {
                "description": "Get all inventory thresholds in the server, truncate after certain number\n",
                "operationId": "GetInventoryThresholds",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/InventoryThreshold"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new inventory threshold",
                "operationId": "CreateInventoryThreshold",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/InventoryThreshold"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/manufacturingorders/{orderId}": {
            "get": {
                "description": "Returns details about a particular mfg order",
                "operationId": "GetMfgOrderById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the mfg order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a mfg order by ID",
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one mfg order",
                "operationId": "UpdateMfgOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the mfg order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New mfg order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a mfg order",
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing mfg order",
                "operationId": "DeleteMfgOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the mfg order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/manufacturingorders": {
            "get": {
                "description": "Get all mfg orders in the server, truncate after certain number\n",
                "operationId": "GetMfgOrders",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/MfgOrder"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new mfg order",
                "operationId": "CreateMfgOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/MfgOrder"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/leadtimevariants/{leadtimeVariantId}": {
            "get": {
                "description": "Returns details about a particular leadtime variant",
                "operationId": "GetLeadtimeVariantById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "leadtimeVariantId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the leadtime variant"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a leadtime variant by ID",
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one leadtime variant",
                "operationId": "UpdateLeadtimeVariant",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "leadtimeVariantId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the leadtime variant"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New leadtime variant info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a leadtime variant",
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing leadtime variant",
                "operationId": "DeleteLeadtimeVariant",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "leadtimeVariantId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the leadtime variant"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/leadtimevariants": {
            "get": {
                "description": "Get all leadtime variants in the server, truncate after certain number\n",
                "operationId": "GetLeadtimeVariants",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/LeadtimeVariant"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new leadtime variant",
                "operationId": "CreateLeadtimeVariant",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/LeadtimeVariant"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/milestones/{milestoneId}": {
            "get": {
                "description": "Returns details about a particular milestone",
                "operationId": "GetMilestoneById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "milestoneId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the milestone"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a milestone by ID",
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one milestone",
                "operationId": "UpdateMilestone",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "milestoneId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the milestone"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New milestone info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a milestone",
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing milestone",
                "operationId": "DeleteMilestone",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "milestoneId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the milestone"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/milestones": {
            "get": {
                "description": "Get all milestones in the server, truncate after certain number\n",
                "operationId": "GetMilestones",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/Milestone"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new milestone",
                "operationId": "CreateMilestone",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/Milestone"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productsuppliers/{prodSuplId}": {
            "get": {
                "description": "Returns details about a particular product supplier",
                "operationId": "GetProductSupplierById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "prodSuplId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product supplier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product supplier by ID",
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one product supplier",
                "operationId": "UpdateProductSupplier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "prodSuplId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product supplier"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product supplier info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product supplier",
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing product supplier",
                "operationId": "DeleteProductSupplier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "prodSuplId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product supplier"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productsuppliers": {
            "get": {
                "description": "Get all product suppliers in the server, truncate after certain number\n",
                "operationId": "GetProductSuppliers",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ProductSupplier"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new product supplier",
                "operationId": "CreateProductSupplier",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/ProductSupplier"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/slas/{slaId}": {
            "get": {
                "description": "Returns details about a particular SLA",
                "operationId": "GetSLAById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "slaId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the SLA"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a SLA by ID",
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one SLA",
                "operationId": "UpdateSLA",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "slaId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the SLA"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New SLA info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a SLA",
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing SLA",
                "operationId": "DeleteSLA",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "slaId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the SLA"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/slas": {
            "get": {
                "description": "Get all SLAs in the server, truncate after certain number\n",
                "operationId": "GetSLAs",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SLA"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new SLA",
                "operationId": "CreateSLA",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/SLA"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/supplyplans/{planId}": {
            "get": {
                "description": "Returns details about a particular supply plan",
                "operationId": "GetSupplyPlanById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supply plan"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply plann by ID",
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    },
                    "404": {
                        "description": "Demand plan not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one supply plan",
                "operationId": "UpdateSupplyPlan",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supply plan"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply plan info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply plan",
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing supply plan",
                "operationId": "DeleteSupplyPlan",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "planId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the supply plan"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/supplyplans": {
            "get": {
                "description": "Get all supply plans in the server, truncate after certain number\n",
                "operationId": "GetSupplyPlans",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyPlan"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new supply plan",
                "operationId": "CreateSupplyPlan",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created object",
                        "schema": {
                            "$ref": "#/definitions/SupplyPlan"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productinventories/{inventoryId}": {
            "get": {
                "description": "Returns details about a particular product inventory",
                "operationId": "GetProductInventoryById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product inventory"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product inventory by ID",
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    },
                    "404": {
                        "description": "product inventory not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one product inventory",
                "operationId": "UpdateProductInventory",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product inventory"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New product inventory info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a product inventory",
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "product inventory not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing product inventory",
                "operationId": "DeleteProductInventory",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "inventoryId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the product inventory"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "product inventory not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productinventories": {
            "get": {
                "description": "Get all product inventories in the server, truncate after certain number\n",
                "operationId": "GetProductInventories",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ProductInventory"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new product inventory",
                "operationId": "CreateProductInventory",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the created product inventory",
                        "schema": {
                            "$ref": "#/definitions/ProductInventory"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/purchaseorders/{orderId}": {
            "get": {
                "description": "Returns details about a particular purchase order",
                "operationId": "GetPurchaseOrderById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrder"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one purchase order",
                "operationId": "UpdatePurchaseOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New purchase order info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrder"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "purchase order not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing purchase order",
                "operationId": "DeletePurchaseOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "orderId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "purchase order not found"
                    }
                }
            }
        },
        "/purchaseorders": {
            "get": {
                "description": "Get all purchase orders, truncate after certain number\n",
                "operationId": "GetPurchaseOrders",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrder"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an purchase order",
                "operationId": "CreatePurchaseOrder",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrder"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/purchaseorderlines/{lineId}": {
            "get": {
                "description": "Returns details about a particular purchase order line",
                "operationId": "GetPurchaseOrderLineById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the order line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order line by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrderLine"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one purchase order line",
                "operationId": "UpdatePurchaseOrderLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New purchase order line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a purchase order by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrderLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "purchase rder lie not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing purchase order line",
                "operationId": "DeletePurchaseOrderLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the purchase order line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "purchase order line not found"
                    }
                }
            }
        },
        "/purchaseorderlines": {
            "get": {
                "description": "Get all purchase order lines, truncate after certain number\n",
                "operationId": "GetPurchaseOrderLines",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/PurchaseOrderLine"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an purchase order line",
                "operationId": "CreatePurchaseOrderLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/PurchaseOrderLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/salesshipments/{shipmentId}": {
            "get": {
                "description": "Returns details about a particular sales shipment",
                "operationId": "GetSalesShipmentById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipment"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one sales shipment",
                "operationId": "UpdateSalesShipment",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales shipment info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipment"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "sales shipment not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing sales shipment",
                "operationId": "DeleteSalesShipment",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "sales shipment not found"
                    }
                }
            }
        },
        "/salesshipments": {
            "get": {
                "description": "Get all sales shipments, truncate after certain number\n",
                "operationId": "GetSalesShipments",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipment"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an sales shipment",
                "operationId": "CreateSalesShipment",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/salesshipmentlines/{lineId}": {
            "get": {
                "description": "Returns details about a particular sales shipment line",
                "operationId": "GetSalesShipmentLineById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment line by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipmentLine"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one sales shipment line",
                "operationId": "UpdateSalesShipmentLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New sales shipment line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a sales shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipmentLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "sales shipment lie not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing sales shipment line",
                "operationId": "DeleteSalesShipmentLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the sales shipment line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "sales shipment line not found"
                    }
                }
            }
        },
        "/salesshipmentlines": {
            "get": {
                "description": "Get all sales shipment lines, truncate after certain number\n",
                "operationId": "GetSalesShipmentLines",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SalesShipmentLine"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an sales shipment line",
                "operationId": "CreateSalesShipmentLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SalesShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/supplyshipments/{shipmentId}": {
            "get": {
                "description": "Returns details about a particular supply shipment",
                "operationId": "GetSupplyShipmentById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipment"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one supply shipment",
                "operationId": "UpdateSupplyShipment",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply shipment info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipment"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "supply shipment not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing supply shipment",
                "operationId": "DeleteSupplyShipment",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shipmentId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "supply shipment not found"
                    }
                }
            }
        },
        "/supplyshipments": {
            "get": {
                "description": "Get all supply shipments, truncate after certain number\n",
                "operationId": "GetSupplyShipments",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipment"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an supply shipment",
                "operationId": "CreateSupplyShipment",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipment"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/supplyshipmentlines/{lineId}": {
            "get": {
                "description": "Returns details about a particular supply shipment line",
                "operationId": "GetSupplyShipmentLineById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the shipment line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment line by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipmentLine"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one supply shipment line",
                "operationId": "UpdateSupplyShipmentLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment line"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New supply shipment line info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a supply shipment by ID",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipmentLine"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "supply shipment lie not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing supply shipment line",
                "operationId": "DeleteSupplyShipmentLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "lineId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the supply shipment line"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "supply shipment line not found"
                    }
                }
            }
        },
        "/supplyshipmentlines": {
            "get": {
                "description": "Get all supply shipment lines, truncate after certain number\n",
                "operationId": "GetSupplyShipmentLines",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "query",
                        "name": "pageSize",
                        "type": "integer",
                        "required": false,
                        "description": "Page size for pagination"
                    },
                    {
                        "in": "query",
                        "name": "pageIndex",
                        "type": "integer",
                        "required": false,
                        "description": "index of the page, starting from 0"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/SupplyShipmentLine"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create an supply shipment line",
                "operationId": "CreateSupplyShipmentLine",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/SupplyShipmentLine"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productioncapacities/{productionCapacityId}": {
            "get": {
                "description": "Returns details about a particular production capacity",
                "operationId": "GetProductionCapacityById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productionCapacityId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the production capacity"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a production capacity",
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one production capacity",
                "operationId": "UpdateProductionCapacity",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productionCapacityId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the production capacity"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New production capacity info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the new production capacity",
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing production capacity",
                "operationId": "DeleteProductionCapacity",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "productionCapacityId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the production capacity"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/productioncapacities": {
            "get": {
                "description": "Get all production capacity in the server, truncate after certain number\n",
                "operationId": "GetProductionCapacities",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ProductionCapacity"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new production capacity",
                "operationId": "CreateProductionCapacity",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created production capacity",
                        "schema": {
                            "$ref": "#/definitions/ProductionCapacity"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/shippingcosts/{shippingCostId}": {
            "get": {
                "description": "Returns details about a particular shipping cost",
                "operationId": "GetShippingCostById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shippingCostId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the shipping cost"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about a shipping cost",
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    },
                    "404": {
                        "description": "record not found"
                    },
                    "500": {
                        "description": "Server internal error"
                    }
                }
            },
            "put": {
                "description": "Update one shipping cost",
                "operationId": "UpdateShippingCost",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shippingCostId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the shipping cost"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New shipping cost info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the new shipping cost",
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete an existing shipping cost",
                "operationId": "DeleteShippingCost",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "shippingCostId",
                        "type": "string",
                        "required": true,
                        "description": "Unique ID of the shipping cost"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Record not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/shippingcosts": {
            "get": {
                "description": "Get all shipping cost in the server, truncate after certain number\n",
                "operationId": "GetShippingCosts",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/ShippingCost"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Add a new shipping cost",
                "operationId": "CreateShippingCost",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the newly created shipping cost",
                        "schema": {
                            "$ref": "#/definitions/ShippingCost"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/issues/{issueId}": {
            "get": {
                "description": "Returns a specific issue by ID",
                "operationId": "GetIssueById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "issue uid"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Issue details",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/issue"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one issuer",
                "operationId": "UpdateIssue",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the issue"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New issue info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details about an issue by ID",
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Issue not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing Customer",
                "operationId": "DeleteIssue",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the issue"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Issue not found"
                    }
                }
            }
        },
        "/issues": {
            "get": {
                "description": "Get all issues in the system",
                "operationId": "GetIssues",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/issue"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create a new issue",
                "operationId": "CreateIssue",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/issue"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        },
        "/routelegs/{routeLegId}": {
            "get": {
                "description": "Returns a specific route leg by ID",
                "operationId": "GetRouteLegById",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "routeLegId",
                        "type": "string",
                        "required": true,
                        "description": "Route leg uid"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Route leg details",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/routeLeg"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update one route leg",
                "operationId": "UpdateRouteLeg",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "routeLegId",
                        "type": "string",
                        "required": true,
                        "description": "Route leg uid"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New route leg info",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Details of the route leg",
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "Route leg not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete existing route leg",
                "operationId": "DeleteRouteLeg",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "routeLegId",
                        "type": "string",
                        "required": true,
                        "description": "ID of the route leg"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "Route leg not found"
                    }
                }
            }
        },
        "/routelegs": {
            "get": {
                "description": "Get all route legs in the system",
                "operationId": "GetRouteLegs",
                "produces": [
                    "application/json"
                ],
                "parameters": [],
                "responses": {
                    "200": {
                        "description": "Success",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/routeLeg"
                            }
                        }
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "post": {
                "description": "Create a route leg",
                "operationId": "CreateRouteLeg",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/routeLeg"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            }
        }
    },
    "definitions": {
        "PropertyDefinition": {
            "type": "object",
            "required": [
                "name",
                "type"
            ],
            "properties": {
                "name": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "required": {
                    "type": "number"
                },
                "description": {
                    "type": "string"
                }
            }
        },
        "ObjectDefinition": {
            "type": "object",
            "required": [
                "name",
                "attributes"
            ],
            "properties": {
                "name": {
                    "type": "string"
                },
                "description": {
                    "type": "string"
                },
                "attributes": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/PropertyDefinition"
                    }
                }
            }
        },
        "Customer": {
            "type": "object",
            "required": [
                "uid",
                "name"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "primaryContact": {
                    "type": "string"
                },
                "primaryPhone": {
                    "type": "string"
                },
                "url": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "shipToLocationId": {
                    "type": "string"
                },
                "primaryLocationId": {
                    "type": "string"
                }
            }
        },
        "Location": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "locationName": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "street": {
                    "type": "string"
                },
                "city": {
                    "type": "string"
                },
                "stateProvince": {
                    "type": "string"
                },
                "stateProvinceIso2": {
                    "type": "string"
                },
                "country": {
                    "type": "string"
                },
                "countryIso2": {
                    "type": "string"
                },
                "countryIso3": {
                    "type": "string"
                },
                "countryPhoneCode": {
                    "type": "string"
                },
                "postalCode": {
                    "type": "string"
                },
                "coordinates": {
                    "type": "string"
                },
                "gln": {
                    "type": "string"
                },
                "currencyIso3": {
                    "type": "string"
                },
                "region": {
                    "type": "string"
                },
                "subregion": {
                    "type": "string"
                }
            }
        },
        "SalesOrder": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "orderStatus": {
                    "type": "string"
                },
                "customerId": {
                    "type": "string"
                },
                "customerPoNumber": {
                    "type": "string"
                },
                "requestedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "requestedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "orderPlacedDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "changeOrderDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "lastModifiedDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "shipToLocationId": {
                    "type": "string"
                },
                "orderValue": {
                    "type": "number"
                },
                "orderCurrency": {
                    "type": "string"
                },
                "dataSource": {
                    "type": "string"
                },
                "sourceOrderId": {
                    "type": "string"
                },
                "salesOrganization": {
                    "type": "string"
                },
                "salesRegion": {
                    "type": "string"
                },
                "lineItems": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/SalesOrderLine"
                    }
                }
            }
        },
        "SalesOrderLine": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "lineNumber": {
                    "type": "string"
                },
                "salesOrderId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "value": {
                    "type": "number"
                },
                "requestedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "requestedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "shipToLocationId": {
                    "type": "string"
                }
            }
        },
        "Product": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "productClass": {
                    "type": "string"
                },
                "productCategory": {
                    "type": "string"
                },
                "productBrand": {
                    "type": "string"
                },
                "productFamily": {
                    "type": "string"
                },
                "productSegment": {
                    "type": "string"
                },
                "productNumber": {
                    "type": "string"
                },
                "description": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "gtin": {
                    "type": "string"
                },
                "defaultUom": {
                    "type": "string"
                },
                "shelfLife": {
                    "type": "number"
                },
                "shelfLifeUom": {
                    "type": "string"
                },
                "agingThreshold": {
                    "type": "number"
                },
                "agingThresholdUom": {
                    "type": "string"
                },
                "defaultLeadTime": {
                    "type": "number"
                },
                "leadTimeUom": {
                    "type": "string"
                },
                "defaultGoodReceiptProcessingTime": {
                    "type": "number"
                },
                "goodReceiptProcessingTimeUom": {
                    "type": "string"
                },
                "costControl": {
                    "type": "string"
                },
                "standardCost": {
                    "type": "number"
                },
                "movingAverageCost": {
                    "type": "number"
                },
                "costCurrency": {
                    "type": "string"
                }
            }
        },
        "Carrier": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "url": {
                    "type": "string"
                },
                "scac": {
                    "type": "string"
                },
                "trackingUrl": {
                    "type": "string"
                },
                "primaryContact": {
                    "type": "string"
                },
                "primaryPhone": {
                    "type": "string"
                }
            }
        },
        "Supplier": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "primaryLocationId": {
                    "type": "string"
                },
                "primaryPhone": {
                    "type": "string"
                },
                "primaryContact": {
                    "type": "string"
                },
                "url": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                }
            }
        },
        "BOM": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "itemId": {
                    "type": "string"
                },
                "parentItemId": {
                    "type": "string"
                },
                "isAlternate": {
                    "type": "boolean"
                },
                "substituteFor": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "effectiveStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "effectiveEndDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "productionRelevant": {
                    "type": "boolean"
                }
            }
        },
        "DemandPlan": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "locationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "planCycle": {
                    "type": "string"
                },
                "planType": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "startDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "validFromDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "validToDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "Exception": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "description": {
                    "type": "string"
                },
                "category": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "reason": {
                    "type": "string"
                },
                "action": {
                    "type": "string"
                },
                "source": {
                    "type": "string"
                },
                "actionDetails": {
                    "type": "string"
                },
                "associatedObjectType": {
                    "type": "string"
                },
                "associatedObjectId": {
                    "type": "string"
                }
            }
        },
        "InventoryThreshold": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "siteLocationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "expectedLeadTime": {
                    "type": "number"
                },
                "daysOfSupplyUpperThreshold": {
                    "type": "number"
                },
                "daysOfSupplyLowerThreshold": {
                    "type": "number"
                },
                "targetDaysOfSupply": {
                    "type": "number"
                },
                "quantityUpperThreshold": {
                    "type": "number"
                },
                "quantityLowerThreshold": {
                    "type": "number"
                },
                "quantityUom": {
                    "type": "string"
                },
                "velocityCode": {
                    "type": "string"
                },
                "safetyStock": {
                    "type": "number"
                },
                "minSafetyStock": {
                    "type": "number"
                }
            }
        },
        "MfgOrder": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "workDescription": {
                    "type": "string"
                },
                "orderStatus": {
                    "type": "string"
                },
                "workLocationId": {
                    "type": "string"
                },
                "orderEntryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "salesOrderId": {
                    "type": "string"
                },
                "salesOrderLineNumber": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "notes": {
                    "type": "string"
                },
                "plannedStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "plannedEndDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualEndDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "LeadtimeVariant": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "facilityLocationId": {
                    "type": "string"
                },
                "timePeriod": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "meanValue": {
                    "type": "number"
                },
                "standardDeviation": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                }
            }
        },
        "Milestone": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "milestoneNumber": {
                    "type": "number"
                },
                "description": {
                    "type": "string"
                },
                "associatedObjectType": {
                    "type": "string"
                },
                "associatedObjectId": {
                    "type": "string"
                },
                "milestoneOwner": {
                    "type": "string"
                },
                "notes": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "plannedStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "plannedEndDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualEndDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "ProductSupplier": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "supplierId": {
                    "type": "string"
                },
                "supplierType": {
                    "type": "string"
                },
                "hasContract": {
                    "type": "number"
                },
                "unitPrice": {
                    "type": "number"
                },
                "currency": {
                    "type": "string"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "supplierStatus": {
                    "type": "string"
                },
                "leadTime": {
                    "type": "number"
                },
                "leadTimeUnit": {
                    "type": "string"
                },
                "effectiveStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "effectiveEndDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "SLA": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "productBrand": {
                    "type": "string"
                },
                "productFamily": {
                    "type": "string"
                },
                "operation": {
                    "type": "string"
                },
                "cycleTime": {
                    "type": "number"
                },
                "cycleTimeUnit": {
                    "type": "string"
                },
                "upperBound": {
                    "type": "number"
                },
                "lowerBound": {
                    "type": "number"
                },
                "boundUnit": {
                    "type": "string"
                }
            }
        },
        "SupplyPlan": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "locationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "planCycle": {
                    "type": "string"
                },
                "planType": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "startDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "validFromDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "validToDate": {
                    "type": "string",
                    "format": "date-time"
                }
            }
        },
        "ProductInventory": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "siteLocationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "locationNumber": {
                    "type": "string"
                },
                "lotNumber": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "quantityUom": {
                    "type": "string"
                },
                "storageDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "expirationDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                },
                "inventoryType": {
                    "type": "string"
                },
                "inventoryClass": {
                    "type": "string"
                },
                "inventoryValue": {
                    "type": "number"
                },
                "valueCurrency": {
                    "type": "string"
                },
                "quantityReserved": {
                    "type": "number"
                },
                "quantityReservedUom": {
                    "type": "string"
                }
            }
        },
        "PurchaseOrder": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "orderStatus": {
                    "type": "string"
                },
                "supplierId": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "requestedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "requestedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "orderPlacedDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "changeOrderDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "lastModifiedDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "shipToLocationId": {
                    "type": "string"
                },
                "orderValue": {
                    "type": "number"
                },
                "orderCurrency": {
                    "type": "string"
                },
                "dataSource": {
                    "type": "string"
                },
                "sourceOrderId": {
                    "type": "string"
                },
                "lineItems": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/PurchaseOrderLine"
                    }
                }
            }
        },
        "PurchaseOrderLine": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "lineNumber": {
                    "type": "string"
                },
                "purchaseOrderId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "quantity": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "value": {
                    "type": "number"
                },
                "requestedShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "requestedDeliveryDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "shipToLocationId": {
                    "type": "string"
                }
            }
        },
        "SalesShipment": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "substatus": {
                    "type": "string"
                },
                "customerID": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "weight": {
                    "type": "string"
                },
                "weightUom": {
                    "type": "string"
                },
                "hoursDelayed": {
                    "type": "number"
                },
                "trackStartDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "currentStatusCityName": {
                    "type": "string"
                },
                "notifyCarrier": {
                    "type": "integer",
                    "minimum": 0,
                    "maximum": 1
                },
                "carrierId": {
                    "type": "string"
                },
                "originLocationId": {
                    "type": "string"
                },
                "destinationLocationId": {
                    "type": "string"
                },
                "freightForwarder": {
                    "type": "string"
                },
                "billOfLandingNumber": {
                    "type": "string"
                },
                "shipmentCategory": {
                    "type": "string"
                },
                "carrierBookingNumber": {
                    "type": "string"
                },
                "masterAirWaybillNumber": {
                    "type": "string"
                },
                "parcelTrackingNumber": {
                    "type": "string"
                },
                "houseAirwayBill": {
                    "type": "string"
                },
                "externalShipmentID": {
                    "type": "string"
                },
                "carrierContainer": {
                    "type": "string"
                },
                "transportMode": {
                    "type": "string"
                },
                "shipperAccountNumber": {
                    "type": "string"
                },
                "shipperName": {
                    "type": "string"
                },
                "shippingCost": {
                    "type": "number"
                },
                "shippingCostCurrency": {
                    "type": "string"
                },
                "requestedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "estimatedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "updatedEta": {
                    "type": "string",
                    "format": "date-time"
                },
                "predictedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "deliveredDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "shipmentCreatedDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "recipientName": {
                    "type": "string"
                },
                "purchaseOrder": {
                    "type": "string"
                },
                "orderCreatedSource": {
                    "type": "string"
                },
                "cancelledDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "latestCoordinate": {
                    "type": "string"
                },
                "latestCoordinateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "inTransitLocation": {
                    "type": "string"
                },
                "parentShipmentId": {
                    "type": "string"
                },
                "lineItems": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/SalesShipmentLine"
                    }
                }
            }
        },
        "SalesShipmentLine": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "lineNumber": {
                    "type": "string"
                },
                "salesShipmentId": {
                    "type": "string"
                },
                "quantityShipped": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "value": {
                    "type": "number"
                },
                "valueCurrency": {
                    "type": "string"
                },
                "salesOrderId": {
                    "type": "string"
                },
                "salesOrderLineNumber": {
                    "type": "string"
                },
                "salesOrderLineId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                }
            }
        },
        "SupplyShipment": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "substatus": {
                    "type": "string"
                },
                "supplierId": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "weight": {
                    "type": "number"
                },
                "weightUom": {
                    "type": "string"
                },
                "hoursDelayed": {
                    "type": "number"
                },
                "trackStartDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "currentStatusCityName": {
                    "type": "string"
                },
                "notifyCarrier": {
                    "type": "integer",
                    "minimum": 0,
                    "maximum": 1
                },
                "carrierId": {
                    "type": "string"
                },
                "originLocationId": {
                    "type": "string"
                },
                "destinationLocationId": {
                    "type": "string"
                },
                "freightForwarder": {
                    "type": "string"
                },
                "billOfLandingNumber": {
                    "type": "string"
                },
                "shipmentCategory": {
                    "type": "string"
                },
                "carrierBookingNumber": {
                    "type": "string"
                },
                "masterAirWaybillNumber": {
                    "type": "string"
                },
                "parcelTrackingNumber": {
                    "type": "string"
                },
                "houseAirwayBill": {
                    "type": "string"
                },
                "externalShipmentID": {
                    "type": "string"
                },
                "carrierContainer": {
                    "type": "string"
                },
                "transportMode": {
                    "type": "string"
                },
                "shipperAccountNumber": {
                    "type": "string"
                },
                "shipperName": {
                    "type": "string"
                },
                "shippingCost": {
                    "type": "number"
                },
                "shippingCostCurrency": {
                    "type": "string"
                },
                "requestedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "committedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualShipDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "estimatedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "updatedEta": {
                    "type": "string",
                    "format": "date-time"
                },
                "predictedTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "actualTimeOfArrival": {
                    "type": "string",
                    "format": "date-time"
                },
                "deliveredDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "shipmentCreatedDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "recipientName": {
                    "type": "string"
                },
                "purchaseOrder": {
                    "type": "string"
                },
                "orderCreatedSource": {
                    "type": "string"
                },
                "cancelledDateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "latestCoordinate": {
                    "type": "string"
                },
                "latestCoordinateTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "inTransitLocation": {
                    "type": "string"
                },
                "parentShipmentId": {
                    "type": "string"
                },
                "lineItems": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/SupplyShipmentLine"
                    }
                }
            }
        },
        "SupplyShipmentLine": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "lineNumber": {
                    "type": "string"
                },
                "supplyShipmentId": {
                    "type": "string"
                },
                "quantityShipped": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "value": {
                    "type": "number"
                },
                "valueCurrency": {
                    "type": "string"
                },
                "purchaseOrderId": {
                    "type": "string"
                },
                "purchaseOrderLineNumber": {
                    "type": "string"
                },
                "purchaseOrderLineId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                }
            }
        },
        "ProductionCapacity": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "facilityId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "bandwidth": {
                    "type": "number"
                },
                "bandwidthUom": {
                    "type": "string"
                },
                "leadTime": {
                    "type": "number"
                },
                "leadTimeUom": {
                    "type": "string"
                },
                "unitCost": {
                    "type": "number"
                },
                "costCurrency": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                }
            }
        },
        "ShippingCost": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "originLocationId": {
                    "type": "string"
                },
                "destinationLocationId": {
                    "type": "string"
                },
                "productId": {
                    "type": "string"
                },
                "carrierId": {
                    "type": "string"
                },
                "transportationMode": {
                    "type": "string"
                },
                "shippingType": {
                    "type": "string"
                },
                "pricingType": {
                    "type": "string"
                },
                "unitCost": {
                    "type": "number"
                },
                "unitOfMeasure": {
                    "type": "string"
                },
                "costCurrency": {
                    "type": "string"
                },
                "effectiveStartDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "effectiveEndDate": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                }
            }
        },
        "issue": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "description": {
                    "type": "string"
                },
                "triggerType": {
                    "type": "string"
                },
                "triggerObjectId": {
                    "type": "string"
                },
                "impactedObjectType": {
                    "type": "string"
                },
                "impactedObjectId": {
                    "type": "string"
                },
                "severity": {
                    "type": "number"
                },
                "closeTime": {
                    "type": "string",
                    "format": "date-time"
                },
                "status": {
                    "type": "string"
                }
            }
        },
        "routeLeg": {
            "type": "object",
            "required": [
                "uid"
            ],
            "properties": {
                "uid": {
                    "type": "string"
                },
                "startLocationId": {
                    "type": "string"
                },
                "endLocationId": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "mode": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "route": {
                    "type": "string"
                },
                "network": {
                    "type": "string"
                },
                "leadTime": {
                    "type": "number"
                },
                "leadTimeUom": {
                    "type": "string"
                },
                "cost": {
                    "type": "number"
                },
                "costCurrency": {
                    "type": "string"
                }
            }
        }
    }
}
}

}
