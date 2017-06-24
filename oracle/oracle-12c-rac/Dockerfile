FROM FROM oraclelinux:7-slim

MAINTAINER Raffaele Spazzoli <rspazzol@redhat.com>

ENV GRID_HOME=/app/12.1.0/grid
    APP_HOME=/app/oracle
    GRID_FILE1=linuxamd64_12102_grid_1of2.zip
    GRID_FILE2=linuxamd64_12102_grid_2of2.zip
    
    
RUN useradd -g dba -G oinstall grid && \
    echo "grid\ngrid\n" | passwd grid && \
    usermod -g dba -G oinstall oracle && \
    echo "oracle\noracle\n" | passwd grid && \  
    mkdir -p /app/oracle && \ 
    mkdir -p /app/12.1.0/grid && \ 
    chown grid:dba /app && \ 
    chown grid:dba /app/oracle && \ 
    chown grid:dba /app/12.1.0 && \ 
    chown grid:dba /app/12.1.0/grid && \ 
    chmod -R g+w /app && \
	mkdir /u01 && \
	mkdir /u02 && \
	mkdir /u03 && \
	chown grid:dba /u01 && \
	chown grid:dba /u02 && \
	chown grid:dba /u03 && \
	chmod g+w /u01 && \
	chmod g+w /u02 && \
	chmod g+w /u03          

RUN wget -O $INSTALL_DIR/$GRID_FILE1 http://rspazzol:8080/oracle-12c-rac/$GRID_FILE1 && \
    wget -O $INSTALL_DIR/$GRID_FILE2 http://rspazzol:8080/oracle-12c-rac/$GRID_FILE2 && \
    sudo -E -u oarcle unzip $INSTALL_DIR/$GRID_FILE1 && \
    sudo -E -u oarcle unzip $INSTALL_DIR/$GRID_FILE2 && \
    rpm -Uvh $INSTALL_DIR/grid/rpm/cvuqdisk-1.0.9-1.rpm
    
VOLUME ["/u01","/u02","/u03"]    