Class temp.python 
{

/// This method doesn't return ByRef/Output parameters
ClassMethod production() As %Status [ Language = python ]
{
import os
# Set namespace the manual way
os.environ['IRISNAMESPACE'] = 'IRISAPP'

import iris

# TEST 1 with output variables
productionName, productionState = None, None
status = iris.cls('Ens.Director').GetProductionStatus(productionName, productionState) 
print("Status: {}".format(status))
print("Success? -- {}".format(productionState != None))
}

/// This method returns ByRef/Output parameters correctly through iris.ref
ClassMethod production2() As %Status [ Language = python ]
{
import os
# Set namespace the hard way
os.environ['IRISNAMESPACE'] = 'IRISAPP'

import iris

# TEST 2 with output variables
productionName, productionState = iris.ref('productionName'), iris.ref('productionState')
status = iris.cls('Ens.Director').GetProductionStatus(productionName, productionState) 

print("Status: {}".format(status))
# see .value
print("Production: {}".format(productionName.value))
# see .value
print("Production State: {}".format(productionState.value))
}

}
