export filename="response-import-3-xml.json"
echo "deleting " $filename
rm -f $filename
curl -v -d "@../data/data-import-3.xml" \
-H "Content-Type: plain/text" \
-X POST http://localhost:52773/common/importxml \
-o $filename \
--user "_system:SYS"