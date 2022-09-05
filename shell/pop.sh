export filename="response-pop.json"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:12773/common/pop/data.test/$1 \
-o $filename \
--user "_system:SYS"