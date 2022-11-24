#!/bin/bash
sudo apt upgrade -y
sudo apt-get update -y && sudo snap install docker
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo docker run hello-world
sudo snap start docker
sudo usermod -aG docker ubuntu
docker run -p 8080:80 nginx
