```
oc create -f docker-is.yaml
oc create -f docker-dc.yaml
oc new-build --name=jenkins-slave-docker 