# MySQL HA

This project shows how to build a mysql HA implementation in OpenShift.
We will use the mariadb form of MySQL and the galera project now part of mariadb
Here is the architecture of a MySQL Ha implementation with mariadb and galera.



<< add picture here>>

And here is how this can be implemented in OpenShift

<<add second picture here>>

Note: This project uses PetSets currently not in tech preview (i.e. not supported) in OpenShift.

## steps to recreate in OpenShift

create a project

```
oc new-project mariadb-ha
```
create a new build with the maria db image

```
oc new-build https://github.com/raffaelespazzoli/containers-quickstarts#mariadb-ha --strategy=docker --context-dir=mariadb-ha --name=mariadb-ha
```
deploy the mariadb in ha
```
oc create -f https://raw.githubusercontent.com/raffaelespazzoli/containers-quickstarts/mariadb-ha/mariadb-ha/mariadb-petset.yaml
```




