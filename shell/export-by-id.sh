export filename="response-export-by-id.json"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:52773/common/exportbyid/data.test/json/3 \
-o $filename \
--user "_system:SYS"