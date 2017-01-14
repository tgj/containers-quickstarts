# Rabbit MQ HA
https://www.rabbitmq.com/clustering.html
https://github.com/rabbitmq/rabbitmq-clusterer
https://github.com/aweber/rabbitmq-autocluster/
https://github.com/binarin/rabbit-on-k8s-standalone

```
oc create rabbitmq-ha
oc adm policy add-scc-to-user anyuid -z default
oc new-app --name etcd registry.access.redhat.com/rhel7/etcd
oc new-build --name=rabbitmq-autocluster --strategy=docker https://github.com/binarin/rabbit-on-k8s-standalone
oc create secret generic erlang.cookie --from-literal=erlang.cookie=secret
oc create -f rabbitmq.yaml

TODO : port the image to redhat, resolve the startup condition, demonstrate HA via simple app.

oc new-app --name rabbitmq --strategy=docker https://github.com/ghoelzer-rht/osev3-rabbitmq-rhel7
```