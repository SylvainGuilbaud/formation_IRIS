export filename="../data/data-import.xml"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:12773/common/list/data.test/xml \
-o $filename \
--user "_system:SYS"
