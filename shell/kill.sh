export filename="response-kill.json"
echo "deleting " $filename
rm -f $filename
curl \
-X DELETE http://localhost:12773/common/kill/data.test \
-o $filename \
--user "_system:SYS"