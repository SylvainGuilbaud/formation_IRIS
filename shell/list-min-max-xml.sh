export filename="response-list-min-max.xml"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:12773/common/list/data.test/xml/3/3 \
-o $filename \
--user "_system:SYS"