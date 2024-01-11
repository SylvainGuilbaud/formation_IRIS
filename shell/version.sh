export filename="response-version.json"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:52773/common/ \
-o $filename \
--user "_system:SYS"