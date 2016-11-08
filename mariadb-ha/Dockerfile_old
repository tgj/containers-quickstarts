FROM million12/mariadb

RUN yum install -y bind-utils && yum clean all

COPY ./run.sh /
COPY ./fix-permissions.sh ./
COPY ./galera.cnf /etc/my.cnf.d

RUN chmod +x /run.sh /fix-permissions.sh

RUN ./fix-permissions.sh /var/lib/mysql/   && \
    ./fix-permissions.sh /var/run/ && \
    usermod -a -G root mysql

# Place VOLUME statement below all changes to /var/lib/mysql
VOLUME /var/lib/mysql

# By default will run as random user on openshift and the mysql user (997)
# everywhere else
USER 997

CMD ["./run.sh"]