```
oc new-project oracle-db
oc adm policy add-scc-to-user anyuid -z default
oc new-app --name=oracle-database sath89/oracle-12c
oc expose svc oracle-database --port 8080
```