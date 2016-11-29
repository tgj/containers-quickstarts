
FROM registry.access.redhat.com/openshift3/jenkins-slave-base-rhel7

MAINTAINER Raffaele Spazzoli <rspazzol@redhat.com>

# Labels consumed by Red Hat build service
LABEL com.redhat.component="jenkins-slave-skopeo-rhel7" \
      name="openshift3/jenkins-slave-skopeo-rhel7" \
      version="3.3" \
      architecture="x86_64" \
      release="4" \
      io.k8s.display-name="Jenkins Slave Skopeo" \
      io.k8s.description="The jenkins slave image has the skopeo tools on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,skopeo"

USER root

COPY /skopeo /usr/bin/

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001