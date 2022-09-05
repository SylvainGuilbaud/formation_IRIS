export filename="../data/data-import.json"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:12773/common/list/data.test/json \
-o $filename \
--user "_system:SYS"