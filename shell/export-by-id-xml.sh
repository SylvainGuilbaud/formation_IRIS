export filename="response-export-by-id.xml"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:12773/common/exportbyid/data.test/xml/$1 \
-o $filename \
--user "_system:SYS"