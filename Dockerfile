# ARG IMAGE=irepo.intersystems.com/intersystems/iris-community:latest-cd
# ARG IMAGE=containers.intersystems.com/intersystems/irishealth-community:latest-preview
ARG IMAGE=containers.intersystems.com/intersystems/irishealth-community-arm64:latest-preview
# ARG IMAGE=intersystemsdc/irishealth-community:latest
# ARG IMAGE=intersystemsdc/iris-community:latest

FROM $IMAGE AS builder

USER root
# # Update package and install sudo
RUN apt-get update && apt-get install -y \
    python3-venv

USER ${ISC_PACKAGE_MGRUSER}
COPY .iris_init /home/irisowner/.iris_init

WORKDIR /home/irisowner/dev

ARG TESTS=0
ARG MODULE="formation-iris"
ARG NAMESPACE="IRISAPP"

## Embedded Python environment
ENV IRISUSERNAME "_SYSTEM"
ENV IRISPASSWORD "SYS"
ENV IRISNAMESPACE $NAMESPACE
ENV PYTHON_PATH=/usr/irissys/bin/
ENV PATH "/usr/irissys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/irisowner/bin"
ENV JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

RUN --mount=type=bind,src=.,dst=. \
    python3 -m venv ~/py_envs && \
    . ~/py_envs/bin/activate && \
    pip3 install -r requirements.txt && \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    iris merge IRIS merge.cpf && \
    # irispython iris_script.py && \
    ([ $TESTS -eq 0 ] || iris session iris -U $NAMESPACE "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
    iris stop IRIS quietly \
    cp ./swagger-ui/index.html /usr/irissys/csp/swagger-ui/index.html

FROM $IMAGE AS final
ADD --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} https://github.com/grongierisc/iris-docker-multi-stage-script/releases/latest/download/copy-data.py /home/irisowner/dev/copy-data.py
#ADD https://github.com/grongierisc/iris-docker-multi-stage-script/releases/latest/download/copy-data.py /home/irisowner/dev/copy-data.py

RUN --mount=type=bind,source=/,target=/builder/root,from=builder \
    cp -f /builder/root/usr/irissys/iris.cpf /usr/irissys/iris.cpf && \
    python3 /home/irisowner/dev/copy-data.py -c /usr/irissys/iris.cpf -d /builder/root/