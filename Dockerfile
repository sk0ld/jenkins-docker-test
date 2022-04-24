FROM tomcat:8.5.13-jre8-alpine
RUN apk update
RUN apk --no-cache add openjdk8 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN apk --no-cache add docker --repository=http://ftp.halifax.rwth-aachen.de/alpine/v3.13/main
RUN apk add git maven
#WORKDIR /usr/share/app-src