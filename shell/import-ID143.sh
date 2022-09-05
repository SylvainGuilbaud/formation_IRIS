export filename="response-import-ID143.json"
echo "deleting " $filename
rm -f $filename
curl -v -d "@../data/143.xml" \
-H "Content-Type: plain/text" \
-X POST http://localhost:12773/common/importxml \
-o $filename \
--user "_system:SYS"