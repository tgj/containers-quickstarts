#!/bin/bash


#If it's the first instance and there are no other instances running
if [ "$POD_NAME" == "mariadb-ha-1" && "`oc get endpoints mariadb-ha -o yaml | grep ip | wc -l`" -le "1"]
#then initialize the cluster
mysqld --wsrep-new-cluster
elif
#else join the cluster
mysqld --gcomm://mariadb-ha-1.mariadb-ha.$POD_NAMESPACE.svc.cluster.local,mariadb-ha-2.mariadb-ha.$POD_NAMESPACE.svc.cluster.local,mariadb-ha-3.mariadb-ha.$POD_NAMESPACE.svc.cluster.local,
fi