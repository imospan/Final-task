#!/bin/bash

# Creating random Jenkins admin pass
password=`date |md5sum |cut -c '1-12'`
sleep 1


# update existing list of packages
sudo apt update -y

# install prerequisite packages
sudo apt install -y apt-transport-https ca-certificates software-properties-common
sudo apt install -y curl git

# add the GPG key for the official Docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"


# install Docker
sudo apt -y install docker-ce

# create a new directory inside your server to store the files
sudo mkdir -p $HOME/docker_jenkins

# navigate inside that directory
cd $HOME/docker_jenkins

# download Dockerfile, casc.yaml and plugins.txt
sudo curl -LJO https://raw.githubusercontent.com/imospan/Final-task/main/config/Dockerfile
sudo curl -LJO https://raw.githubusercontent.com/imospan/Final-task/main/config/casc.yaml
sudo curl -LJO https://raw.githubusercontent.com/imospan/Final-task/main/config/plugins.txt

# build a new image using Dockerfile
sudo docker build -t jenkins:jnks .

# run the new Jenkins image
sudo docker run --name jenkins -v jenkins-data:/var/jenkis_home -itd -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=$password jenkins:jnks 

# Save generated Jenkins admin pass to log file.
echo "Jenkins admin password: " $password >> jenkins_password.txt
