docker run -d --name irispreview$1 \
 -p 517$1:1972 \
 -p 527$1:52773 \
 -e IRIS_USERNAME=_SYSTEM \
 -e IRIS_PASSWORD=SYS \
 intersystemsdc/iris-community:preview
