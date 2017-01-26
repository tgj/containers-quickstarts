# Rabbit MQ HA
https://www.rabbitmq.com/clustering.html
https://github.com/binarin/rabbit-on-k8s-standalone

#Autoclusterer Plugin

https://github.com/aweber/rabbitmq-autocluster/

```
oc create rabbitmq-ha
oc adm policy add-scc-to-user anyuid -z default
oc process -f https://raw.githubusercontent.com/openshift/origin/master/examples/etcd/template.json | oc create -f -
oc new-build --name=rabbitmq-autocluster --strategy=docker https://github.com/binarin/rabbit-on-k8s-standalone
oc create secret generic erlang.cookie --from-literal=erlang.cookie=secret
oc create -f rabbitmq.yaml


oc create -f rabbitmq-ha-svc.yaml
oc new-app aweber/rabbitmq-autocluster --name=rabbitmq -e AUTOCLUSTER_HOST=rabbitmq-ha -e AUTOCLUSTER_TYPE=dns
oc scale dc/rabbitmq --replicas=3
oc expose svc rabbitmq --port=15672

TODO : port the image to redhat, resolve the startup condition, demonstrate HA via simple app.

oc new-app --name rabbitmq --strategy=docker https://github.com/ghoelzer-rht/osev3-rabbitmq-rhel7
```

#Clusterer Plugin

https://github.com/rabbitmq/rabbitmq-clusterer

```
oc new-project rabbitmq-ha
oc new-build --strategy=docker --name=rabbitmq-clusterer https://github.com/MattFriedman/kubernetes-rabbitmq-clusterer
oc process -f clusterer-template.yaml ORDINAL=1 | oc create -f -
oc process -f clusterer-template.yaml ORDINAL=2 | oc create -f -
oc process -f clusterer-template.yaml ORDINAL=3 | oc create -f -
oc create -f clusterer-svc.yaml
oc rsh <pod-name> apply-cluster-config.sh
oc expose svc rabbitmq-svc --port=15672
```
##Inspecting the Clusterer Status

`rabbitmqctl cluster_status` presents basic information about
clusters, but does not interact with the Clusterer. `rabbitmqctl eval
'rabbit_clusterer:status().'`, on the other hand, does, and shows
which config is in operation by the node and what the Clusterer is
trying to do. If the cluster has been established then the command
will also display which nodes are known to be currently up and
running.

