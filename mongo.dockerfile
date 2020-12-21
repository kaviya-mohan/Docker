#using ubuntu lastest version as Base Image
FROM ubuntu:latest

MAINTAINER kaviya "kaviyamohan01@gmail.com"

RUN ln -s /bin/true /bin/systemctl
RUN set -x \
        && apt-get update -y \
        && apt-get install -y wget \
        && apt-get install -y gnupg \
        && wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - \
        && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list \ 
        && apt-get update -y \
        && apt-get install -y mongodb-org \
        && echo "mongodb-org hold" | dpkg --set-selections \
        && echo "mongodb-org-server hold" | dpkg --set-selections \
        && echo "mongodb-org-shell hold" | dpkg --set-selections \
        && echo "mongodb-org-mongos hold" | dpkg --set-selections \
        && echo "mongodb-org-tools hold" | dpkg --set-selections \
        && mkdir -p /data/db

EXPOSE 27017

#Run the mongodb
CMD ["usr/bin/mongod"] 
