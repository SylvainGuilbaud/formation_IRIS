#!/bin/sh

echo "Welcome to the InterSystems IRIS and InterSystems API Manager (IAM) setup script."
echo "This script sets the ISC_IRIS_URL environment variable that is used by the IAM container to get the IAM license key from InterSystems IRIS."

until [[ "$correct" =~ ^[Yy] ]] || [[ "$correct" =~ ^[Yy][Ee][Ss] ]]; do

    echo "Enter the full image repository, name and tag for your IAM docker image: "
    read image
    echo 'Enter the IP address for your InterSystems IRIS instance. The IP address has to be accessible from within the IAM container, therefore, do not use "localhost" or "127.0.0.1" if IRIS is running on your local machine. Instead use the IP address of your local machine. If IRIS is running in a container, use the IP address of the host environment, not the IP address of the IRIS container: '
    read ip
    echo "Enter the web server port for your InterSystems IRIS instance: "
    read port
    while true; do
        echo "Enter the password for the IAM user for your InterSystems IRIS instance: "
        read -s pass1
        echo "Re-enter your password: "
        read -s pass2
        if [ "$pass1" = "$pass2" ]
        then break
        else echo "Passwords don't match."
        fi
    done

    echo 'If local policy requires that HTTPS be used for communication, please provide the full path to your CA Certificate file now. Otherwise hit "Return": '
    read cacertpath

    echo 'If your InterSystems IRIS instance is only accessible via its CSPConfigName URL prefix, please provide the prefix with a trailing slash (/) now. Otherwise hit "Return": '
    read pathprefix

    echo ""
    echo "Your inputs are:"
    echo "Full image repository, name and tag for your IAM docker image: $image"
    echo "IP address for your InterSystems IRIS instance: $ip"
    echo "Web server port for your InterSystems IRIS instance: $port" 
    echo "CA Certificate for HTTPS: $cacertpath"
    echo "CSPConfigName URL prefix: $pathprefix"

    while true; do
        echo "Would you like to continue with these inputs (y/n)? "
        read correct
        case $correct in
            [Yy] | [Yy][Ee][Ss] | [Nn] | [Nn][Oo]) break;;
            * ) echo "Please answer yes or no";;
        esac
    done

done

correct=""

echo "Getting IAM license using your inputs..."

if [[ -z "${cacertpath}" ]]; then
  irisurl="http://$ip:$port/${pathprefix}api/iam/license"
  keyresponse=$(curl -s -i -w '%{response_code}' -o /dev/null --max-time 7 -u IAM:$pass1 $irisurl)
else
  irisurl="https://$ip:$port/${pathprefix}api/iam/license"
  keyresponse=$(curl -s -i -w '%{response_code}' -o /dev/null --max-time 7 -u IAM:$pass1 --cacert ${cacertpath} $irisurl)
fi

if [ "$keyresponse" -ge "500" ]; then  
  echo "Internal server error when testing inputs."
elif [ "$keyresponse" -eq "404" ]; then
  echo "The /api/iam web application is disabled. Please enable it before running this script again."
elif [ "$keyresponse" -eq "401" ]; then
  echo "Authorization failed. Please make sure to enable the IAM user and reset its password before running this script again. This error may also mean that you entered the wrong password to this script."
elif [ "$keyresponse" -eq "400" ]; then
  echo "Request failed with a 400 status code. You may be trying to use HTTP on an SSL-enabled server port."
elif [ "$keyresponse" -eq "204" ]; then
  echo "No content. Either your InterSystems IRIS instance is unlicensed or your license key does not contain an IAM license."
elif [ "$keyresponse" -eq "000" ]; then
  echo "Couldn't reach InterSystems IRIS at $ip:$port. One or both of your IP and Port are incorrect."
else
  echo "Successfully got IAM license!"

  export ISC_IAM_IMAGE=$image
  export ISC_IRIS_URL="IAM:$pass1@$ip:$port/${pathprefix}api/iam/license"

  if [ "${cacertpath}" ]; then
    export ISC_CA_CERT=$(cat ${cacertpath})
  fi

  safepass=""
  for i in $(seq 1 ${#pass1}); do safepass="$safepass*"; done
  echo "The ISC_IRIS_URL environment variable was set to: IAM:$safepass@$ip:$port/${pathprefix}api/iam/license"
  echo "WARNING: The environment variable is set for this shell only!"
  echo "To start the services, run the following command in the scripts directory: docker compose up -d"
  echo "To stop the services, run the following command in the scripts directory: docker compose down"
  echo "URL for the IAM Manager portal: http://localhost:8002"
fi