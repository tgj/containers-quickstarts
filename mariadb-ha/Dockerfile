FROM registry.access.redhat.com/rhel

COPY ./mariadb.repo /etc/yum.repos.d/

RUN yum update -y && yum install -y MariaDB-server MariaDB-client && yum clean

CMD ["./run.sh"]