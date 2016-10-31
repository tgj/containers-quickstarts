FROM registry.access.redhat.com/rhel

COPY ./mariadb.repo /etc/yum.repos.d/

RUN yum update -y && yum install -y MariaDB-server MariaDB-client atomic-openshift-clients && yum clean all

CMD ["./run.sh"]