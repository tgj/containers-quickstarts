
# create the base Oracle12c image

There is no efficient way of doing this as an ioenshift build. You have to run this on alocal instance of docker and the upload the resulting image to your openshift registry.

This build requires containers with at least 12GB, the deafult is 10GB
Add --storage-opt dm.basesize=15G to your docker daemon config
For it to take effect you also have to run
```
docker rm `docker ps -a -q` && docker rmi -f `docker images -q`
sudo systemctl stop docker
sudo rm -rf /var/lib/docker
sudo systemctl start docker
```
After this you can build the image, which requires a 12GB filesystem (make sure you have enough disk space).
Run this to serve large oracle installation files:
```
sudo setenforce 0 #Patch requested here.
docker run -p 8080:80 -v "$PWD":/usr/share/nginx/html:ro -d nginx:alpine
```
build the oracle base image
```
cd oracle-12c
#docker build --rm --build-arg FILESERVER=`hostname` -f Dockerfile.ee -t raffaelespazzoli/oracle-12c:12.1.0.2 .
docker build --rm -f Dockerfile.ee -t raffaelespazzoli/oracle-12c:12.1.0.2 .
```

build the oracle rac image
```
docker build --rm -t raffaelespazzoli/oracle-12c-rac:12.1.0.2 .
```

```
oc new-project oracle-db
oc adm policy add-scc-to-user anyuid -z default
oc new-app --name=oracle-database sath89/oracle-12c
oc expose svc oracle-database --port 8080
```