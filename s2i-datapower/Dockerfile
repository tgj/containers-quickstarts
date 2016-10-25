FROM ibmcom/datapower:7.5.2.0.281259

MAINTAINER Raffaele Spazzoli <rspazzol@redhat.com>

LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i \
      io.s2i.scripts-url=image:///usr/local/s2i \
      io.k8s.description="Platform for building and running IBM DataPower applications" \
      io.k8s.display-name="DataPower 7.5.2.0.281259" \
      io.openshift.expose-services="9090/tcp:http" \
      io.openshift.tags="runner, builder, datapower" \
      io.openshift.s2i.destination="/tmp"
      
ENV STI_SCRIPTS_PATH="/usr/local/s2i" \ 
    WORKDIR="/usr/local/workdir" \
    S2I_DESTINATION="/tmp" \
    DATAPOWER_WORKER_THREADS="4" \
    DATAPOWER_ACCEPT_LICENSE="true"

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/bin/ $STI_SCRIPTS_PATH 
COPY ./usr/bin/fixpermissions.sh /usr/bin 

RUN useradd -u 1001 -r -g 0 -s /sbin/nologin \
      -c "Default Application User" default && \
    mkdir -p $WORKDIR/local && \
    mkdir -p $WORKDIR/config && \
    chmod a+x /usr/bin/fixpermissions.sh
    chmod a+x $STI_SCRIPTS_PATH/*
    fixpermissions.sh $WORKDIR/local && \
    fixpermissions.sh $WORKDIR/config && \
    fixpermissions.sh drouter/local && \
    fixpermissions.sh drouter/config
   
WORKDIR $WORKDIR  
    
USER 1001

CMD ["$STI_SCRIPTS_PATH/run"]
