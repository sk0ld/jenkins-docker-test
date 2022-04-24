Simple example for interaction between jenkins and docker
=========

Short info
------------

Tested on Ubuntu 20.04


Jenkins was installed from repository

Dockerfile is used to create custom dev environment to build .war file with maven

Docker image: sk0ld/dev-alpine-mvn

Preparation of Jenkins to interact/build dockerfiles:

1) Install docker:
```
apt update && apt install -y docker.io
usermod -a -G docker jenkins
```

2) Change docker configuration:

edit /etc/systemd/system/multi-user.target.wants/docker.service
```
#ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock -H fd:// --containerd=/run/containerd/containerd.sock
```

3) Restart services:
```
service docker restart
systemctl daemon-reload && systemctl status docker
```

4) Don't forget to create Dockerhub credentials


5) To pull and run app image (port 8000 is used instead of default 8080):
```
docker pull sk0ld/custom-boxfuse:latest
docker run --rm -itd -p 8000:8080 --name appboxfuse sk0ld/custom-boxfuse
```

To access app:
```
http://your_ip_or_hostname:8000/hello-1.0/
```

6) To stop app:
```
docker container stop appboxfuse
```