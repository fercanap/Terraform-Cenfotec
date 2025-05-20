#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1


echo "Installing Docker..." >> /home/ubuntu/ilog

sudo apt update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

#sudo groupadd docker
#sudo usermod -aG docker ubuntu
#newgrp docker
echo "Docker Installed!" > /home/ubuntu/ilog

echo "Running container app..." > /home/ubuntu/ilog
docker run --restart always -dp 80:8080 --name dockerlabs cachac/dockerlabs:latest
echo "App ok!" > /home/ubuntu/ilog


