FROM raffaelespazzoli/oracle-12c:12.1.0.2

MAINTAINER Raffaele Spazzoli <rspazzol@redhat.com>

ENV GRID_HOME=/opt/12.1.0/grid
    GRID_ORACLE_HOME=/opt/grid
    GRID_FILE1=linuxamd64_12102_grid_1of2.zip
    GRID_FILE2=linuxamd64_12102_grid_2of2.zip

RUN wget -O $INSTALL_DIR/$GRID_FILE1 http://rspazzol:8080/oracle-12c-rac/$GRID_FILE1 && \
    wget -O $INSTALL_DIR/$GRID_FILE2 http://rspazzol:8080/oracle-12c-rac/$GRID_FILE2 && \
    sudo -E -u oarcle unzip $INSTALL_DIR/$GRID_FILE1 && \
    sudo -E -u oarcle unzip $INSTALL_DIR/$GRID_FILE2 && \
    rpm -Uvh $INSTALL_DIR/grid/rpm/cvuqdisk-1.0.9-1.rpm