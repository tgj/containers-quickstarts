```
oc create -f https://raw.githubusercontent.com/raffaelespazzoli/containers-quickstarts/dind/dind/docker-is.yaml
oc create -f https://github.com/raffaelespazzoli/containers-quickstarts/blob/dind/dind/docker-dc.yaml
oc new-build --code=https://github.com/raffaelespazzoli/containers-quickstarts#dind --context-dir=dind/jenkins-docker --strategy=docker --name=jenkins-slave-docker