#!/bin/bash

echo "Welcome to the InterSystems API Manager (IAM) test script."
echo "This script sets up a service and route in IAM to test that it successfully proxies requests to the InterSystems IRIS container."

# Check that ISC_IRIS_URL is set
if [[ -z "${ISC_IRIS_URL}" ]]; then
    echo "Environment variable ISC_IRIS_URL is undefined."
    exit 1
fi

tmp="I$(echo $ISC_IRIS_URL | cut -d"I" -f2-)"
irisnet="${tmp/\/api\/iam\/license/}"
irisurl=$(echo $irisnet | rev | cut -d"@" -f1 | rev)
iamadmin=8001
iamproxy=8000

echo -e "\nCreating a new service for InterSystems IRIS."
serviceexist=0
servicesjson=$(curl -s -X GET --url http://localhost:${iamadmin}/services/)
if [[ $servicesjson == *"test-iris"* ]]; then
    routesjson=$(curl -s -X GET --url http://localhost:${iamadmin}/services/test-iris/routes)
    routesarr=(${routesjson//created_at/ })
    numroutes=`expr ${#routesarr[@]} - 1`
    for (( i=1; i<=$numroutes; i++ )); do
        id=$(echo ${routesarr[$i]} | cut -f1 -d"{" | sed -n 's/.*"id":"\([^"]*\)"/\1/p' | cut -f1 -d",")
        curl -s -i -o /dev/null -X DELETE --url http://localhost:${iamadmin}/routes/$id
    done
    curl -s -i -o /dev/null -X DELETE --url http://localhost:${iamadmin}/services/test-iris
fi

C1=$(curl -s -i -w '%{response_code}' -o /dev/null -X POST --url http://localhost:${iamadmin}/services/ --data 'name=test-iris' --data 'url=http://'$irisurl)
if [ "$C1" -ne "201" ]; then
    echo 'Error creating service. HTTP Status Code: '$C1
    exit 1
else echo "Successfully created service!"
fi

echo -e "\nCreating a new route for the /api/atelier API."
C2=$(curl -s -i -w '%{response_code}' -o /dev/null -X POST --url http://localhost:${iamadmin}/services/test-iris/routes --data 'paths[]=/api/atelier' --data 'strip_path=false')
if [ "$C2" -ne "201" ]; then
    echo 'Error creating route. HTTP Status Code: '$C2
    exit 1
else echo "Successfully created route!"
fi

echo -e "\nSuccessfully created service and route!"
echo "To test that requests to IAM are successfully forwarded to InterSystems IRIS, run the following command:"
echo "curl -i -X GET --url http://localhost:${iamproxy}/api/atelier/ -u \"<Your InterSystems IRIS Username>:<Your InterSystems IRIS Password>\""