#!/bin/bash
#by David Lee lijinquan997@gmail.com

# docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
systemctl start docker

# docker_compose
curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# add user to group docker
groupadd docker
gpasswd -a ${USER} docker

docker -v
docker-compose -v

