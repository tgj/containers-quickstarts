

# experiment datapower locally
```
docker run --priviliged=true -it -v $PWD/config:/drouter/config -v $PWD/local:/drouter/local -e DATAPOWER_ACCEPT_LICENSE=true -e DATAPOWER_INTERACTIVE=true -p 9090:9090 -p 9022:22 -p 5554:5554 -p 8000-8010:8000-8010 --name idg ibmcom/datapower
```
 


# installing datapower on openshift


```
oc new-build https://github.com/raffaelespazzoli/containers-quickstarts#datapower --context-dir=s2i-datapower --name=s2i-datapower --strategy=docker
oc create service account datapower
oc adm policy add-scc-to-user anyuid -z datapower
oc new-app --docker-image=datapower/s2i-datapower -e DATAPOWER_ACCEPT_LICENSE=true -e DATAPOWER_WORKER_THREADS=4 --name=datapower
oc patch dc/datapower --patch '{"spec":{"template":{"spec":{"serviceAccountName": "datapower"}}}}'
oc expose svc datapower --port=8080
```

