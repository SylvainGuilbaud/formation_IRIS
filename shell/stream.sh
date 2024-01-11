export filename="response-stream.pdf"
echo "deleting " $filename
rm -f $filename
curl \
-X GET http://localhost:52773/common/stream/data.test/1/BStream \
-o $filename \
--user "_system:SYS"