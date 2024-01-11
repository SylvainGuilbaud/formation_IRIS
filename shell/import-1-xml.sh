export filename="response-import-1-xml.json"
echo "deleting " $filename
rm -f $filename
curl -d "@../data/data-import-1.xml" \
-H "Content-Type: plain/text" \
-X POST http://localhost:52773/common/importxml \
-o $filename \
--user "_system:SYS"