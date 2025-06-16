"""
This script demonstrates how to interact with an InterSystems IRIS database using the `irisnative` Python module.
It provides functionality to:
- Connect to an InterSystems IRIS instance using native access.
- Retrieve and display the current version of InterSystems IRIS (incomplete in the provided code).
- Read and write values to IRIS globals, including storing and retrieving JSON-like objects.
- Set and retrieve a timestamp value in a specified global.
- Retrieve specific fields (e.g., "topic") from stored global entries by key.
- Optionally delete a global based on user confirmation.
Functions:
    getGlobalValue(iris, global_name, key):
        Retrieves and prints the value for a given key from a specified global.
    writeJSON(iris, global_name, data):
        Writes a dictionary as fields under a specified global and id.
Usage:
    - Prompts the user for a global name (default: "orders").
    - Demonstrates writing and reading data, including timestamps and sample data.
    - Asks the user if the global should be deleted at the end of the script.
Note:
    The retrieval of the IRIS version is incomplete and needs to be implemented.
"""

import datetime
print("Welcome to the InterSystems IRIS native connection example.")
print("This script will demonstrate how to connect to an InterSystems IRIS database using the irisnative module.")

# input server name and port
server = input("Enter the server name to connect to (default is localhost): ") or "localhost"
port = input("Enter the port (default is 1972): ") or 1972
# input namespace, username, and password
namespace = input("Enter the namespace (default is SC): ") or "SC"
username = input("Enter the username (default is _SYSTEM): ") or "_SYSTEM"
pw = input("Enter the password (default is SYS): ") or "SYS"
# Import the irisnative module
# Check if the irisnative module is installed
try:
    import irisnative
except ImportError:
    print("The irisnative module is not installed. Please install it using 'pip install irisnative'.")
    exit(1) 
    
# Make connection to InterSystems IRIS database using the input parameters
connection = irisnative.createConnection(server, port, namespace, username, pw)
print("You have successfully connected to InterSystems IRIS.")

# Create an InterSystems IRIS native connection object
iris = irisnative.createIris(connection)

# function to get the value of a global name 
def getGlobalValue(iris, global_name, key):
    value = iris.get(f"^{global_name}", key)
    if value is None:
        print(f"No value found for key '{key}' in global ^{global_name}.")
    else:
        print(f"Value for key '{key}' in global ^{global_name}: {value}")
    return value

# Write a JSON object to globals
def setGlobalValueFromJSON(iris, global_name, data):
    # if data starts with "order" then set a subscript "order" in the global
    print(f"Writing data to global ^{global_name} with id {data}")
    # if data[key] of type int or float or double, convert it to string
    for key in data:
        if isinstance(data[key], (int, float, complex)):
            data[key] = str(data[key])
    if "order_date" in data: 
        print(f"Writing orders data to global ^{global_name} with id {data['id']}")
        for key in data:
            if key == "id":
                iris.set(data["order_date"], f"^{global_name}", data["customer_id"], "orders", data["id"])
            elif key != "customer_id" and key != "order_date":
                iris.set(data[key], f"^{global_name}", data["customer_id"], "orders", data["id"],key) 
    else:
        print(f"Writing customer data to global ^{global_name} with id {data['id']}")
        for key in data:
            # if key="id", set the value as a field under the global name
            if key == "id":
                iris.set(data["created_at"], f"^{global_name}",data["id"])
            elif key != "created_at":
                iris.set(data[key], f"^{global_name}", data["id"],"data", key)
            
# set current timestamp in the IRIS global
def setCurrentTimestamp(iris, global_name, event):
    current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S.%f")
    iris.set(current_time, f"^{global_name}", 0,event)


customer1 = {
  "id": 1,
  "last_name": "Dupont",
  "first_name": "Sophie",
  "email": "sophie.dupont@email.com",
  "phone": "+33 6 12 34 56 78",
  "created_at": "2024-06-16T17:06:00+02:00",
  "active": 1
}

customer2 = {
  "id": 2,
  "last_name": "Durand",
  "first_name": "Jacques",
  "email": "jacques.durand@mymail.com",
  "phone": "+33 6 87 65 43 21",
  "created_at": "2024-06-17T10:15:00+02:00",
  "active": 1
}
  
order1 = {
  "id": 1,
  "customer_id": 1,
  "order_date": "2024-06-16T17:06:00+02:00",
  "status": "pending",
  "total_amount": 150.75
}
order2 = { 
  "id": 2,
  "customer_id": 1,
  "order_date": "2024-06-17T10:15:00+02:00",
  "status": "shipped",
  "total_amount": 89.99
}
order3 = {
  "id": 3,
  "customer_id": 2,
  "order_date": "2024-06-18T12:30:00+02:00",
  "status": "delivered",
  "total_amount": "200.00"
}
order4 = {
  "id": 4,
  "customer_id": 2,
  "order_date": "2024-06-19T14:45:00+02:00",
  "status": "cancelled",
  "total_amount": 50.00
}
order5 = {
  "id": 5,
  "customer_id": 1,
  "order_date": "2024-06-20T09:00:00+02:00",
  "status": "pending",
  "total_amount": 75.50
}
order6 = {
  "id": 6,
  "customer_id": 2,
  "order_date": "2024-06-21T11:30:00+02:00",
  "status": "shipped",
  "total_amount": 120.00
}

## input global name to write to :
global_name = input("Enter the global name to write to (default is customers): ") or "customers"
if global_name.startswith("^"):
    global_name = global_name[1:]  # Remove leading caret if present
    
## display the current timestamp from the IRIS global
getGlobalValue(iris,global_name, "start") 


## set the current timestamp in the IRIS global corresponding to the global name    
setCurrentTimestamp(iris, global_name, "begin")

## display the current timestamp from the IRIS global
getGlobalValue(iris,global_name, "timestamp")

# for loop on customers and orders to write the data to the global
for key in [customer1, customer2,order1, order2, order3, order4, order5, order6]:
    st = setGlobalValueFromJSON(iris, global_name, key)

    
# for loop on key=001 key=002 retrieve the value of topic   
for key in [1, 2]:
    value = iris.get(f"^{global_name}", key, "topic")
    print(f"Value for key '{key}' in global ^{global_name}: {value}")
    
setCurrentTimestamp(iris, global_name, "end")

# delete the global if the user confirms
delete_global = input(f"Do you want to delete the global ^{global_name}? (yes/no): ").strip().lower()
if delete_global == "yes":
    print(f"Deleting global ^{global_name}...")     
    iris.kill(f"^{global_name}")
    print(f"Global ^{global_name} deleted successfully.")
elif delete_global == "no":
    print(f"Global ^{global_name} will not be deleted.")
else:
    print("Invalid input. Global will not be deleted.")
    
