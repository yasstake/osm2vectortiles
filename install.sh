
#apt-get update
wget -qO- https://get.docker.com/ | sh

curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod a+x  /usr/local/bin/docker-compose
