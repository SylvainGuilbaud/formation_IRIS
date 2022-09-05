export filename="response-import-one-xml.json"
echo "deleting " $filename
rm -f $filename
curl -d "@response-export-by-id.xml" \
-H "Content-Type: plain/text" \
-X POST http://localhost:12773/common/importxml \
-o $filename \
--user "_system:SYS"