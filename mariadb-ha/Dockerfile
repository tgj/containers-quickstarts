FROM million12/mariadb

RUN yum install -y bind-utils && yum clean all
COPY ./run.sh /
RUN chmod +x /run.sh

CMD ["./run.sh"]