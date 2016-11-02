FROM million12/mariadb

RUN yum install -y bind-utils && yum clean all
COPY ./run.sh /

CMD ["./run.sh"]