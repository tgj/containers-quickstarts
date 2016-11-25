```
oc new-build https://github.com/raffaelespazzoli/containers-quickstarts#datapower --context-dir=s2i-datapower --name=s2i-datapower --strategy=docker


 docker run --priviliged=true -it -v $PWD/config:/drouter/config -v $PWD/local:/drouter/local -e DATAPOWER_ACCEPT_LICENSE=true -e DATAPOWER_INTERACTIVE=true -p 9090:9090 -p 9022:22 -p 5554:5554 -p 8000-8010:8000-8010 --name idg ibmcom/datapower
``` 
 
#artifactory
https://www.jfrog.com/confluence/display/RTF/Running+Artifactory+OSS 
 
``` 
cat << EOF | oc create -f - 
{
  "apiVersion": "v1",
  "kind": "ServiceAccount",
  "metadata": {
    "name": "artifactory"
  }
}
EOF
cat << EOF  | oc create -f - -n artifactory
---
apiVersion: "v1"
kind: "PersistentVolumeClaim"
metadata:
  name: "artifactory-etc"
spec:
  accessModes:
    - "ReadWriteOnce"
  resources:
    requests:
      storage: "1Gi"
---
apiVersion: "v1"
kind: "PersistentVolumeClaim"
metadata:
  name: "artifactory-data"
spec:
  accessModes:
    - "ReadWriteOnce"
  resources:
    requests:
      storage: "1Gi"
EOF
oc adm policy add-scc-to-user anyuid -z artifactory -n artifactory
oc new-app --docker-image=docker.bintray.io/jfrog/artifactory-oss:latest --name=artifactory
oc patch dc/artifactory --patch '{"spec":{"template":{"spec":{"serviceAccountName": "artifactory"}}}}'
oc volume dc/artifactory --add -m /var/opt/jfrog/artifactory/data --claim-name=artifactory-data -n artifactory
oc volume dc/artifactory --add -m /var/opt/jfrog/artifactory/etc --claim-name=artifactory-etc -n artifactory
oc expose svc artifactory
```
add persistent storage

#cassandra
https://hub.docker.com/r/anderssv/openshift-cassandra/
```
oc policy add-role-to-user view system:serviceaccount:cassandra:default

cat << EOF | oc create -f -
apiVersion: v1
kind: Service
metadata:
  labels:
    app: cassandra
  name: cassandra
spec:
  ports:
    - port: 9042
  selector:
    app: cassandra
EOF

cat << EOF | oc create -f -
apiVersion: v1
kind: ReplicationController
metadata:
  name: cassandra
spec:
  replicas: 2
  template:
    metadata:
      labels:
        app: cassandra
    spec:
      containers:
        - command:
            - /run.sh
          resources:
            limits:
              cpu: 0.1
          env:
            - name: MAX_HEAP_SIZE
              value: 512M
            - name: HEAP_NEWSIZE
              value: 100M
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            - name: POD_IP
              valueFrom:
                fieldRef:
                  fieldPath: status.podIP
          image: anderssv/openshift-cassandra
          name: cassandra
          ports:
            - containerPort: 9042
              name: cql
            - containerPort: 9160
              name: thrift
          volumeMounts:
            - mountPath: /cassandra_data
              name: cassandra-data
      volumes:
        - name: cassandra-data
          emptyDir: {}
EOF
```
#datapower
```
cat << EOF | oc create -f - 
{
  "apiVersion": "v1",
  "kind": "ServiceAccount",
  "metadata": {
    "name": "datapower"
  }
}
EOF
oc adm policy add-scc-to-user anyuid -z datapower -n datapower-demo
oc new-app --docker-image=ibmcom/datapower:7.5.2.0.281259 -e DATAPOWER_ACCEPT_LICENSE=true -e DATAPOWER_WORKER_THREADS=4 --name=datapower
oc patch dc/datapower --patch '{"spec":{"template":{"spec":{"containers": [ {"name": "datapower"},{"ports": [ {"containerPort": "9090"},{"containerPort": "9022" },{"containerPort": "5554" } ,{"containerPort": "8000"}]}]}}}}'
oc patch dc/datapower --patch '{"spec":{"template":{"spec":{"serviceAccountName": "datapower"}}}}'
oc expose dc datapower
oc expose svc datapower --port=8000
```
