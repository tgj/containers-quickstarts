```
oc create -f https://raw.githubusercontent.com/raffaelespazzoli/containers-quickstarts/dind/dind/docker-is.yaml
oc create serviceaccount docker
oc adm policy add-scc-to-user privileged system:serviceaccount:`oc project -q`:docker
oc create -f https://raw.githubusercontent.com/raffaelespazzoli/containers-quickstarts/dind/dind/docker-dc.yaml
oc expose dc docker
oc new-build --code=https://github.com/raffaelespazzoli/containers-quickstarts#dind --context-dir=dind/jenkins-docker --strategy=docker --name=jenkins-slave-docker
```

skopeo

```
oc new-build --code=https://github.com/raffaelespazzoli/containers-quickstarts#dind --context-dir=dind/jenkins-skopeo --strategy=docker --name=skopeo-jenkins-slave
```