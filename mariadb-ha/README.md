# MySQL HA

This project shows how to build a mysql HA implementation in OpenShift.
We will use the mariadb form of MySQL and the galera project now part of mariadb
Here is the architecture of a MySQL Ha implementation with mariadb and galera.



<< add picture here>>

And here is how this can be implemented in OpenShift

<<add second picture here>>

Note: This project uses PetSets currently not in tech preview (i.e. not supported) in OpenShift.

## create the mariadb ha cluster in OpenShift

create a project

```
oc new-project mariadb-ha
```
create a new build with the maria db image

```
oc new-build https://github.com/raffaelespazzoli/containers-quickstarts#mariadb-ha --strategy=docker --context-dir=mariadb-ha --name=mariadb-ha
```
or using a binary build:
```
oc new-build --name=mariadb-ha --strategy=docker --binary=true
oc start-build mariadb-ha --from-dir=.
```

grant the default account edit privileges
```
oc policy add-role-to-user edit system:serviceaccount:mariadb-ha:default
```
deploy the mariadb in ha
```
oc create -f https://raw.githubusercontent.com/raffaelespazzoli/containers-quickstarts/mariadb-ha/mariadb-ha/mariadb-petset.yaml
```

## install a sample app to use the db

```
oc new-app openshift/jboss-eap70-openshift~https://github.com/raffaelespazzoli/openshift-quickstarts --context-dir=todolist/todolist-jdbc --name=todolist -e MYDB=java:jboss/jdbc/TodoListDS -e OPENSHIFT_KUBE_PING_NAMESPACE=mariadb-ha
oc expose service todolist
```
add limits and requests to the pod
```
oc patch dc/todolist -p '{ "spec": { "template": { "spec": { "containers": [ { "name": "todolist", "resources": { "limits": { "memory": "1024Mi", "cpu": "500m" }, "requests": { "memory": "512Mi", "cpu": "200m" } } } ] } } } }'
```
add autoscaling configuration
```
oc autoscale dc/todolist --min=2 --max=5 --cpu-percent=80
```

# generate load on the app

create the load generator
```
oc create configmap test-file --from-file=./locustfile.py
oc new-app hakobera/locust -e LOCUST_MODE=master -e TARGET_URL=http://todolist:8080 SCENARIO_FILE=/test/locustfile.py --name=locust
oc volume dc/locust --add -m /test --configmap-name=test-file
oc new-app hakobera/locust -e LOCUST_MODE=slave -e TARGET_URL=http://todolist:8080 SCENARIO_FILE=/test/locustfile.py -e MASTER_HOST=locust --name=locust-slave
oc volume dc/locust-slave --add -m /test --configmap-name=test-file
oc scale dc/locust-slave --replicas=3
oc expose service locust --port=8089
```

# use chaos monkey to kill db pods

```
oc create -f https://raw.githubusercontent.com/raffaelespazzoli/containers-quickstarts/mariadb-ha/mariadb-ha/chaos-monkey-2.2.149.json
oc new-app chaos-monkey --name=chaos-monkey --param='CHAOS_MONKEY_INCLUDES=mariadb-ha-*'
```
