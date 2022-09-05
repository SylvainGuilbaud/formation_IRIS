export filename="response-version.json"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:12773/common/ \
-o $filename \
--user "_system:SYS"