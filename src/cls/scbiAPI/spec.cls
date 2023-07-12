/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class scbiAPI.spec Extends %REST.Spec [ ProcedureBlock ]
{

XData OpenAPI [ MimeType = application/json ]
{
{
    "swagger": "2.0",
    "info": {
        "version": "1.0",
        "title": "IRIS Supply Chain Analytics API",
        "description": "API for InterSystems IRIS supply chain analytics",
        "contact": {
            "name": "Ming Zhou"
        }
    },
    "basePath": "/api/scbi/v1",
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
        "/kpi/definitions/{kpiName}": {
            "get": {
                "description": "Returns KPI definition of the specified KPI",
                "operationId": "GetKpiDefinition",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "kpiName",
                        "type": "string",
                        "required": true,
                        "description": "KPI name"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "KPI definition",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/KpiDefinition"
                            }
                        }
                    }
                }
            },
            "put": {
                "description": "Update a KPI definition",
                "operationId": "UpdateKpiDefinition",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "kpiName",
                        "type": "string",
                        "required": true,
                        "description": "Name of the KPI"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "description": "New KPI definition",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/KpiDefinition"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "KPI definition details",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/KpiDefinition"
                            }
                        }
                    },
                    "400": {
                        "description": "Invalid message body"
                    },
                    "404": {
                        "description": "KPI not found"
                    },
                    "500": {
                        "description": "Server error"
                    }
                }
            },
            "delete": {
                "description": "Delete a KPI definition",
                "operationId": "DeleteKpiDefinition",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "kpiName",
                        "type": "string",
                        "required": true,
                        "description": "KPI name"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "Success"
                    },
                    "404": {
                        "description": "KPI not found"
                    }
                }
            }
        },
        "/kpi/definitions": {
            "get": {
                "description": "Get all KPI definitions defined in the system\n",
                "operationId": "GetKpiDefinitions",
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
                "description": "Create a new KPI definition",
                "operationId": "CreateKpiDefinition",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/KpiDefinition"
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
        "/kpi/values/{kpiName}": {
            "get": {
                "description": "Returns KPI value of the specified KPI",
                "operationId": "GetKpiValue",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "kpiName",
                        "type": "string",
                        "required": true,
                        "description": "KPI name"
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
        "/kpi/listings/{kpiName}": {
            "get": {
                "description": "Returns source listing of a KPI",
                "operationId": "GetKpiListing",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "kpiName",
                        "type": "string",
                        "required": true,
                        "description": "KPI name"
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
        "/kpiissues": {
            "post": {
                "description": "Update issues for a given KPI",
                "operationId": "UpdateKpiIssues",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/kpiIssueMessage"
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
        "/closeissue/{issueId}": {
            "post": {
                "description": "close an issue",
                "operationId": "CloseIssue",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "Issue ID"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/closeMessage"
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
        "/completeissueworkflow/{issueId}": {
            "post": {
                "description": "Update the workflow with user input, and close the issue accordingly",
                "operationId": "CompleteWorkflow",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "KPI name"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/workflowMessage"
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
        "/runissueanalysis/{issueId}": {
            "post": {
                "description": "Run analysis for a given issue",
                "operationId": "RunIssueAnalysis",
                "produces": [
                    "application/json"
                ],
                "parameters": [
                    {
                        "in": "path",
                        "name": "issueId",
                        "type": "string",
                        "required": true,
                        "description": "Issue uid"
                    },
                    {
                        "in": "body",
                        "name": "body",
                        "required": false,
                        "schema": {
                            "$ref": "#/definitions/runMessage"
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
        }
    },
    "definitions": {
        "KpiDefinition": {
            "type": "object",
            "required": [
                "name"
            ],
            "properties": {
                "name": {
                    "type": "string"
                },
                "type": {
                    "type": "string"
                },
                "version": {
                    "type": "number"
                },
                "status": {
                    "type": "string"
                },
                "deepseeKpiSpec": {
                    "$ref": "#/definitions/DeepseeKpiSpec"
                }
            }
        },
        "KpiCubeDimension": {
            "type": "object",
            "required": [
                "name",
                "cubeDimension"
            ],
            "properties": {
                "name": {
                    "type": "string"
                },
                "cubeDimension": {
                    "type": "string"
                },
                "parent": {
                    "type": "string"
                }
            }
        },
        "DeepseeKpiSpec": {
            "type": "object",
            "required": [
                "namespace",
                "cube",
                "kpiConditions"
            ],
            "properties": {
                "namespace": {
                    "type": "string"
                },
                "cube": {
                    "type": "string"
                },
                "kpiDimensions": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/KpiCubeDimension"
                    }
                },
                "kpiMeasure": {
                    "type": "string"
                },
                "valueType": {
                    "type": "number"
                },
                "kpiConditions": {
                    "type": "array",
                    "items": {
                        "type": "string"
                    }
                }
            }
        },
        "kpiIssueMessage": {
            "type": "object",
            "required": [
                "kpi"
            ],
            "properties": {
                "kpi": {
                    "type": "string"
                }
            }
        },
        "workflowMessage": {
            "type": "object",
            "required": [
                "selectedOption"
            ],
            "properties": {
                "comment": {
                    "type": "string"
                },
                "selectedOption": {
                    "type": "string"
                }
            }
        },
        "closeMessage": {
            "type": "object",
            "required": [
                "comment"
            ],
            "properties": {
                "comment": {
                    "type": "string"
                }
            }
        },
        "runMessage": {
            "type": "object",
            "properties": {
                "processName": {
                    "type": "string"
                }
            }
        }
    }
}
}

}
