
FROM registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7

MAINTAINER Raffaele Spazzoli <rspazzol@redhat.com>

# Labels consumed by Red Hat build service
LABEL com.redhat.component="jenkins-slave-docker-rhel7-docker" \
      name="openshift3/jenkins-slave-docker-rhel7" \
      version="3.3" \
      architecture="x86_64" \
      release="4" \
      io.k8s.display-name="Jenkins Slave Docker" \
      io.k8s.description="The jenkins slave docker image has the docker tools on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,docker"

ENV MAVEN_VERSION=3.0.5

# Install Maven
RUN yum-config-manager --enable "rhel-7-server-rpms rhel-7-server-optional-rpms rhel-7-server-extras-rpms rhel-7-server-ose-3.3-rpms" && \
    INSTALL_PKGS="docker" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001